//Color line animation

void setup() {
  frameRate(32);
  size(256,300);
  //strokeWeight(3); //Uncoment this for test
}

int pos = 0;

void draw() 
{
  //background(128); //Uncoment this for test
  pos++;
  stroke(pos,50,50); // now color depends on position!
  line(pos, 20, pos, 280);
}
