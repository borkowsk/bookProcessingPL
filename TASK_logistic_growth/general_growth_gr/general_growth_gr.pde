//
float X=1; //Stan aktualny
float R=1.5; //Średnia liczba dojrzałych potomków
size(500,500);
for(int i=0;i<16;i++)
{
  println(i,X); //Która generacja i jaki stan
  X=R*X; //Oblicz następny stan używając R
  ellipse(i,500-X,2,2);
}
