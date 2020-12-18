//Import Libraries
// https://stackoverflow.com/questions/2668718/java-mouselistener
// See also https://github.com/processing/processing/wiki/Library-Basics
import processing.awt.PSurfaceAWT;
import javax.swing.JPanel;
import javax.swing.JFrame;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import processing.core.*;

//Declare Global Variables
PGraphics pg;
JFrame frame;
JPanel panel;

void setup()
{
  size(200, 200); 
  
  frame = (JFrame)((PSurfaceAWT.SmoothCanvas) getSurface().getNative()).getFrame();
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.setLayout(null);
  frame.addNotify();
  
  pg = createGraphics(width, height);
  
  JPanel panel = new JPanel() {
   @Override
     protected void paintComponent(Graphics graphics) {
     if (graphics instanceof Graphics2D) {
       Graphics2D g2d = (Graphics2D) graphics;
       g2d.drawImage(pg.image, 0, 0, null);
     }
   }
  };

  panel.addMouseListener(new MouseAdapter() {
    public void mouseClicked(MouseEvent e) {
      System.out.println("Clicked!");
    }
  }
  );

  frame.setContentPane(panel);  
}

void draw()
{
  if(mouseX!=0) {
   println(mouseX);
  }
  pg.beginDraw();
  pg.background(0, 0);
  pg.fill(0, 153, 204, frameCount%255);  
  pg.ellipse(frameCount%width, frameCount%height,180,360);
  pg.endDraw();
  frame.setBackground(new Color(0, 0, 0, 0));
}

void mousePressed() {
println(mouseX);  
}

void keyPressed() {
println(key); 

}
