//Iteracja logistyczna - prawie wszystko co możliwe bez procedur
float R=2.5; //Zakres 0..4
float X=0.99; //Zakres 0..1!
size(1000,300);

//sprawdzanie zakresu R
if( R >= 4.0 ) { R=4.0; println("R is too big!"); }
if( R <= 0.0 ) { R=0.0; println("R is too small!"); }
println("Current R=",R);

stroke(255,0,0); //In RED!

for(int i=0;i<width;i++)
{
  println(i,X);
  //point(i,height-X*height); //Wizualizowane jako punkt
  ellipse(i,height-X*height,2,2);
  X=R*X*(1-X); //Oblicz następną iterację
}

text("R="+R,0,height);

//https://github.com/borkowsk/bookProcessingEN
