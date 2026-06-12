//Równanie Lotka–Volterra
//https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations
//https://pl.wikipedia.org/wiki/R%C3%B3wnanie_Lotki-Volterry
//
float X=350; //x jest liczbą ofiar (na przykład królików);
float Y=10; //;

//α, β, γ, δ są dodatnimi parametrami rzeczywistymi opisującymi interakcję dwóch gatunków.
float alpha=0.2; //Wzrost ofiar
float beta=0.01; //Interakcja ofiar z drapieżnikami
float gamma=beta/10.0; //Jak wzrost drapieżników zależy od liczby ofiar
float delta=0.05; //śmiertelność drapieżników

float Tstep=0.3; //Krok czasowy. Tak krótki, jak to możliwe ;-)
int N=1000; //Liczba kroków
size(1000,500);

stroke(255,0,0);
println("α=",alpha,"β=",beta,"γ=",gamma,"δ=",delta);
for(int i=0;i<N;i++)
{
  float oldX=X; //Zmienna lokalna jest ważna tylko w obrębie bloku kodu
  println(i,"X:",X," Y:",Y);
  //Jak zmieniają się X i Y w „nieskończenie krótkim” kroku czasowym
  X=X + Tstep * (alpha*X-beta*X*Y);
  Y=Y + Tstep * (gamma*oldX*Y-delta*Y);
  //Wizualizacja
  stroke(0,255,0); //GREEN dla X
  ellipse(i,500-X,3,3);
  stroke(255,0,0); //RED dla Y
  ellipse(i,500-Y,3,3);
}

//https://github.com/borkowsk/bookProcessingEN
