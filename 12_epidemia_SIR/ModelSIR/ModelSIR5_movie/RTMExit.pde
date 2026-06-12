/// Wszystko, co należy zrobić przy zamknięciu aplikacji.
//* CA: EXIT TEMPLATE
//*/////////////////////////////////////////////////////////////////////

/// Exit handler. Funkcja ta jest wywoływana zawsze po zamknięciu okna.
/// UWAGA: W tłumaczeniu C++ domyślnie jest to „globalne”.
void exit()          
{
  noLoop();          // Dla pewności...
  delay(100);        // możliwe jest zamknięcie okna, gdy draw() nadal działa!
                     // lub zdarza się coś w tym stylu, co skutkuje błędem.
  //write(world,modelName+"."+nf((float)StepCounter,5,5)); //stan końcowy systemu
  
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
