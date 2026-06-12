//12. take full screen screenshots
//If you only check out one code example, make sure it’s this one, it’s the most fun! It’s a quick ‘hack’ to get 
//a full screen screenshot. Really full screen, so not just the sketch’s window. 
//Click the mouse to toggle the quality (and speed). Check it out!
// note: For Processing 2.0 replace screen.width and screen.height by screenWidth and screenHeight respectively
// https://amnonp5.wordpress.com/2012/01/28/25-life-saving-tips-for-processing/
//
import java.awt.Robot;
import java.awt.Rectangle;
import java.awt.AWTException;
 
PImage screenshot;
boolean smoothOn;
int x,y;
 
void setup() {
  size(int(screenWidth*0.85),int(screen.height*0.85));
  frame.removeNotify();
  frame.setUndecorated(true);
}
 
void draw() {
  if (smoothOn) { smooth(); } else { noSmooth(); }
  screenshot();
  image(screenshot, 0, 0, width, height);
}
 
void screenshot() {
  try {
    Robot robot = new Robot();
    screenshot = new PImage(robot.createScreenCapture(new Rectangle(0,0,screen.width,screen.height)));
  } catch (AWTException e) { }
}
 
void mouseMoved(){
  x = int((float) mouseX/width * (screen.width - width));
  y = int((float) mouseY/height * (screen.height - height));
  x = int(x * 0.02 + frame.getLocation().x * 0.98);
  y = int(y * 0.02 + frame.getLocation().y * 0.98);
  frame.setLocation(x,y);
}
 
void mousePressed() {
  smoothOn = !smoothOn;
}
