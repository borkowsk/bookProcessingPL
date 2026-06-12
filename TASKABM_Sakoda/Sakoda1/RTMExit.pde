void exit()          //Funkcja ta jest wywoływana zawsze po zamknięciu okna. 
{
  noLoop();          //For to be sure...
  delay(100);        //Można zamknąć okno, gdy draw() właśnie działa!
  //write(world,modelName+"."+nf((float)StepCounter,5,5)); //end state of the system
  
  if(outstat!=null)
  {
    outstat.flush();  // Zapisuje pozostałe dane do pliku
    outstat.close();  // Kończy zapis i zamyka plik
  }
  
  if(WITH_VIDEO) CloseVideo();    //Finalizacja eksportu wideo (jeśli działał)
  
  println(modelName,"said: Thank You!");
  super.exit();       //Co superklasa z biblioteki musi zrobić przy wyjściu.()
} 

//-/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - EXIT TEMPLATE
//-/////////////////////////////////////////////////////////////////////////////////////////
