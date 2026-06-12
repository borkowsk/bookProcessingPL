//Iteracja logistyczna – pierwsze podejście
final float R=2.5;
float X=0.3333333;

for(int i=0;i<100;i++) //Domyślna szerokość == 100
{
  println(i,X);
  X=R*X*(1-X); //Oblicz następną iterację
}
