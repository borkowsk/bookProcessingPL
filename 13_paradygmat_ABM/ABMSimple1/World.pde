/// Świat i jego dynamika (zmiana stanu).
/// @date 2026-06-12 (modyfikacja)
//*/////////////////////////////////////////////////////////////////////////////

class World
{
  Agent[][]  plane=new Agent[WSide][WSide]; //!< powierzchnia świata, na której „żyją” agenci.
  int        numberOfAgents=0;              //!< rzeczywista liczba agentów.
  
  void initialise() //!< wstępne wypełnianie świata
  {
    for(int row=0;row<WSide;row++)
     for(int col=0;col<WSide;col++)
      if(random(1.0)<Density) // Agenci znajdują się tylko w określonych miejscach.
      {
        plane[row][col]=new Agent();
        numberOfAgents++;
      }
  }
  
  void update() //!< Aktualizacja stanu świata, czyli krok symulacji.
  {
    for(int row=0;row<WSide;row++)
      for(int col=0;col<WSide;col++)
        if(plane[row][col]!=null)
          plane[row][col].update();
  }
}

World theWorld=null; ///< Podczas konfiguracji inicjowana jest ta pojedyncza zmienna reprezentująca świat.
