//Równanie Lotka–Volterra
//https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
//https://pl.wikipedia.org/wiki/R%C3%B3wnanie_Lotki-Volterry
//
float X=100; //x jest liczbą ofiar (na przykład królików);
float Y=10; //y to liczba drapieżników (np. lisów);

//α, β, γ, δ są dodatnimi parametrami rzeczywistymi opisującymi interakcję dwóch gatunków.
float alpha=0.001, beta=0.01, gamma=0.001, delta=0.1; //

float Tstep=0.01; //Krok czasowy. Tak krótki, jak to możliwe ;-)
int N=25; //Liczba kroków

println("α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta);
for(int i=0;i<N;i++)
{
  float oldX=X; //Zmienna lokalna jest ważna tylko w obrębie bloku kodu
  println(i,"X:",X," Y:",Y);
  //Jak zmieniają się X i Y w „nieskończenie krótkim” kroku czasowym
  X=X + Tstep * (alpha*X-beta*X*Y); //Jakie jest konkretne znaczenie tych parametrów?
  Y=Y + Tstep * (gamma*oldX*Y-delta*Y); //Jeśli nie zgadłeś, zobacz lv02.pde!
}

//https://github.com/borkowsk/bookProcessingEN
