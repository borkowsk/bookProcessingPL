/// Everything that needs to be done when the application is terminated.
//* CA: EXIT TEMPLATE
//*/////////////////////////////////////////////////////////////////////

/// Exit handler. It is called whenever a window is closed.
/// NOTE: In C++ translation it is "global" by default.
void exit()          
{
  noLoop();          // For to be sure...
  delay(100);        // it is possible to close window when draw() is still working!
                     // or something like that, which result as error.
  //write(world,modelName+"."+nf((float)StepCounter,5,5));//end state of the system
  
  /*
  if(outstat!=null)
  {
    outstat.flush();  // Writes the remaining data to the file
    outstat.close();  // Finishes the file
  }
  */
  //if(WITH_VIDEO) 
          CloseVideo();    //Finalise of Video export
  
  println("couple_sync5","said: Thank You!");
  
  super.exit();       //What library superclass have to do at exit()
} 

//*//////////////////////////////////////////////////////////////////////////////////////////////
//*  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - CA (Cellular Automaton) TEMPLATE
//*  https://github.com/borkowsk/sym4processing
//*//////////////////////////////////////////////////////////////////////////////////////////////
