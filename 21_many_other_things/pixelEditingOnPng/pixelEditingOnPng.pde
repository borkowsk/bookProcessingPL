//https://forum.processing.org/two/discussion/26317/pixeldensity-not-working-with-exported-application
PImage bgr;
PImage img;

void setup()
{
  color red   = color(255, 0, 0);
  bgr = loadImage("back.jpg");
  println("required size:",bgr.width,bgr.height);
  img = loadImage("Joan.png");
  println("required size:",img.width,img.height);
  size(1036, 795);
  background(0,0,128);
//tint(100, 100, 254, 200);  // Tint blue and set transparency
  image(bgr, 0, 0,width,height);
  makeTransparent( color(0, 255, 0) );
//makeTransparent( color(0),color(155) );
//BLEND - linear interpolation of colors: C = A*factor + B
//ADD - additive blending with white clip: C = min(A*factor + B, 255)
//SUBTRACT - subtractive blending with black clip: C = max(B - A*factor, 0)
//DARKEST - only the darkest color succeeds: C = min(A*factor, B)
//LIGHTEST - only the lightest color succeeds: C = max(A*factor, B)
//DIFFERENCE - subtract colors from underlying image.
//EXCLUSION - similar to DIFFERENCE, but less extreme.
//MULTIPLY - Multiply the colors, result will always be darker.
//SCREEN - Opposite multiply, uses inverse values of the colors.
//OVERLAY - A mix of MULTIPLY and SCREEN. Multiplies dark values, and screens light values.
//HARD_LIGHT - SCREEN when greater than 50% gray, MULTIPLY when lower.
//SOFT_LIGHT - Mix of DARKEST and LIGHTEST. Works like OVERLAY, but not as harsh.
//DODGE - Lightens light tones and increases contrast, ignores darks. Called "Color Dodge" in Illustrator and Photoshop.
//BURN - Darker areas are applied, increasing contrast, ignores lights. Called "Color Burn" in Illustrator and Photoshop.
  blend(img, 0, 0,img.width,img.height,0,0,width,height,BLEND);
}

void makeTransparent(color c)
{
  color transparent = color(0,0,0,0);
  img.loadPixels();
  int size=img.width*img.height;
  
  for(int i=0;i<size;i++)
  {
    if(img.pixels[i]==c)
    {
      img.pixels[i]=transparent;
      //print(".");
    }
  }
  img.updatePixels();
}

void makeTransparent(color c1,color c2)
{
  color transparent = color(0,0,0,0);
  img.loadPixels();
  int size=img.width*img.height;
  
  for(int i=0;i<size;i++)
  {
    if(c1 < img.pixels[i] && img.pixels[i] <c2)
    {
      img.pixels[i]=transparent;
      //print(".");
    }
  }
  img.updatePixels();
}

void draw()
{
  //tint(0, 153, 204, 128);  // Tint blue and set transparency
  //image(img, 0, 0);//
  //blend(img, 0, 0,img.width,img.height,0,0,width,height,ADD);
}
