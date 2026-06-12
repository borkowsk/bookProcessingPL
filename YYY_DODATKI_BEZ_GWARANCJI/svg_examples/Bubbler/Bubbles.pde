/// A Bubble class "static" settings
enum  BubbShape { Circle,Rect,Diamond,Triangle }
BubbShape DEF_BUBBLE_SHAPE=BubbShape.Rect;

//float BUBBLE_OPACITY=255;
//float BUBBLE_MAXDIAM=24;
//float BUBBLE_VERDIAM=48;

float minRed=Float.MAX_VALUE,maxRed=-Float.MAX_VALUE;
float minGreen=Float.MAX_VALUE,maxGreen=-Float.MAX_VALUE;
float minBlue=Float.MAX_VALUE,maxBlue=-Float.MAX_VALUE;
float minX=Float.MAX_VALUE,maxX=-Float.MAX_VALUE;
float minY=Float.MAX_VALUE,maxY=-Float.MAX_VALUE;
float minD=Float.MAX_VALUE,maxD=-Float.MAX_VALUE;

/// A Bubble class definition
class Bubble {
  float red;
  float green;
  float blue;
  float x;
  float y;
  float diameter;
  String name;
  BubbShape shape=DEF_BUBBLE_SHAPE;
  
  boolean over = false;
  boolean prin = false;
  
  /// Create  the Bubble (constructor)
  Bubble(float x_, float y_,float dia_,String s,float R_,float G_,float B_) 
  {
    name = s;
    
    x = x_; if(x>maxX) maxX=x; if(x<minX) minX=x;
    y = y_; if(y>maxY) maxY=y; if(y<minY) minY=y;
    diameter = dia_; if(diameter>maxD) maxD=diameter; if(diameter<minD) minD=diameter;
    
    red=R_;  if(red>maxRed) maxRed=red;         if(red<minRed) minRed=red;
    green=G_;if(green>maxGreen) maxGreen=green; if(green<minGreen) minGreen=green;
    blue=B_; if(blue>maxBlue) maxBlue=blue;     if(blue<minBlue) minBlue=blue;
  }
  
  /// Checking if mouse is over the Bubble
  void rollover(float px, float py,boolean withPrint) 
  {
    float scx=map(x,minX,maxX,0,width-reqLegend);
    float scy=height-reqStatus-map(y,minY,maxY,0,height-reqStatus);
    float sdi=map(diameter,minD,maxD,2,20);
    float d = dist(px,py,scx,scy);
    if (d < sdi/2) {
      over = true;
      if(withPrint) prin=true;
    } else {
      over = false;
    }
  }
  
  /// Display the Bubble
  void display() 
  {
    float scx=map(x,minX,maxX,0,width-reqLegend);
    float scy=height-reqStatus-map(y,minY,maxY,0,height-reqStatus);
    float sdi=map(diameter,minD,maxD,2,BUBBLE_MAXDIAM);
    float sdj=map(diameter,minD,maxD,2,BUBBLE_VERDIAM);
    float sred=map(red,minRed,maxRed,0,255);
    float sgreen=map(green,minGreen,maxGreen,0,255);
    float sblue=map(blue,minBlue,maxBlue,0,255);
    
    fill(sred,sgreen,sblue,BUBBLE_OPACITY);
    
    switch(shape){
    default:  
    case Circle:  ellipse(scx,scy,sdi,sdj); break;
    case Triangle: {float halfi=sdi/2,halfj=sdj/2; triangle(scx,scy-halfj,scx-halfi,scy+halfj/2,scx+halfi,scy+halfj/2); } break;
    case Rect: {float halfi=sdi/2,halfj=sdj/2;rect(scx-halfi,scy-halfj,sdi,sdj);} break;
    case Diamond:{float halfi=sdi/2,halfj=sdj/2;quad(scx-halfi,scy,scx,scy+halfj,scx+halfi,scy,scx,scy-halfj);} break;
    }
    
    if (over) {
      fill(sred,sgreen,sblue);
      textAlign(CENTER);
      text((usedName?"'"+name+"'\n":"")+"x:"+nf(x)+",y:"+nf(y)+(usedDiam?",d:"+nf(diameter):""),scx,scy+sdi/2+20);
      
      if(prin)
      {
        println(frameCount,")");
        if(usedName)println("'"+name+"'");
        println("x:"+VarX+"\t=\t",x);
        println("y:"+VarY+"\t=\t",y);
        if(usedDiam) println("d:"+VarDiam+"\t=\t",diameter);
        if(usedRed) println("R:"+VarRed+"\t=\t",red);
        if(usedGreen) println("G:"+VarGreen+"\t=\t",green);
        if(usedBlue) println("B:"+VarBlue+"\t=\t",blue);
        prin=false;
      }
    }
  }
}
//*===========================================================================================================
/// "Bubbler" - Program do wizualizacji bąbelkowej
/// 2022 @link "https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI"
//*////////////////////////////////////////////////////////////////////////////////////////////////////////////
