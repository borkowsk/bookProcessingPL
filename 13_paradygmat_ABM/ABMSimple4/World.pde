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
  
  void update() //!< Aktualizacja świata metodą Monte Carlo, czyli krok symulacji.
  {
    int square=WSide*WSide;
    for(int i=0;i<square;i++)
    {
      int col=int(random(0,WSide));
      int row=int(random(0,WSide));
      if(plane[row][col]!=null)
      {
         plane[row][col].update();
         
         // Prośba o przeniesienie.
         int dcol,drow;
         switch( plane[row][col].direction ){
            case N:       dcol= 0; drow=-1; break;
            case NE:      dcol=+1; drow=-1; break;
            case E:       dcol=+1; drow= 0; break;
            case SE:      dcol=+1; drow=+1; break;
            case S:       dcol= 0; drow=+1; break;
            case SW:      dcol=-1; drow=+1; break;
            case W:       dcol=-1; drow= 0; break;
            case NW:      dcol=-1; drow=-1; break;
            case UNKNOWN: 
            default: dcol= 0; drow= 0; break;
            }
         
         // Pożądana pozycja.
         int ncol=(WSide+col+dcol)%WSide;
         int nrow=(WSide+row+drow)%WSide;
         
         // Akcja zależy od pustego miejsca w nowej pozycji.
         if(plane[nrow][ncol]==null)
         {
           plane[nrow][ncol]=plane[row][col]; // Do nowego miejsca.
           plane[row][col]=null; // Bardzo ważne: W normalnym świecie bilokacja nie jest dozwolona!
         }
         else
         {
           plane[row][col].interactionA(plane[nrow][ncol]);
         }
      }
    }  
  }
}

World theWorld=null; ///< Podczas konfiguracji inicjowana jest ta pojedyncza zmienna reprezentująca świat.
