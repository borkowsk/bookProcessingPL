//Równanie Lotka–Volterra
//https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
//https://pl.wikipedia.org/wiki/R%C3%B3wnanie_Lotki-Volterry
//
float X=100; //x jest liczbą ofiar (na przykład królików);
float Y=15; //y to liczba drapieżników (np. lisów);

//α, β, γ, δ są dodatnimi parametrami rzeczywistymi opisującymi interakcję dwóch gatunków.
float alpha=0.1; //Wzrost ofiar
float beta=0.01; //Interakcja ofiar z drapieżnikami
float gamma=beta/10.0; //Jak wzrost drapieżników zależy od liczby ofiar
float delta=0.1; //śmiertelność drapieżników
//α= 0.1 β= 0.01 γ= 0.001 δ= 0.1 jest idealnie stabilny, jeśli Xo=100, Yo=10;

float Tstep=0.01; //Krok czasowy. Tak krótki, jak to możliwe ;-)

size(1000,500);

stroke(255,0,0);
println("α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta);
// //Dlaczego "i"? Zamiast tego użyto "T"!
for(float T=0;T<1000;T+=Tstep) // float TIME użyty jako zmienna sterująca!
{
  float oldX=X; //Zmienna lokalna jest ważna tylko w obrębie bloku kodu
  //println(T,"X:",X," Y:",Y);
  //Jak zmieniają się X i Y w „nieskończenie krótkim” kroku czasowym
  X=X + Tstep * (alpha*X-beta*X*Y);
  Y=Y + Tstep * (gamma*oldX*Y-delta*Y);
  //Wizualizacja
  stroke(0,255,0); //GREEN for X
  ellipse(T,500-X,3,3);
  stroke(255,0,0); //RED for Y
  ellipse(T,500-Y,3,3);
}

//https://github.com/borkowsk/bookProcessingEN
