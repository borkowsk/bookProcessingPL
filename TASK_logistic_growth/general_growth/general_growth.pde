//Ogólny model wzrostu populacji komórek
float X=1.0; //Stan aktualny
float R=2.5; //Średnia liczba dojrzałych potomków

for(int i=0;i<10;i++)
{
  println(i,X); //która generacja i jaki stan
  X=R*X; //Oblicz następny stan używając R
}
