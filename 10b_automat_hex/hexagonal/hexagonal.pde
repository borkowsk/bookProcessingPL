//Dwuwymiarowy, DETERMINISTYCZNY automat komórkowy - reguła "ZSUMUJ Z SĄSIADAMI I WEŹ MODULO". Kroki synchroniczne
// NA SIATCE Hexagonalnej
//========================
int WorldSize=27; //Ile chcemy elementów w linii?
float IDens=0.00; //Początkowa gęstość w tablicy (0 oznacza inicjację w środku)
int Div=5;

int[][] World=new int[WorldSize][WorldSize];

float CellSize=22; //Użyjemy możliwości podawania współrzędnych ekranu jako `float`

void settings() // SPECJALNA FUNCJA POZWALAJĄCA UŻYĆ WYRAŻENIA OKREŚLAJĄCEGO ROZMIARY OKNA ORAZ INNYCH USTAWIEŃ OKNA
{
   //noSmooth(); //Jeśli istnieje funkcja `settings()` to ta komenda musi być w niej i przed `size()`
   //Proporcje okna 3:2
   size(int(WorldSize*1.5*CellSize),int(WorldSize*CellSize) ); // Tu akurat parametry muszą być typu `int`
}

void setup() // KLASYCZNY SETUP JEST URUCHAMIANY PO `settings()`
{
  initialize(); //Inicjalizacja świata
  visualize();  //pierwsza wizualizacja świata
  visualise_connections(); //wizializacja połączen/interakcji komórek
  frameRate(9);
}

void draw()
{
  if(frameCount<2) delay(1000*5/*n*/); //Na n-sekund stan początkowy
  change();     //zmiana świata
  visualize();  //kolejna wizualizacja świata
  fill(255);
  text("ST:"+frameCount,0,10);
}

void initialize() ///Inicjalizacja świata
{
  if(IDens>0)
  {
   for(int i=0;i<World.length;i++) //Zasiewanie tablicy
    for(int j=0;j<World.length;j++) 
     if(random(1.0)<IDens)
       World[i][j]=int(random(Div));
  }
  else
  {
    World[WorldSize/2][WorldSize/2]=int(random(Div));
  }
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

void visualize() ///Wizualizacja świata
{
  noStroke();
  for(int i=0;i<World.length;i++)//Wizualizacja czyli "rysowanie na ekranie" 
  for(int j=0;j<World.length;j++) 
  {
    switch(World[i][j]){ //Instrukcja wyboru pozwala nam wybrać dowolny kolor w zależności od liczby w konmórce
    case 3:fill(128,128,0);break;
    case 2:fill(255,0,0);break;
    case 1:fill(0,0,255);break;
    case 0:fill(0,0,0);break;
    default: fill(0,255,0);//To się pojawiac nie powinno
    break;
    }
    
    //Użyjemy możliwości podawania współrzędnych ekranu jako `float`
    float offsetY=CellSize*0.5; //Połowa wysokości elipsy
    float offsetX=offsetY*1.5;  //Połowa szarokości elipsy
    float lineIsEven=(j%2==0?offsetX:0); //Co drugi wiersz będzie bardziej przesuniety!
    float X=offsetX+i*1.5*CellSize+lineIsEven;
    float Y=offsetY+j*CellSize;
    hexagon(X,Y,CellSize*1.5,CellSize);
    //ellipse(X,Y,CellSize*1.5,CellSize); //elipsy reprezentują komórki
    //stroke(255,255,0);point(X,Y);noStroke(); //Środki elips
  }
}

void visualise_connections() //Wizualizacja połączeń w prawo i w dół
{
  for(int i=1;i<World.length-1;i++)//Wizualizacja czyli "rysowanie na ekranie" 
  for(int j=0;j<World.length-1;j++) 
  {    
    //Użyjemy możliwości podawania współrzędnych ekranu jako `float`
    float offsetY=CellSize*0.5; //Połowa wysokości elipsy
    float offsetX=offsetY*1.5;  //Połowa szarokości elipsy
    float X=offsetX+i*1.5*CellSize+(j%2==0?offsetX:0);
    float Y=offsetY+j*CellSize;
    
    int right = (i+1) % WorldSize;      
    int left  = (WorldSize+i-1) % WorldSize;
    int dw    = (j+1) % WorldSize;
    //int up    = (WorldSize+j-1) % WorldSize;
    int add   = (j%2==0 ?  right   //parzysty
                        :  left    //nieparzysty
                        );
    stroke(255,0,255);
    float X1=offsetX+right*1.5*CellSize+(j%2==0?offsetX:0);
    line(X,Y,X1,Y);
    
    if(i==1)
    {
       stroke(255,0,0);
       X1=offsetX+left*1.5*CellSize+(j%2==0?offsetX:0);
       line(X,Y,X1,Y);
    }
    
    // Inne kolor dla parzystych i nieparzystych wierszy
    if(j%2==0) stroke(0,255,255);
    else stroke(255,255,0);             
    
    //World[add][dw]
    float Y1=offsetY+dw*CellSize;
    X1=offsetX+i*1.5*CellSize+(dw%2==0?offsetX:0);
    line(X,Y,X1,Y1);
    //World[i][dw]
    X1=offsetX+add*1.5*CellSize+(dw%2==0?offsetX:0);
    line(X,Y,X1,Y1);
  }
}

void change() //zmiana świata - tu asynchroniczna Monte Carlo
{
  for(int a=0;a<World.length*World.length;a++)//Tyle losowań ile komórek
  {
       //Losowanie agenta 
       int i=(int)random(World.length);
       int j=(int)random(World.length);
       
       //Reguła - "ZSUMUJ Z SĄSIADAMI I WEŹ MODULO"
       int right = (i+1) % WorldSize;      
       int left  = (WorldSize+i-1) % WorldSize;
       int dw    = (j+1) % WorldSize;
       int up    = (WorldSize+j-1) % WorldSize;
       int add   = (j%2==0 ?  right   //wiersz parzysty dodatkowo bierze lewych 
                           :  left    //wiersz nieparzysty dodatkowo bierze prawych 
                           );
       int ile = World[i][j] //Żeby było jeszcze ciekawiej robimy regułę modulo
                 +World[left][j]
                 +World[right][j]
                 +World[i][up]
                 +World[add][up] // dodatkowy górny
                 +World[i][dw]  
                 +World[add][dw] // dodatkowy dolny
                 ;//suma pięciu brana potem modulo div
      
        World[i][j]=ile % Div;//Nowy stan zapisujemy do tablicy
   }
}

//////////////////////////////////////////////////////////////////////////////////
// Autor: Wojciech T. Borkowski
// Materiały do podręcznika "Processing w edukacji i symulacji
// https://github.com/borkowsk/sym4processing/tree/master/ProcessingWEdukacji
//////////////////////////////////////////////////////////////////////////////////
