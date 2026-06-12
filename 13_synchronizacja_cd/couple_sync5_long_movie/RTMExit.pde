/// Everything that needs to be done when the application is terminated.
//* CA: EXIT TEMPLATE
//*/////////////////////////////////////////////////////////////////////

/// Exit handler. Funkcja ta jest wywoływana zawsze po zamknięciu okna.
/// NOTE: In C++ translation it is "global" by default.
void exit()          
{
  noLoop();          // For to be sure...
  delay(100);        // możliwe jest zamknięcie okna, gdy draw() nadal działa!
                     // or something like that, which result as error.
  //write(world,modelName+"."+nf((float)StepCounter,5,5)); //end state of the system
  
  /*
  if(outstat!=null)
  {
    outstat.flush();  // Zapisuje pozostałe dane do pliku
    outstat.close();  // Kończy zapis i zamyka plik
  }
  */
  //if(WITH_VIDEO) 
          CloseVideo();    //Finalizacja eksportu wideo
  
  println("couple_sync5","said: Thank You!");
  
  super.exit();       //Co superklasa z biblioteki musi zrobić przy wyjściu.()
} 

//*//////////////////////////////////////////////////////////////////////////////////////////////
//*  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - CA (Cellular Automaton) TEMPLATE
//*  https://github.com/borkowsk/sym4processing
//*//////////////////////////////////////////////////////////////////////////////////////////////
