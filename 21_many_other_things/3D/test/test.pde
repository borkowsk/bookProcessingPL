size(400, 400, P3D);
noStroke();
lights();

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
