//Przykład z forum. Działa w Rocessing 4
//W systemie POP_OS 22.04 Processing 3 ma błąd: "Profile GL4bc is not available on X11GraphicsDevice"
int cols, rows;
int scl = 20;
int w = 2000;
int h = 1600;
 
float flying = 0;
 
float[][] terrain;

void settings() {
  println("Initialising 3D graphix...");
  size(600, 600, P3D);
  // https://github.com/processing/processing/issues/5476
  //PJOGL.profile = 4; // Nie pomaga
  println("DONE");
}
 
void setup() {
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
  
  float yoff = 0.2;
  for (int y=0; y<rows; y++) {
    float xoff = 0;
    for (int x=0; x<cols; x++) {
      terrain[x][y] = map(noise(xoff,yoff),0,1,-100,100);
      xoff +=0.1;
    }    
    yoff+=0.1;
  }
  
  frameRate(100);
}

void draw() {
  background(0);
  fill(255,random(55)+100,0);
  //directionalLight(204, 204, 204, .5, 0, -1);
  //emissive(0, 26, 51);
  sphere(50);
  noFill();
  translate(width/2, height/2);
  rotateX(PI/3);
  
  translate(-w/2, -h/2);
  noStroke();
  fill(255);
  
  for (int y=0; y<rows-1; y++) 
  {
    beginShape(TRIANGLE_STRIP);
    for (int x=0; x<cols; x++) 
    {
     stroke(random(256),0,random(256));
     //fill(random(256),random(256),0);
     vertex(x*scl, y*scl, terrain[x][y]);
     vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
     //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }
}
