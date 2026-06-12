//Równanie Lotka–Volterra
//https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
//https://pl.wikipedia.org/wiki/R%C3%B3wnanie_Lotki-Volterry
//
float X=100; //x jest liczbą ofiar (na przykład królików);
float Y=10; //y to liczba drapieżników (np. lisów);

//α, β, γ, δ są dodatnimi parametrami rzeczywistymi opisującymi interakcję dwóch gatunków.
final float alpha=0.1; //Wzrost ofiar
final float beta=0.01; //Interakcja ofiar z drapieżnikami
final float gamma=0.001; //Jak wzrost drapieżników zależy od liczby ofiar
final float delta=0.1; //śmiertelność drapieżników
//α= 0.1 β= 0.01 γ= 0.001 δ= 0.1 jest idealnie stabilny, jeśli Xo=100, Yo=10;

float Tstep=0.1; //Krok czasowy. Tak krótki, jak to możliwe ;-)
int N=25; //Liczba kroków

println("α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta);
for(int i=0;i<N;i++)
{
  float oldX=X; //Zmienna lokalna jest ważna tylko w obrębie bloku kodu
  println(i,"X:",X," Y:",Y);
  //Jak zmieniają się X i Y w „nieskończenie krótkim” kroku czasowym
  X=X + Tstep * (alpha*X-beta*X*Y);
  Y=Y + Tstep * (gamma*oldX*Y-delta*Y);
}

//https://github.com/borkowsk/bookProcessingEN
