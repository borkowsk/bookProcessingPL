//Dwuwymiarowy, DETERMINISTYCZNY automat komórkowy - reguła "ZSUMUJ Z SĄSIADAMI I WEŹ MODULO". SYNCHRONICZNY.
// NA SIATCE Hexagonalnej - Wyswietlanie optymalizowane tablicą zmian (Changed)
//=============================================================================
//
int WorldSize=202; //Ile chcemy elementów w linii?
int[][] WorldOld=new int[WorldSize][WorldSize]; //Tworzenie tablic - w Processingu zawsze za pomocą alokacji!
int[][] WorldNew=new int[WorldSize][WorldSize];
boolean[][] Changed=new boolean[WorldSize][WorldSize]; //Tablica flag zmian do rysowania

float IDens=0.0; //Początkowa gęstość w tablicy
int   Div=6; //Jaki dzielnik w regule automatu

float CellSize=3; //Wysokość komórki
int   FRAME_RATE_REQ=9; //Ile klatek na sekundę byśmy chcieli

void settings() // SPECJALNA FUNCJA POZWALAJĄCA UŻYĆ WYRAŻENIA OKREŚLAJĄCEGO ROZMIARY OKNA ORAZ INNYCH USTAWIEŃ OKNA
{
   noSmooth(); //Jeśli istnieje funkcja `settings()` to ta komenda musi być w niej i przed `size()`
   //Proporcje okna 3:2
   size(int(WorldSize*1.5*CellSize),int(WorldSize*CellSize) ); // Tu akurat parametry muszą być typu `int`
}

void setup()
{
  background(0); //Czarne tło okna
  if(IDens>0)
  {
   for(int i=0;i<WorldOld.length;i++) //Zasiewanie tablicy
    for(int j=0;j<WorldOld.length;j++) 
    {
      Changed[i][j]=true;
      if(random(1.0)<IDens)
        WorldOld[i][j]=(int)(random(Div)); //trzeba zmienić typ (zrobić "rzut"), bo tablica przechowuje `int` a nie `float`
      else
        WorldOld[i][j]=0;
    }
  }
  else
  {
    for(int i=0;i<WorldOld.length;i++) //Zasiewanie tablicy
     for(int j=0;j<WorldOld.length;j++) 
     {
      Changed[i][j]=true;
      WorldOld[i][j]=0;
     }
      
    WorldOld[WorldSize/2][WorldSize/2]=1; //Tylko jeden zasiany w środku
  }
  visualize();
  frameRate(FRAME_RATE_REQ);
}

void draw()
{  
  change();
  visualize();
  fill(0,0,0,128);rect(10,height-16,20*8,16);
  fill(255);
  text("ST: "+frameCount+" Fr: "+frameRate,10,height);
}

// hexagon(center x-coordinate, center y-coordinate, width, height)
// Źródło: https://forum.processing.org/two/discussion/21083/creating-a-simple-function-to-draw-a-hexagon.html
void hexagon(float x, float y, float gsX, float gsY) ///< "Narzędzie" do rysowania hexagonu
{  
  float sqrt3=sqrt(3);
  gsX/=4;
  gsY/=3.5;
  beginShape();
  vertex(x - gsX, y - sqrt3 * gsY);
  vertex(x + gsX, y - sqrt3 * gsY);
  vertex(x + 2 * gsX, y);
  vertex(x + gsX, y + sqrt3 * gsY);
  vertex(x - gsX, y + sqrt3 * gsY);
  vertex(x - 2 * gsX, y);
  endShape(CLOSE);
}

void visualize() /// Wizualizacja świata
{
  noStroke();
  for(int i=0;i<WorldOld.length;i++)
  for(int j=0;j<WorldOld.length;j++) 
  {
    switch(WorldOld[i][j]){ //Instrukcja wyboru pozwala nam wybrać dowolny kolor w zależności od liczby w konmórce
      case 0:fill(0,0,0);break; //Odpowiednio dobrany zestaw kolorów pozwala uzyskać ciekawe efekty
      case 1:fill(0,255,0);break;
      case 2:fill(64,128,64);break;
      case 3:fill(128,64,128);break;
      case 4:fill(255,0,200);break;
      case 5:fill(64,0,255);break;
      case 6:fill(0,0,255);break;
      default: fill(255,255,255);//To się pojawiac nie powinno
      break;
    }
    
    //Użyjemy możliwości podawania współrzędnych ekranu jako `float`
    float offsetY=CellSize*0.50; //Połowa wysokości elipsy/hexagonu
    float offsetX=CellSize*0.75; //Połowa szerokości elipsy/hexagonu
    float lineIsEven=(j%2==0?offsetX:0); //Co drugi wiersz będzie bardziej przesuniety!
    float X=offsetX+i*1.5*CellSize+lineIsEven;
    float Y=offsetY+j*CellSize;
    hexagon(X,Y,CellSize*1.5,CellSize); //sześciokąty reprezentujące komórki
    //ellipse(X,Y,S*1.5,S); //zwykłe elipsy reprezentują komórki
    //stroke(255,255,0);point(X,Y);noStroke(); //Środki elips/hexagonów
  }
}

void change() //zmiana świata - tu synchroniczna
{
  for(int i=0;i<WorldOld.length;i++)//Zmiana stanu automatu
  {
       //Reguła - "ZSUMUJ Z SĄSIADAMI I WEŹ MODULO"
       //Zamiast ignorować brzegi można zrobić liczenie indeksów sąsiadów z zawijaniem dzięki reszcie z dzielenia
       int right = (i+1) % WorldSize;         
       int left  = (WorldSize+i-1) % WorldSize;
       
       for(int j=0;j<WorldOld.length;j++) 
       {
         int dw  = (j+1) % WorldSize;   
         int up  = (WorldSize+j-1) % WorldSize;
         int add = (j%2==0 ?  right   //wiersz parzysty dodatkowo bierze lewych 
                           :  left    //wiersz nieparzysty dodatkowo bierze prawych 
                           );
         int ile = WorldOld[i][j]
                 +WorldOld[left][j]
                 +WorldOld[right][j]
                 +WorldOld[i][up]
                 +WorldOld[add][up] // dodatkowy górny
                 +WorldOld[i][dw]        
                 +WorldOld[add][dw] // dodatkowy dolny
                 ; //suma siedmiu brana potem modulo div
      
         WorldNew[i][j]=ile % Div;//Nowy stan zapisujemy na drugą tablicę
         Changed[i][j]=(WorldNew[i][j] !=0 || WorldOld[i][j]!=0);//Czy trzeba odrysować? point() jest kosztowne wbrew pozorom
       }
   }
   
   //Zamiana tablic - łatwa bo nie trzeba kopiować danych, wystarczy zamienić "uchwyty" do nich
   int[][] WorldTmp=WorldOld;
   WorldOld=WorldNew;
   WorldNew=WorldTmp;
}

//////////////////////////////////////////////////////////////////////////////////
// Autor: Wojciech T. Borkowski
// Materiały do podręcznika "Processing w edukacji i symulacji
// https://github.com/borkowsk/sym4processing/tree/master/ProcessingWEdukacji
//////////////////////////////////////////////////////////////////////////////////
