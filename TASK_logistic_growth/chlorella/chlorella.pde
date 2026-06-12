//Populacja Chlorella (taki glon)
int X=1; //Stan aktualny
int R=4; //Liczba potomków komórki: 2,4,8, a nawet 16!

for(int i=0;i<10;i++)
{
  println(i,X); //która generacja i jaki stan
  X=R*X; //Oblicz następny stan używając R
}
