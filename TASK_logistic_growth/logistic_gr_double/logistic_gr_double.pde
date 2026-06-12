//Iteracja logistyczna – obliczenia na dublach
final double R=3.45;
double X=0.3333333; //Zakres 0..1!
size(1600,600);

for(int i=0;i<width;i++) //Domyślna szerokość == 100
{
  println(i,X);
  //Gdy w obliczeniach użyjesz `double`, wynik będzie `double`, ale oczekiwane wartości w`point()` są typu `float`!
  point(i,(float)(height-X*height)); // więc używamy tak zwanego „rzutu” do `float`.
  X=R*X*(1-X); //Oblicz następną iterację
}

text("R="+R,0,height);
