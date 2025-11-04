//Parametr losowania 
int W=600;

int radius()
{
  return int(random(W/10));
}

//Initialisation
void setup()
{
  size(600,600); //Musi być jak W
  //frameRate(100);
}

//Running - visualisation and dynamics
void draw()
{
  fill(random(255),random(255),random(255),random(255));
  float r=radius();
  ellipse(random(W),random(W),r,r);
  //println(frameRate);
}
