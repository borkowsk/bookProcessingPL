/// Świat i jego dynamika (zmiana stanu).
/// @date 2026-06-12 (begin)
//*/////////////////////////////////////////////////////////////////////////////

class World
{
  Agent[][]  plane=new Agent[WSide][WSide]; //!< powierzchnia świata, na której „żyją” agenci.
  
  void initialise() //!< wstępne wypełnianie świata.
  {
    plane[WSide/2][WSide/2]=new Agent(); //!< Prawie tak proste, jak to tylko możliwe
  }
  
  void update() //!< Aktualizacja stanu świata, czyli krok symulacji.
  {
    // Wypełnimy to później.
  }
}

World theWorld=null; ///< Podczas konfiguracji inicjowana jest ta pojedyncza zmienna reprezentująca świat.
