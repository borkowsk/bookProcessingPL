//Parametry kontroli
float Ones=0.5; //Ile „jedynek” jest początkowo w tablicy
int N=41;       //Bok macierzy

//Dla wizualizacji
int S=20;       //szerokość i wysokość komórki

//Dwuwymiarowy „świat” jednostek (indywiduów)
int A[][] = new int[N][N];

//Inicjalizacja
void setup()
{
  size(505,505);
  S=width/N;
  frameRate(100); //Nie za szybko
  for(int i=0;i<N;i++)
   for(int j=0;j<N;j++)
   if( random(0,1) < Ones )
    A[i][j]=1;
    else
    A[i][j]=-1;
}

int Step=0;
void DoMonteCarloStep() //Implementacja dynamiki
{
   println("Step "+Step);
   for(int a=0;a<N*N;a++) //tyle razy, ile wynosi liczba komórek 
   {
     int i=int(random(N));
     int j=int(random(N));
     
     int impact=0; //Obliczona suma wpływów
     for(int m=i-1;m<=i+1;m++)
      for(int n=j-1;n<=j+1;n++)
      {
        int p=(m+N)%N;
        int r=(n+N)%N;
        impact+=A[p][r];
      }
  
     if(impact>=0) //"Minority rule" -> Odwrotna reakcja!!!
       A[i][j]=-1;
       else
       A[i][j]=1;    
   }
   Step++; //Zliczanie kroków
}

//Running - wizualizacja oraz dynamika (zmiana stanu)
int frame=0;
void draw()
{
 //print((frame++)+" "); //Zliczanie ramek
 for(int i=0;i<N;i++) //Wizualizacja
  for(int j=0;j<N;j++)
  {
    if(A[i][j]==1)
    {
      fill(255,0,0);
    }
    else
    {
      fill(255);
    }
    rect(i*S,j*S,S,S);
  }  
  
  DoMonteCarloStep(); //Dynamika (zmiana stanu)
 /*  
  if(mousePressed==true) //jeśli coś na wejściu
  {
      DoMonteCarloStep(); //Dynamika (zmiana stanu)
      mousePressed=false; //A jakby to wykomentować?
  } */
}
