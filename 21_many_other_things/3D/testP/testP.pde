void setup()
{
  size(400, 400, P3D);
  //noStroke();
  frameRate(300);
}

int i=0;
void draw()
{
  background(0);
  //lights();
  directionalLight(128, 128, 128, 0, 0, -1);
  pushMatrix();
  stroke(i,i,i);
  translate(min(i,399),min(i,399),-i);
  box(150,150,150);
  i++;
  popMatrix();
}

/*
pushMatrix();
translate(232, 192, -1000);
sphere(50);
stroke(0);
noFill();
box(150,150,1050);
popMatrix();

pushMatrix();
noStroke();
fill(255,0,0);
translate(0, 0, -500);
sphere(50);
popMatrix();
*/
