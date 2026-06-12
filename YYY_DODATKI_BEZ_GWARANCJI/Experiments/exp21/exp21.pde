//21. breakShape
//Disclaimer! breakShape has been undocumented, mysterious and unsupported ever since 
//I started using Processing. But it’s still there hidden in the source code. 
//Maybe this will change with Processing 2.0. But for now let me just mention this function
//that can create holes in a beginShape-endShape. 😉
// https://amnonp5.wordpress.com/2012/01/28/25-life-saving-tips-for-processing/
//
void setup() {
  size(400, 400);
  smooth();
}
 
void draw() {
  background(255);
  fill(255, 0, 0);
  ellipse(width/2, height/2, 200, 200);
  fill(255, 255, 0);
  beginShape();
  vertex(0, 0);
  vertex(width, 0);
  vertex(width, height);
  vertex(0, height);
  vertex(0, 0);
  breakShape();
  vertex(mouseX-100, mouseY-100);
  vertex(mouseX-100, mouseY+100);
  vertex(mouseX+100, mouseY+100);
  vertex(mouseX+100, mouseY-100);
  endShape(CLOSE);
}
