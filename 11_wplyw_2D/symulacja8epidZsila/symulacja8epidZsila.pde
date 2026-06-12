//Model dynamicznego wpływu społecznego Nowaka-Latane 
// - wersja "komórkowa" ze zróżnicowaniem sił
//-////////////////////////////////////////////////////
//Parametry kontroli
int N=200;       //Bok macierzy
float init=0.010; //Jaka część zostaje zainicjalizowana.
float SeedsPerSt=0.005;

//Dla wizualizacji
int S=20;       //szerokość i wysokość komórki

//Dwuwymiarowy „świat” jednostek (indywiduów)
int A[][] = new int[N][N];
int P[][] = new int[N][N];

//Zmienne do inicjalizacji
int initcounter=0; //Ile już wylosowano
int initnakrok=0; //Ile w jednym kroku

//Inicjalizacja
void setup()
{
  size(805,805);
  S=width/N; //Długość boku komórki (w wizualizacji)
 
  for(int i=0;i<N;i++)
   for(int j=0;j<N;j++)
   {
    A[i][j]=0;
    P[i][j]=(int)random(256);
   }
  
  initcounter=int(N*N*init); //Ile będzie w ogóle nasion?  
  initnakrok=int(N*N*SeedsPerSt); //A ile nasion w jednym kroku
  
  frameRate(2); //Nie za szybko
}

void exit() //Funkcja ta jest wywoływana zawsze po zamknięciu okna. 
{
  noLoop(); //To be sure / dla pewności ;-)
  println("Thank You");
  super.exit(); //Co superklasa z biblioteki musi zrobić przy wyjściu.
} 

int Step=0;
void DoMonteCarloStep() //Implementacja dynamiki
{
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
        impact+=A[p][r]*P[p][r];
      }
  
     if(impact!=0) //Nic nie trzeba robić, gdy jest "0".
     {
      if(impact>=0) //Majority rule - reguła większości.
       A[i][j]=1;
       else
       A[i][j]=-1;
     }
   }
   Step++; //Zliczanie kroków
}

int Reds=0,Black=0,White=0;
void Count()
{
  Reds=0;White=0;Black=0;
  for(int i=0;i<N;i++)
   for(int j=0;j<N;j++)
     if(A[i][j]==0)
       Black++;
     else
     if(A[i][j]==1)
       Reds++;
     else
       White++;
}

//Symulacja: wizualizacja, statystyka i dynamika
void draw()
{
 for(int i=0;i<N;i++) //Wizualizacja
  for(int j=0;j<N;j++)
  {
    int power=P[i][j];
    if(A[i][j]==0)
    {
      fill(power,power,0);
    }
    else
    if(A[i][j]==1)
    {
      fill(power,0,0);
    }
    else
    {
      fill(power);
    }
    rect(i*S,j*S,S,S);
  }  
  
  Count(); //Statystyka
  println("Step "+Step+" Reds="+Reds+" White="+White+" Black="+Black);
  DoMonteCarloStep(); //Dynamika (zmiana stanu)
  
  //Losowanie nasion
  for(int c=0;c<initnakrok;c++)
  if(initcounter>0)
  {
    int i=int(random(N));
    int j=int(random(N));
    if(initcounter%2==0) //Dla parzystych -1
     A[i][j]=-1;
    else
     A[i][j]=1;
    initcounter--; 
  }
}
