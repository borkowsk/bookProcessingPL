/// Color scales visualisation

/// 1D scale from black to color maintained from 1 to 3 equal color components
void scaleSimple(float startX,float startY,float swidth,float sheight,float step,boolean useRed,boolean useGreen,boolean useBlue,float alpha,color background) ///< Red x Blue scale
{
  if(background!=0) 
  {
    fill(background);noStroke();
    rect(startX,startY,swidth,sheight);
  }

  for(int x=(int)startX;x<startX+swidth;x+=step)
  {
    float col=map(x,startX,startX+swidth,0,255);
    fill(useRed?col:0,useGreen?col:0,useBlue?col:0,alpha);rect(x,startY,step,sheight);
  }
}

/// 2D scale maintained from 2 color components
void scaleRedBlue(float startX,float startY,float swidth,float sheight,float step,float defaultGreen,float alpha,color background) ///< Red x Blue scale
{
  if(background!=0) 
  {
    fill(background);noStroke();
    rect(startX,startY,swidth,sheight);
  }
  float def=defaultGreen;
  for(int x=(int)startX;x<startX+swidth;x+=step)
  {
    float red=map(x,startX,startX+swidth,0,255);
    
    if(defaultGreen==-1) def=red;
    
    for(int y=(int)startY;y<startY+sheight;y+=step)
    {
      float blue=map(y,startY,startY+sheight,0,255);
      
      if(defaultGreen==-2) def=blue;
      
      //stroke(red,def,blue,alpha);point(x,y);
      fill(red,def,blue,alpha);rect(x,y,step,step);
    }
  }
}

/// 2D scale maintained from 2 color components
void scaleGreenBlue(float startX,float startY,float swidth,float sheight,float step,float defaultRed,float alpha,color background) ///< Green x Blue scale
{
  if(background!=0) 
  {
    fill(background);noStroke();
    rect(startX,startY,swidth,sheight);
  }
  float def=defaultRed;
  for(int x=(int)startX;x<startX+swidth;x+=step)
  {
    float green=map(x,startX,startX+swidth,0,255);
    
    if(defaultRed==-1) def=green;
    
    for(int y=(int)startY;y<startY+sheight;y+=step)
    {
      float blue=map(y,startY,startY+sheight,0,255);
  
      if(defaultRed==-2) def=blue;
          
      //stroke(def,green,blue,alpha);point(x,y);
      fill(def,green,blue,alpha);rect(x,y,step,step);
    }
  }
}

/// 2D scale maintained from 2 color components
void scaleRedGreen(float startX,float startY,float swidth,float sheight,float step,float defaultBlue,float alpha,color background) ///< Red x Green scale
{
  if(background!=0) 
  {
    fill(background);noStroke();
    rect(startX,startY,swidth,sheight);
  }
  
  float def=defaultBlue;
  for(int x=(int)startX;x<startX+swidth;x+=step)
  {
    float red=map(x,startX,startX+swidth,0,255);
    
    if(defaultBlue==-1) def=red;
    
    for(int y=(int)startY;y<startY+sheight;y+=step)
    {
      float green=map(y,startY,startY+sheight,0,255);
      
      if(defaultBlue==-2) def=green;
      
      //stroke(red,green,def,alpha);point(x,y);
      fill(red,green,def,alpha);rect(x,y,step,step);
    }
  }
}
