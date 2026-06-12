//Iteracja logistyczna - słupki
final float R=3.22;
float X=0.3333333; //Zakres 0..1!

final int interspace=2; //odstęp między początkami słupków

size(800,200);
background(255);

for(int i=0;i<width;i+=interspace)
{
  println(i/interspace,X);
  line(i,height,i,height-X*height); //Wizualizowane jako pionowe linie
  X=R*X*(1-X); //Oblicz następną iterację
}

fill(128);textSize(24);
text("R="+R,0,height);

//https://github.com/borkowsk/bookProcessingEN
