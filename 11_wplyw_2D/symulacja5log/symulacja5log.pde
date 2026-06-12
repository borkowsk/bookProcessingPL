//Parametry kontroli
float Ones=0.55; //Ile „jedynek” jest początkowo w tablicy
int N=50;       //Bok macierzy

//Dla wizualizacji
int S=20;       //szerokość i wysokość komórki


//Dwuwymiarowy „świat” jednostek (indywiduów)
int A[][] = new int[N][N];

//Do zapisywania statystyk na dysku
PrintWriter output=null;

//Inicjalizacja
void setup()
{
  size(505,505);
  S=width/N;
  frameRate(10); //Nie za szybko
  // Utwórz nowy plik w katalogu szkiców!
  output = createWriter("Statistics.log"); 
  for(int i=0;i<N;i++)
   for(int j=0;j<N;j++)
   if( random(0,1) < Ones )
    A[i][j]=1;
    else
    A[i][j]=-1;
}

void exit() //Funkcja ta jest wywoływana zawsze po zamknięciu okna. 
{
  noLoop();delay(200);
  output.flush();  // Zapisuje pozostałe dane do pliku
  output.close();  // Kończy zapis i zamyka plik
  println("Thank You");
  super.exit(); //Co superklasa z biblioteki musi zrobić przy wyjściu.
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
  
  Count(); //Statystyka
  println("Step "+Step+" Reds="+Reds+" White="+(N*N-Reds));
  output.println("Step\t"+Step+"\tReds\t"+Reds+"\tWhite\t"+(N*N-Reds));
  
  DoMonteCarloStep(); //model Dynamika (zmiana stanu)
}

int Reds=0;
void Count()
{
  Reds=0;
  for(int i=0;i<N;i++)
   for(int j=0;j<N;j++)
     if(A[i][j]==1)
       Reds++;
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
        impact+=A[p][r];
      }
  
     if(impact>=0) //Majority rule - reguła większości.
       A[i][j]=1;
       else
       A[i][j]=-1;    
   }
   Step++; //Zliczanie kroków
}
