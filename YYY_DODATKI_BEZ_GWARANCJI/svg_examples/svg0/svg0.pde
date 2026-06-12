import processing.svg.*;

public void settings()  {
    size(400, 400, SVG, "filename.svg");
}

void setup() {
}

void draw() {
  // Draw something good here
  line(0, 0, width/2, height);

  // Exit the program
  println("Finished.");
  exit();
}
