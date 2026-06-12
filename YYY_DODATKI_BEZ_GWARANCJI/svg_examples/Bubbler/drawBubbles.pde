/// An Array of Bubble objects
Bubble[] bubbles;

/// The size of the array of Bubble objects is determined 
/// by the total number of rows in the CSV
void makeBubbles() 
{
  minRed=Float.MAX_VALUE;maxRed=-Float.MAX_VALUE;
  minGreen=Float.MAX_VALUE;maxGreen=-Float.MAX_VALUE;
  minBlue=Float.MAX_VALUE;maxBlue=-Float.MAX_VALUE;
  minX=Float.MAX_VALUE;maxX=-Float.MAX_VALUE;
  minY=Float.MAX_VALUE;maxY=-Float.MAX_VALUE;
  minD=Float.MAX_VALUE;maxD=-Float.MAX_VALUE;
  
  bubbles = new Bubble[table.getRowCount()]; 

  // You can access iterate over all the rows in a table
  int rowCount = 0;
  for (TableRow row : table.rows()) {
    // You can access the fields via their column name (or index)
    String n = "";
    if(usedName) n=row.getString(CaseName);
    
    float x = row.getFloat(VarX);  if(Float.isNaN(x)) continue;
    float y = row.getFloat(VarY);  if(Float.isNaN(y)) continue;
    float d = 2;
    if(usedDiam) { d=row.getFloat(VarDiam); if(Float.isNaN(d)) continue; }
    
    float red=1;
    float green=1;
    float blue=1;
    if(usedRed)  { red=row.getFloat(VarRed);  if(Float.isNaN(red)) continue; }
    if(usedGreen){ green=row.getFloat(VarGreen); if(Float.isNaN(green)) continue; }
    if(usedBlue) { blue=row.getFloat(VarBlue); if(Float.isNaN(blue)) continue; }
    
    // Make a Bubble object out of the data read
    bubbles[rowCount] = new Bubble(x, y, d, n,red,green,blue);
    rowCount++;
  }
  // When all values are equal
  if(minRed==maxRed) {maxRed=minRed+1;}
  if(minGreen==maxGreen) {maxGreen=minGreen+1;}
  if(minBlue==maxBlue) {maxBlue=minBlue+1;}
  if(minX==maxX) {minX=maxX-1;}
  if(minY==maxY) {minY=maxY-1;}
  if(minD==maxD) {minD=maxD-1;}
}

int notDivRest(int dividend,int  dividerMin,int dividerMax) ///< Najwiekszy dzielnik bez reszty w danym zakresie
{
  int i=dividerMax;
  for(;i>dividerMin;i--)
  {
    if(dividend % i == 0 ) return i;
  }
  return dividerMin;
}

void drawBubbles() 
{
  background(255);
  noStroke();
      
  // Display all bubbles
  for (Bubble b : bubbles) 
  {
    if(b==null) continue;
    b.display();
    b.rollover(mouseX, mouseY,false);
  }

  // Display legend with color scales
  noStroke();
  fill(LEGEND_BACKGROUND);//LEGEND_BACKGROUND 144,111,144
  rect(width-reqLegend,0,reqLegend,height);
  
  fill(128);
  textAlign(LEFT,BOTTOM);
  text(nf(minX)+" "+VarX,0,height-reqStatus);
  textAlign(RIGHT,BOTTOM);
  text(nf(maxX)+" ",width-reqLegend,height-reqStatus);
  fill(255,0,0);
  textAlign(CENTER,TOP);
  text(nf(maxY),(width-reqLegend)/2,0);
  text(VarY,(width-reqLegend)/2,12);
  textAlign(CENTER,BOTTOM);
  text(nf(minY),(width-reqLegend)/2,height-reqStatus);
  
  float sdi=map(maxD,minD,maxD,2,BUBBLE_MAXDIAM);
  float sdj=map(maxD,minD,maxD,2,BUBBLE_VERDIAM);
  
  if(usedDiam)
  {
    fill(64); textAlign(CENTER,TOP);
    text("Diameter: "+VarDiam,width-reqLegend/2,0);  
    
    float scx=width-sdi/2;
    float scy=sdj/2;
    switch(DEF_BUBBLE_SHAPE){ //ellipse(width-sdi,sdi,sdi,sdi);
      default:  
      case Circle:  ellipse(scx,scy,sdi,sdj); break;
      case Triangle: {float halfi=sdi/2,halfj=sdj/2; triangle(scx,scy-halfj,scx-halfi,scy+halfj/2,scx+halfi,scy+halfj/2); } break;
      case Rect: {float halfi=sdi/2,halfj=sdj/2;rect(scx-halfi,scy-halfj,sdi,sdj);} break;
      case Diamond:{float halfi=sdi/2,halfj=sdj/2;quad(scx-halfi,scy,scx,scy+halfj,scx+halfi,scy,scx,scy-halfj);} break;
      }
    textAlign(RIGHT,TOP);
    text("max: "+nf(maxD),width-sdi,sdj);
    
    float sdimin=map(minD,minD,maxD,2,BUBBLE_MAXDIAM);
    ellipse(width-reqLegend+sdi,sdi,sdimin,sdimin);
    textAlign(LEFT,TOP);
    text("min: "+nf(minD),width-reqLegend+sdi,sdj);
  }
  
  // Color scales
  float colscaleBeg=sdj+2*TEXTSIZE; //Moving vertical start position
  float scaleSide=min(256,reqLegend);
  int badge=notDivRest(int(scaleSide),16,32);         //print(scaleSide,"/",badge,"=");
  badge=min(int(scaleSide/badge),int(BUBBLE_MAXDIAM));//println(badge);
    
  //1D scale
  if( (usedRed && !usedGreen && !usedBlue) //one component
  ||  (!usedRed && usedGreen && !usedBlue) //one component
  ||  (!usedRed && !usedGreen && usedBlue) //one component
  ||  (!usedRed && VarGreen.equals(VarBlue)) //two equal components
  ||  (!usedGreen && VarBlue.equals(VarRed)) //two equal components
  ||  (!usedBlue && VarRed.equals(VarGreen)) //two equal components
  ||  (usedRed && usedGreen && usedBlue && VarRed.equals(VarGreen) && VarGreen.equals(VarBlue) ) //three equal components
  )
  {
      fill(usedRed?255:0,usedGreen?255:0,usedBlue?255:0);
      textAlign(LEFT,TOP);text(VarRed+"-"+VarGreen+"-"+VarBlue,width-reqLegend,colscaleBeg);
      colscaleBeg+=TEXTSIZE;
      scaleSimple(width-reqLegend,colscaleBeg,scaleSide,scaleSide/2,
                        badge,
                   usedRed,usedGreen,usedBlue,BUBBLE_OPACITY,color(255));
      fill(255);
      textAlign(LEFT,BOTTOM);text(nf(min(usedRed?minRed:Float.MAX_VALUE,usedGreen?minGreen:Float.MAX_VALUE,usedBlue?minBlue:Float.MAX_VALUE)),
                                    width-reqLegend,colscaleBeg+scaleSide/2);
      fill(0);                              
      textAlign(RIGHT,BOTTOM);text(nf(max(usedRed?maxRed:-Float.MAX_VALUE,usedGreen?maxGreen:-Float.MAX_VALUE,usedBlue?maxBlue:-Float.MAX_VALUE)),
                                    width-reqLegend+scaleSide,colscaleBeg+scaleSide/2);           
      colscaleBeg+=scaleSide+TEXTSIZE;             
  }
  else // 2 or 3D color scales
  {
     // Is it enought vertical space? 
    if(usedRed && usedBlue && usedGreen
    && (3*scaleSide+32)> height-colscaleBeg) 
    {
      scaleSide=(int)((height-colscaleBeg)/3-32);
      badge=notDivRest(int(scaleSide),16,32);
      badge=min(int(scaleSide/badge),int(BUBBLE_MAXDIAM));
    }
  
    //Block for RED x BLUE
    if(usedRed && usedBlue && !VarRed.equals(VarBlue))
    {
      fill(255);     textAlign(CENTER,TOP);text(" x ",width-reqLegend+scaleSide/2,colscaleBeg);
      fill(0,0,255); textAlign(RIGHT,TOP); text(VarBlue,width-reqLegend+scaleSide,colscaleBeg);
      fill(255,0,0); textAlign(LEFT,TOP);  text(VarRed,width-reqLegend,colscaleBeg);
      colscaleBeg+=TEXTSIZE;
      float defaultGreen=0;
      if(usedGreen)
      if(VarGreen.equals(VarRed)) defaultGreen=-1;
      else if(VarGreen.equals(VarBlue)) defaultGreen=-2;
      else
      {
        int position=frameCount % (int)scaleSide; //print(position);
        defaultGreen=map(position,0,scaleSide,0,255); //println("->",defaultGreen);
        fill(0,defaultGreen,0);noStroke();
        triangle(width-reqLegend+position,colscaleBeg+scaleSide,width-reqLegend+position-2,colscaleBeg+scaleSide+10,
                                                                width-reqLegend+position+2,colscaleBeg+scaleSide+10);
        text(VarGreen+" ",width-reqLegend+position+2,colscaleBeg+scaleSide);
      } 
      scaleRedBlue(width-reqLegend,colscaleBeg,scaleSide,scaleSide,
                        badge,
                   defaultGreen,BUBBLE_OPACITY,color(255));
      fill(0);
      textAlign(LEFT,BOTTOM);text(nf(minRed),width-reqLegend,colscaleBeg+scaleSide);
      textAlign(RIGHT,BOTTOM);text(nf(maxRed),width-reqLegend+scaleSide,colscaleBeg+scaleSide);   
      fill(0,128,0);
      textAlign(CENTER,TOP);text(nf(minBlue),width-reqLegend+scaleSide/2,colscaleBeg);
      textAlign(CENTER,BOTTOM);text(nf(maxBlue),width-reqLegend+scaleSide/2,colscaleBeg+scaleSide);
      colscaleBeg+=scaleSide+TEXTSIZE;
    }
    
    //Block for BLUE x GREEN
    if(usedGreen && usedBlue && !VarGreen.equals(VarBlue))
    {
      fill(255);     textAlign(CENTER,TOP);text(" x ",width-reqLegend+scaleSide/2,colscaleBeg);
      fill(0,0,255); textAlign(RIGHT,TOP); text(VarBlue,width-reqLegend+scaleSide,colscaleBeg);
      fill(0,255,0); textAlign(LEFT,TOP);  text(VarGreen,width-reqLegend,colscaleBeg);
      colscaleBeg+=TEXTSIZE;
      float defaultRed=0;
      if(usedRed)
      if(VarRed.equals(VarGreen)) defaultRed=-1;
      else if(VarRed.equals(VarBlue)) defaultRed=-2;
      else
      {
        int position=frameCount % (int)scaleSide; //print(position);
        defaultRed=map(position,0,scaleSide,0,255); //println("->",defaultGreen);
        fill(defaultRed,0,0);noStroke();      
        triangle(width-reqLegend+position,colscaleBeg+scaleSide,width-reqLegend+position-2,colscaleBeg+scaleSide+10,
                                                                width-reqLegend+position+2,colscaleBeg+scaleSide+10);
        text(VarRed+" ",width-reqLegend+position+2,colscaleBeg+scaleSide);
      } 
      scaleGreenBlue(width-reqLegend,colscaleBeg,scaleSide,scaleSide,
                        badge,
                     defaultRed,BUBBLE_OPACITY,color(255));
      fill(0);
      textAlign(LEFT,BOTTOM);text(nf(minGreen),width-reqLegend,colscaleBeg+scaleSide);
      textAlign(RIGHT,BOTTOM);text(nf(maxGreen),width-reqLegend+scaleSide,colscaleBeg+scaleSide);   
      fill(128,0,0);
      textAlign(CENTER,TOP);text(nf(minBlue),width-reqLegend+scaleSide/2,colscaleBeg);
      textAlign(CENTER,BOTTOM);text(nf(maxBlue),width-reqLegend+scaleSide/2,colscaleBeg+scaleSide);
      colscaleBeg+=scaleSide+TEXTSIZE;
    }
    
    //Block for RED x GREEN
    if(usedRed && usedGreen && !VarGreen.equals(VarRed) )
    {
      fill(255);     textAlign(CENTER,TOP);text(" x ",width-reqLegend+scaleSide/2,colscaleBeg);
      fill(0,255,0); textAlign(RIGHT,TOP); text(VarGreen,width-reqLegend+scaleSide,colscaleBeg);
      fill(255,0,0); textAlign(LEFT,TOP);  text(VarRed,width-reqLegend,colscaleBeg);
      colscaleBeg+=TEXTSIZE;
      float defaultBlue=0;
      if(usedBlue)
      if(VarBlue.equals(VarRed)) defaultBlue=-1;
      else if(VarBlue.equals(VarGreen)) defaultBlue=-2;
      else
      {
        int position=frameCount % (int)scaleSide; //print(position);
        defaultBlue=map(position,0,scaleSide,0,255); //println("->",defaultGreen);
        fill(0,0,defaultBlue);noStroke();
        triangle(width-reqLegend+position,colscaleBeg+scaleSide,width-reqLegend+position-2,colscaleBeg+scaleSide+10,
                                                                width-reqLegend+position+2,colscaleBeg+scaleSide+10);
        text(VarBlue+" ",width-reqLegend+position+2,colscaleBeg+scaleSide);
      } 
  
      scaleRedGreen(width-reqLegend,colscaleBeg,scaleSide,scaleSide, 
                    badge,
                    defaultBlue,BUBBLE_OPACITY,color(255));  
      fill(0);
      textAlign(LEFT,BOTTOM);text(nf(minRed),width-reqLegend,colscaleBeg+scaleSide);
      textAlign(RIGHT,BOTTOM);text(nf(maxRed),width-reqLegend+scaleSide,colscaleBeg+scaleSide);   
      fill(0,0,128);
      textAlign(CENTER,TOP);text(nf(minGreen),width-reqLegend+scaleSide/2,colscaleBeg);
      textAlign(CENTER,BOTTOM);text(nf(maxGreen),width-reqLegend+scaleSide/2,colscaleBeg+scaleSide);
      colscaleBeg+=scaleSide+TEXTSIZE;
    }
  }
}
//*===========================================================================================================
/// "Bubbler" - Program do wizualizacji bąbelkowej
/// 2022 @link "https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI"
//*////////////////////////////////////////////////////////////////////////////////////////////////////////////
