//Równanie Lotka–Volterra
//https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
//https://pl.wikipedia.org/wiki/R%C3%B3wnanie_Lotki-Volterry
//
float X=300; //x jest liczbą ofiar (na przykład królików);
float Y=15; //y to liczba drapieżników (np. lisów);

//α, β, γ, δ są dodatnimi parametrami rzeczywistymi opisującymi interakcję dwóch gatunków.
final float alpha=0.1; //Wzrost ofiar
final float beta=0.01; //Interakcja ofiar z drapieżnikami
final float gamma=beta/10.0; //Jak wzrost drapieżników zależy od liczby ofiar
final float delta=0.1; //śmiertelność drapieżników
//α= 0.1 β= 0.01 γ= 0.001 δ= 0.1 jest idealnie stabilny, jeśli Xo=100, Yo=10;

final float Tstep=0.001; //Krok czasowy. Tak krótki, jak to możliwe ;-) Why? Lets try! :-D
final float Tlimit=1000; //Limit czasu jako 2/3 szerokości
final int   DOTSIZE=2; //Bardziej elastyczna wizualizacja
size(1500,500);

stroke(255,0,0);
println("α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta);

for(float T=0;T<Tlimit;T+=Tstep) // float TIME użyty jako zmienna sterująca!
{
  float oldX=X; //Zmienna lokalna jest ważna tylko w obrębie bloku kodu
  //println(T,"X:",X," Y:",Y);
  //Jak zmieniają się X i Y w „nieskończenie krótkim” kroku czasowym
  X=X + Tstep * (alpha*X-beta*X*Y);
  Y=Y + Tstep * (gamma*oldX*Y-delta*Y);
  //Wizualizacja
  stroke(0,255,0); //GREEN dla X
  ellipse(T,500-X,DOTSIZE,DOTSIZE);
  stroke(255,0,0); //RED dla Y
  ellipse(T,500-Y,DOTSIZE,DOTSIZE);
  stroke(0,0,255); //BLUE dla interakcji
  point(1000+X,500-Y);
}

//https://github.com/borkowsk/bookProcessingEN
