// Reguła większości kontra mniejszości w modelu Isinga
//-/////////////////////////////////////////////////////////
//Parametry kontroli
int MajorityRule=1; //Jeśli 1, to reguła większości, ale jeśli -1, to reguła mniejszości

int N=50;          //Bok macierzy
float Ones=0.50;   //Ile „jedynek” jest w tablicy
float Noise=0.01;  //Jak często zmiany następują spontanicznie

//Dwuwymiarowy „świat” jednostek (indywiduów)
int A[][] = new int[N][N];

//Uchwyt pliku służący do zapisywania statystyk na dysku
PrintWriter output;

int S=0;       //szerokość i wysokość komórki (Dla wizualizacji)
void setup()   //Inicjalizacja
{
  size(600,600);
  S=width/N;   //Wartość początkowa "S" zależy od rozmiaru okna.
  frameRate(5); //Nie za szybko
  
  //Inicjalizacja of the "World"
  for(int i=0;i<N;i++)
   for(int j=0;j<N;j++)
   if( random(0,1) < Ones )
    A[i][j]=1;
    else
    A[i][j]=-1;
  
  output = createWriter("Statistics.log"); //Utwórz nowy plik w katalogu szkiców! 
}

void exit() //Funkcja ta jest wywoływana zawsze po zamknięciu okna. 
{
  noLoop();
  output.flush();  // Zapisuje pozostałe dane do pliku
  output.close();  // Kończy zapis i zamyka plik
  println("Thank You");
  super.exit(); //Co superklasa z biblioteki musi zrobić przy wyjściu.
} 

//Running - Wizualizacja i Dynamika (zmiana stanu)
void draw()
{
 for(int i=0;i<N;i++) //Wizualizacja
  for(int j=0;j<N;j++)
  {
    if(A[i][j]==1)
      fill(255,0,0);
    else
      fill(255);
    rect(i*S,j*S,S,S);
  }  
  
  Count(); //Przygotuj statystyki
  
  println("Step "+Step+" Reds="+Reds+" White="+(N*N-Reds)); //window
  output.println("Step\t"+Step+"\tReds\t"+Reds+"\tWhite\t"+(N*N-Reds)); //log
  
  DoMonteCarloStep(); //Do model Dynamika (zmiana stanu)
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
   for(int a=0;a<N*N;a++) //tyle razy, ile wynosi liczba komórek (M C step)
   {
     int i=int(random(N));
     int j=int(random(N));
         
     if(random(1.0)<Noise) //UŻYCIE SZUMU
     {
       A[i][j]=-A[i][j]; //spontaniczna zmiana
     }
     else
     {
       int impact=0; //Obliczona suma wpływów
       for(int m=i-1;m<=i+1;m++)
        for(int n=j-1;n<=j+1;n++)
        {
          int p=(m+N)%N;
          int r=(n+N)%N;
          impact+=A[p][r];
        }
        
       if(impact>=0) //Zmienna MajorityRule jest równa 1 lub -1,
         A[i][j]=1*MajorityRule; //więc może zmienić znak wyjścia 
         else
         A[i][j]=-1*MajorityRule; //więc może zmienić znak wyjścia
     }
    }
   Step++; //Zliczanie kroków
}
