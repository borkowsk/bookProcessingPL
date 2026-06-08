/// TODO Bardzo prosty algorytm genetyczny z samymi mutacjami.
//-///////////////////////////////////////////////////////////
/// @date 2026-06-08 (modified)

import java.lang.Math;

/// Jednowymiarowa Funkcja Rastrigina.
/// @details 
/// Wzór matematyczny dla jednej zmiennej wygląda następująco:
///      \(f(x)=10+x^{2}-10\cdot \cos (2\pi x)\)
///      f(X) = 10 + x² - 10cos(2πx)
/// * Zalecany dziedzinowy przedział poszukiwań to `x in [-5.12, 5.12]`. 
///   W tym przedziale funkcja ma jedno wyraźne minimum globalne w punkcie `x = 0`,
///   gdzie wartość wynosi `0`, oraz kilkanaście minimów lokalnych („dolin”, w których 
///   można zobaczyć, że algorytm utknął, jeśli mutacja będzie za mała).
/// * Minimum globalne (Dno): Wynosi dokładnie 0.0 dla punktu `x = 0`.
/// * Maksimum globalne (Szczyt): Wynosi około 40.35 dla punktów \(x \approx \pm 4.523\).
/// * por.: https://www.wikiwand.com/en/Rastrigin_function . Są tam tez odnośniki do 
///   innych funkcji ciekawych jako banchmarki dla algorytmów optymalizacyjnych.
double Rastrigin(double x)
{
  return 10+x*x-10*Math.cos(2*x*Math.PI);
}

float zero=-5; ///< Pozycja Y==0 jako współrzędna w oknie.

void draw_function()
{
  stroke(0);
  line(512,height,512,0);
  line(512,0,510,6);
  line(512,0,514,6);
  line(505,zero,519,zero);
  
  int mi=width-1;
  float old_y=(float)Rastrigin(-5.13);
  stroke(0,255,255);
  for(int i=0;i<mi;i++)
  {
    double x=i/100.0-5.12;
    float y=(float)Rastrigin(x); //println(x,y);
    line(i-1,zero-old_y*10,i,zero-y*10);
    old_y=y;
  }
}

void setup()
{
  //tests();
  size(1024,450);
  zero=height-5;
}

void draw()
{
  background(255);
  draw_function();
}
