import java.awt.*;
import javax.swing.JFrame;
 
JFrame topFrame = null;
PGraphics pg3D;
int framePosX;
int framePosY;
int frameWidth = 500;
int frameHeight = 500; 
 
void setup() {
  size(500, 500);
  framePosX = displayWidth/2;
  framePosY = displayHeight/2;
  pg3D = createGraphics(frameWidth, frameHeight);
}

void draw() {
  background(0, 0, 0, 0);
  noFill();
  rect(0, 0, frameWidth, frameHeight);
  pg3D.beginDraw();
  pg3D.background(0, 0, 0, 0);
  pg3D.fill(255, 0, 0); 
  pg3D.ellipse(mouseX, mouseY, 50, 50);
  pg3D.endDraw();
  image(pg3D, 0, 0);
  frame.setVisible(false);
  topFrame.add(this);
}
 
 
void init() {
  frame.removeNotify();
  frame.setUndecorated(true); 
  frame.setOpacity(0.0f);
 
  GraphicsConfiguration translucencyCapableGC;
  translucencyCapableGC = GraphicsEnvironment.getLocalGraphicsEnvironment().getDefaultScreenDevice().getDefaultConfiguration();
  topFrame = new JFrame(translucencyCapableGC);
  topFrame.removeNotify();
  topFrame.setUndecorated(true); 
  topFrame.setSize(frameWidth, frameHeight);
  topFrame.setBackground(new Color(0, 0, 0, 0));
  topFrame.setVisible(true); 
  topFrame.addNotify();
  super.init();
  g.format = ARGB;
  g.setPrimary(false);
}
