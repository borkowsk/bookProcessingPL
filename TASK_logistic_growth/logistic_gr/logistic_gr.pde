//Iteracja logistyczna – pierwsze podejście graficzne
final float R=3.66; //Zakres 0..4
float X=0.99; //Zakres 0..1!
size(1000,300);

for(int i=0;i<width;i++)
{
  println(i,X);
  //point(i,height-X*height); //Wizualizowane jako punkt
  ellipse(i,height-X*height,2,2);
  X=R*X*(1-X); //Oblicz następną iterację
}

text("R="+R,0,height);
