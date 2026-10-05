/// Model Greenberga-Hastingsa: symulacja ośrodków pobudliwych.
/// Dwuwymiarowy, synchroniczny, deterministyczny automat komórkowy z sąsiedztwem Moore’a.
/// @date 2026-10-05 (ostatnia modifikacja)
//-///////////////////////////////////////////////////////////////////////////////////////

final int   WorldSide=601; //< Ile komórek chcemy mieć w jednym wierszu?
final float Dens=0.5;      //< Gęstość początkowa zarodków wzbudzenia

// Stany komórki: 0 – spoczynkowy, 1 – pobudzony, 2 – refrakcyjny
final int   STATE_RESTING = 0;
final int   STATE_EXCITED = 1;
final int   STATE_REFRACTORY = 2;

int[][] WorldOld=new int[WorldSide][WorldSide]; //< Potrzebujemy dwóch „światów” dla poprzednich...
int[][] WorldNew=new int[WorldSide][WorldSide]; //< ... i nowych stanów symulacji.


void setup()
{
  size(601,601);    //okno kwadratowe z dostępnymi środkowymi indeksami (niepoarzyste!)
  frameRate(999); 
  noSmooth();
  
  // 1. Najpierw czyścimy cały świat do stanu spoczynku
  for(int i=0; i<WorldSide; i++) {
    for(int j=0; j<WorldSide; j++) {
      WorldOld[i][j] = STATE_RESTING;
    }
  }
  
  // 2. Tworzymy sztuczną asymetrię na środku ekranu
  int środekX = WorldSide / 2;
  int startY  = (int)(WorldSide / 4 * Dens);
  int koniecY = (int)(3 * (WorldSide / 4) * Dens);
  
  // Rysujemy pionowy pasek pobudzenia (linia frontu fali)
  for(int i = startY; i <= koniecY; i++) {
    WorldOld[i][środekX] = STATE_EXCITED;
  }
  
  // Tuż obok (po lewej stronie) rysujemy pasek refrakcji (ogon fali)
  // Dzięki temu fala może poruszać się tylko w prawą stronę, a na końcach zacznie się zwijać
  for(int i = startY; i <= koniecY; i++) {
    WorldOld[i][środekX - 1] = STATE_REFRACTORY;
  }
}
  
  
void visualisation()
{
  for(int i=0;i<WorldSide;i++)
    for(int j=0;j<WorldSide;j++)
    {
      // Oznaczenie kolorami trzech stanów
      if(WorldOld[i][j] == STATE_EXCITED)         stroke(255, 0, 100); //Czerwonawy dla "Excited"
      else if(WorldOld[i][j] == STATE_REFRACTORY) stroke(0, 0, 255);   //Niebieski dla "Refractory"
      else                                        stroke(0);           //Czarny dla "Resting"      
      point(j,i); //Wymiar poziomy tablicy to DRUGI indeks.
    }
}

int t=0;
void draw() //Modifies global t,WorldOld,WorldNew
{  
  visualisation(); //Narysuj aktualny świat
  
  for(int i=0;i<WorldSide;i++) //Przejdźmy teraz do zmiany stanu automatu komórkowego
  {
    int right = (i+1) % WorldSide;
    int left  = (WorldSide+i-1) % WorldSide;
     
    for(int j=0;j<WorldSide;j++) 
    {
      // REGUŁA GREENBERGA-HASTINGSA:
      //-////////////////////////////
      if (WorldOld[i][j] == STATE_EXCITED) 
      {
        WorldNew[i][j] = STATE_REFRACTORY; //Pobudzone komórki przechodzą w stan refrakcji
      } 
      else if (WorldOld[i][j] == STATE_REFRACTORY) 
      {
        WorldNew[i][j] = STATE_RESTING;    //Komórki ze stanu refrakcji przechodzą w stan spoczynku
      } 
      else //DLA STANU SPOCZYNKU:
      {
        int dw=(j+1) % WorldSide;
        int up=(WorldSide+j-1) % WorldSide;
         
        // Liczenie sąsiadów w stanie POBUDZONYM (sąsiedztwo Moore'a):
        int excitedNeighbors = (
                    (WorldOld[left][j]   == STATE_EXCITED ? 1 : 0)
                 +  (WorldOld[right][j]  == STATE_EXCITED ? 1 : 0)
                 +  (WorldOld[i][up]     == STATE_EXCITED ? 1 : 0)
                 +  (WorldOld[i][dw]     == STATE_EXCITED ? 1 : 0)    
                 +  (WorldOld[left][up]  == STATE_EXCITED ? 1 : 0) 
                 +  (WorldOld[right][up] == STATE_EXCITED ? 1 : 0) 
                 +  (WorldOld[left][dw]  == STATE_EXCITED ? 1 : 0) 
                 +  (WorldOld[right][dw] == STATE_EXCITED ? 1 : 0)            
                 );
                 
        // Komórka w stanie spoczynku staje się wzbudzona, jeśli ma co najmniej jednego wzbudzonego sąsiada
        WorldNew[i][j] = (excitedNeighbors >= 1 ? STATE_EXCITED : STATE_RESTING); //A gdy potrzeba DWÓCH lub TRZECH?
      }
    }
  }
   
  // teraz zamień tablice
  int[][] WorldTmp=WorldOld; 
  WorldOld=WorldNew; 
  WorldNew=WorldTmp; 
   
  t++; //Następna generacja/krok/rok 
  fill(255,128); 
  textSize(20); textAlign(LEFT,TOP); text("ST:"+t,0,0); 
}

//Dla lepszej zabawy!
void mousePressed()
{
  int i=mouseX;
  int j=mouseY;
  WorldOld[j][i]=STATE_EXCITED;
}
