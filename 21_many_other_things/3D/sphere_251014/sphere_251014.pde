void setup() {
  size(300, 300, P3D); 
}

void draw() {
  background(200);
  stroke(255, 50);
  translate(150,150, 0);
  rotateX(mouseY * 0.05);
  rotateY(mouseX * 0.05);
  fill(mouseX * 2, 0, 160);
  sphereDetail(mouseX / 4);
  sphere(80);
}
