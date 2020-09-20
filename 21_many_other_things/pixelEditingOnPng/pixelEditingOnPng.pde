//https://forum.processing.org/two/discussion/26317/pixeldensity-not-working-with-exported-application
PImage bgr;
PImage img;



void setup()
{
  bgr = loadImage("back.jpg");
  println("required size:",bgr.width,bgr.height);
  img = loadImage("Joan.png");
  println("required size:",img.width,img.height);
  size(1036, 791);
  background(128,0,128);
  image(bgr, 0, 0,width,height);
  processImg();
}

void processImg()
{
  color green = color(0, 255, 0);
  color transparent = color(0,0,0,0);
  img.loadPixels();
  int size=img.width*img.height;
  for(int i=0;i<size;i++)
  {
    if(img.pixels[i]==green)
    {
      img.pixels[i]=transparent;
      //print(".");
    }
  }
  img.updatePixels();
}

void draw()
{
  image(img, 0, 0);//blend?
}
