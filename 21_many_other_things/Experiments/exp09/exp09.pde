//9. combining 2D and 3D drawing
//What if you want a 2D background behind a 3D sketch? Or put a 2D display on top of a 3D sketch? 
//If you try to do this, you will quickly find that the 3D settings make your life difficult. 
//The solution is to reset everything to basic 2D temporarily by placing the necessary code at the 
//beginning or end of the draw loop() respectively. 
//Different situations, will require slightly different solutions. 
//But useful techniques are disabling the depth test with hint, resetting the camera(), turning off the
//lights, and sometimes using pushMatrix and popMatrix. Check out the following non-runnable code snippet.
//https://amnonp5.wordpress.com/2012/01/28/25-life-saving-tips-for-processing/

void draw() {
  // 3D code
 
  hint(DISABLE_DEPTH_TEST);
  camera();
  noLights();
  // 2D code
  hint(ENABLE_DEPTH_TEST);
}
