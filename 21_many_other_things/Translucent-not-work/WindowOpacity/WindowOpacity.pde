// Both version not work properly in Processing 3
// https://forum.processing.org/two/discussion/11629/is-it-possible-to-make-a-transparent-window
import com.sun.awt.AWTUtilities;
 
void setup() {
  frame.removeNotify();
  frame.setUndecorated(true);
  AWTUtilities.setWindowOpacity(frame, 0.5f);
  frame.addNotify();
}

/* 
void setup() {
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.setOpacity(0.5f);
  frame.addNotify();
}
*/
