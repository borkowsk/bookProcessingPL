import java.awt.MenuBar;
import java.awt.Menu;
import java.awt.MenuItem;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import processing.awt.PSurfaceAWT;
 
void setup() {
  size(200,50);
  MenuBar myMenu = new MenuBar();
  Menu fileMenu = new Menu("File");
  myMenu.add(fileMenu);
  MenuItem closeItem=new MenuItem("Close");
  closeItem.addActionListener(new ActionListener() {
        public void actionPerformed(ActionEvent ev) {
                System.exit(0);
            }
          } 
        );
  fileMenu.add(closeItem);
  PSurfaceAWT awtSurface = (PSurfaceAWT)surface;
  PSurfaceAWT.SmoothCanvas smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();
  smoothCanvas.getFrame().setMenuBar(myMenu);
}
 
void draw() {
  background(128);
  line(0,0,width,height); //Widać że nie uwzględnia wysokości `menuBar`-a
}
