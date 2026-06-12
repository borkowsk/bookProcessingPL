/// Prosty przykład modelu agentowego.
/// @date 2026-06-12 (modyfikacja)
//*/////////////////////////////////////////////////////////////////////////////

void setup()
{
  size(1000,1020);
  
  theWorld=new World();
  theWorld.initialise();
  
  frameRate(DEFAULT_FRAME_RATE);
  println(Model,"Ready!");
}

void draw()
{
  background(128);
  
  census(theWorld);
  visualise(theWorld);
  theWorld.update();
  
  text(str(frameCount)+"("+str(frameRate)+")",3,height-3); // 3 piksele marginesu.
}

void exit()
{
  println("The end");
  super.exit();
}
