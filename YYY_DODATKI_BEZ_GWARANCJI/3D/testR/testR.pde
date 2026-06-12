void setup()
{
  size(600, 600, P3D);
  //noStroke();
  frameRate(400);
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
            cameraZ/2.0, 
            cameraZ*20.0 //How deep object is still randered.
            );
}

int i=0;
void draw()
{
  println(i);
  background(0);
  //lights();
  directionalLight(128, 128, 128, 0, 0, -1);
  pushMatrix();
  noStroke();
  translate(min(i,399),min(i,399),-i);
  sphere(150);
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
