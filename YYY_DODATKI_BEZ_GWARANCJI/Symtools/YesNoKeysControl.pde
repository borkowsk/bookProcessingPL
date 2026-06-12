/// Moduł sterowania symulacją.
/// @date 2026-06-12 (utworzono)
//*/////////////////////////////////////////////////////////////////////////////

void keyPressed() //"key pressed example" Zobacz: processing-3.5.4/modes/java/reference/keyPressed_.html
{
  if(key==ESC) key=0; //Nie wychodzić przez ESCAPE! 
  else
  if(key=='Q') key=ESC; // Exit on Q
}
