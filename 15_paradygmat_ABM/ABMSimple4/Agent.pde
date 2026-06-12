/// Agent: jego atrybuty, losowa inicjalizacja i metody
/// @date 2026-06-12 (modyfikacja)
//*/////////////////////////////////////////////////////////////////////////////

enum Dirs { UNKNOWN, N, NE, E, SE, S, SW, W, NW }; ///< wszystkie kierunki świata.

Dirs[] allDirs={ Dirs.UNKNOWN,Dirs.N,Dirs.NE,Dirs.E,Dirs.SE,Dirs.S,Dirs.SW,Dirs.W,Dirs.NW };

color dirs2color(Dirs direction) //!< druga wersja koloryzacji
{
  switch(direction){
  case N:       return color(  0,  0,255);
  case NE:      return color(  0,255,255);
  case E:       return color(  0,255,  0);
  case SE:      return color(255,255,  0);
  case S:       return color(255,  0,  0);
  case SW:      return color(255,  0,120);
  case W:       return color(255,  0,255);
  case NW:      return color(120,  0,255);
  case UNKNOWN: 
  default: return color(255,255,255);
  }
}

class Agent
{
  Dirs direction=Dirs.UNKNOWN;  //!< Musi znać kierunek, w którym się przemieszcza.
  
  color getColor()
  {
    return dirs2color(direction);
  }
  
  void update()
  {
    if( direction==Dirs.UNKNOWN && random(1.0)<0.01 ) // W ciągu około 100 kroków każdy wybierze kierunek
      direction=allDirs[int(random(1,allDirs.length))];
  }
  
  void interactionA(Agent other) //!< Interakcja asymetryczna.
  {
    other.direction=this.direction;
  }
  
  //void interactionS(Agent other) //!< Interakcja całkiem symetryczna.
  //{
  //  Dirs newdirection=allDirs[int(random(1,allDirs.length))]; // Agenci „ustanawiają” nowy wspólny kierunek.
  //  this.direction=newdirection;
  //  other.direction=newdirection;
  //}
} 
