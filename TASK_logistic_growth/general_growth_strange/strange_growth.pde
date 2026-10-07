//Ogólny model wzrostu populacji komórek - co oznacza 1/3 komórki?

int   X=1; //Stan aktualny
float R=2.5; //Średnia liczba dojrzałych potomków

for(int i=0;i<10;i++)
{
  println(i,X); //która generacja i jaki stan
  //W tym miejscu części komórek nie są dozwolone :-)
  X=int(R*X); //Oblicz następny stan używając R
}

//https://github.com/borkowsk/bookProcessingEN
