/// Everything that needs to be done when the application is terminated.
//* CA: EXIT TEMPLATE
//*/////////////////////////////////////////////////////////////////////

/// Exit handler. It is called whenever a window is closed.
/// NOTE: In C++ translation it is "global" by default.
void exit()          
{
  noLoop();          //To be sure / dla pewności ;-)
  delay(100);        // it is possible to close window when draw() is still working!
                     // or something like that, which result as error.

  CloseVideo();      //Finalise of Video export
  
  println("Symulacja","\nmówi:\n","'Thank You!'");
  
  super.exit();       //What library superclass have to do at exit()
} 

//*//////////////////////////////////////////////////////////////////////////////////////////////
//*  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - CA (Cellular Automaton) TEMPLATE
//*  https://github.com/borkowsk/sym4processing
//*//////////////////////////////////////////////////////////////////////////////////////////////
