// Dwuwymiarowy, asynchroniczny (kroki MC) automat komórkowy 
// - reguła "Min=Best:1 Max:2 sąsiadów". 
// Zasiewanie tablicy na początku z zadaną gęstością lub pojedynczą komórką
/////////////////////////////////////////////////////////////////////////////////

int WorldSide=400;//Ile chcemy elementów w linii i ile linii (tablica kwadratowa)

int[][] World=new int[WorldSide][WorldSide];//Tworzenie tablicy świata 
                                            //- w Processingu zawsze za pomocą alokacji

float IDens=0.0;//Początkowa gęstość w tablicy

void setup()
{
 size(400,400);    //Okno kwadratowe
 noSmooth(); //Znacząco przyśpiesza
 if(IDens>0)
  {
   for(int i=0;i<World.length;i++) //Zasiewanie tablicy
    for(int j=0;j<World.length;j++) 
      if(random(1.0)<IDens)
        World[i][j]=1;
  }
  else
  {
    World[WorldSide/2][WorldSide/2]=1;
  }
 frameRate(50);
}

int t=0;

void draw()
{  
  for(int i=0;i<World.length;i++)//Wizualizacja czyli "rysowanie na ekranie" 
    for(int j=0;j<World.length;j++) 
    {                      //W zależności od liczby w komórce
      switch(World[i][j]){ //instrukcja wyboru pozwala nam wybrać dowolny kolor 
      case 1:stroke(255,0,255);break;
      case 0:stroke(0,0,0);break;
      default: stroke(0,255,0);//To się pojawiac nie powinno
      break;
      } 
      point(i,j);
    }
  
  //Zmiana stanu automatu - krok Monte Carlo
  for(int a=0;a<World.length*World.length;a++)//Tyle losowań ile komórek
  {
       //Losowanie agenta 
       int i=(int)random(World.length);
       int j=(int)random(World.length);
       
       //Reguła - "ZLICZ SĄSIADÓW"
       int right = (i+1) % WorldSide;      
       int left  = (WorldSide+i-1) % WorldSide;
       int dw=(j+1) % WorldSide;   
       int up=(WorldSide+j-1) % WorldSide;
       
       int ile = World[left][j]
                +World[right][j]
                +World[i][up]
                +World[i][dw]              
                ;//suma z sąsiadów, ale stany tylko 0 i 1
      
        //Nowy stan zapisujemy do tablicy
        if(World[i][j]==0)//Martwa komorka
        {
          if(ile==1)//Rodzi się gdy ma rodzica
             World[i][j]=1;
        }
        else
          if(ile>=2) //Umiera gdy mu za ciasno
              World[i][j]=0;
   }
      
   t++;//Kolejne pokolenie/krok/rok
   text("ST:"+t,0,10);
}

//////////////////////////////////////////////////////////////////////////////////
// Autor: Wojciech T. Borkowski
// Materiały do podręcznika "Processing w edukacji i symulacji
// https://github.com/borkowsk/sym4processing/tree/master/ProcessingWEdukacji
//////////////////////////////////////////////////////////////////////////////////
