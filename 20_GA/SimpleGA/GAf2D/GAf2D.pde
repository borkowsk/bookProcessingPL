/// Dwuwymiarowy algorytm genetyczny.
//-///////////////////////////////////////////////////////////
/// @date 2026-06-12 (zmodyfikowany)

import java.lang.Math;

/// @name Parametry algorytmu genetycznego
/// @{
int     TEMPO=5;                   ///< Ile kroków algorytmu na sekundę?
int     population_size=500;       ///< Rozmiar populacji rozwiązań.
float   selection_rate=0.20;       ///< Jaką część populacji wymieniamy w każdej generacji (kroku algorytmu).
float   mutation_rate=0.015;       ///< Jaki jest poziom mutacji (może mieć różne interpretacje!)
boolean use_float_code=true;       ///< Czy liczby kodujemy jako zmiennoprzecinkowe? Ma to większy sens dla szukania minimum niż maksimów.
boolean maximize=false;            ///< Czy szukamy maksimum funkcji? Gdy "false" to szukamy minimum.
boolean selection_by_duels=true;   ///< Czy używamy selekcji przez pojedynki czy klasycznej - z sortowaniem.
/// @}

GAPopulation Pop;

/// Dwuwymiarowa Funkcja Rastrigina.
/// @details 
/// Wzór matematyczny dla dwóch zmiennych wygląda następująco:
///     f(x, y) = 20 + (x² - 10*cos(2πx)) + (y² - 10*cos(2πy))
/// * Zalecany dziedzinowy przedział poszukiwań to `x, y in [-5.12, 5.12]`. 
///   W tym przedziale funkcja ma jedno wyraźne minimum globalne w punkcie `(x, y) = (0, 0)`,
///   gdzie wartość wynosi `0`. Posiada ona około 50 minimów lokalnych, co czyni ją 
///   świetnym benchmarkiem dla algorytmów 2D.
/// * Minimum globalne: Wynosi dokładnie 0.0 dla punktu (0, 0).
/// * Maksimum globalne: Wynosi około 80.7 dla punktów w pobliżu rogów dziedziny.
double Rastrigin2D(double x, double y)
{
  if (Double.isNaN(x) || Double.isNaN(y)) {
    println("NaN parameter in Rastrigin2D!");
  }
  
  double result = 20 + (x*x - 10*Math.cos(2*Math.PI*x)) 
                     + (y*y - 10*Math.cos(2*Math.PI*y));
  return result;
} 

//void calculate_fitnesses(GAPopulation pop)
//{
//  for(int i=0;i<pop.all.length;i++)
//  {
//    double cfit=pop.get_fitness(i);
//    if(cfit==-Double.MAX_VALUE) // Jeszcze nie było liczone
//    {
//      double cx=pop.get_valX(i);
//      double cy=pop.get_valY(i);
//      cfit=Rastrigin(cx,cy);
//      //if(cfit==0) println("DEBUG:",cx); //Oczywiście to się będzie często zdarzać przy takim kodowaniu `float`, gdy `0` jest w zakresie!
//      pop.set_fitness(i,cfit);
//    }
//  }
//}


void draw_function(int opacity)
{
  //stroke(0);
  //line(512,height,512,0);
  //line(512,0,510,6);
  //line(512,0,514,6);
  //line(505,zero,519,zero);
  
  int mi=width;
  int mj=height;
  
  for(int i=0;i<mi;i++)
  {
    double x=i/100.0-5.12;
    for(int j=0;j<mj;j++)
    {
      double y=j/100.0-5.12;
      double z=Rastrigin2D(x,y); //println(x,y,z);
      int intens=(int)(z*3);
      stroke(0,intens,intens,opacity);
      point(i,j);
    }
  }
}

//-/// @name Para wartości aktualnie najlepszego rozwiązania
//-/// @{
//double best_fit=-Double.MAX_VALUE;
//double x_best=-Double.MAX_VALUE;
//-/// @}

//void find_the_best(GAPopulation pop)
//{
//  if(maximize)
//  { best_fit=x_best=-Double.MAX_VALUE; }
//  else
//  { best_fit=x_best=Double.MAX_VALUE; }
  
//  for(int i=0;i<pop.all.length;i++)
//  if(maximize)
//  {
//    double fit=pop.all[i].fitness;
//    if(fit>best_fit)
//    {
//      best_fit=fit;
//      x_best=pop.get_val(i);
//    }
//  }
//  else
//  {
//    double fit=pop.all[i].fitness;
//    if(fit<best_fit)
//    {
//      best_fit=fit;
//      x_best=pop.get_val(i);
//    }
//  }
//}

//-// Rysuje populacje.
//void draw_population(GAPopulation pop)
//{ 
//  stroke(255,0,0);noFill();
//  for(int i=0;i<pop.all.length;i++)
//  {
//    float cx=(float)pop.get_val(i)*100+512;
//    float cfit=zero-(float)pop.get_fitness(i)*10;
//    circle(cx,cfit,4);
//    point(cx,cfit);
//  }
//}

void setup()
{
  //tests();
  size(1024,1024);
  //Pop=new GAPopulation(population_size,-5.12,5.12,use_float_code);
  frameRate(TEMPO);
  draw_function(255);
}

void draw()
{
  if(frameCount%10==0) draw_function(10);
  // Stan aktualny:
  
  //calculate_fitnesses(Pop);
  //draw_population(Pop);
  
  //find_the_best(Pop);
  //fill(0,255,0);
  //textSize(24);
  //text("X="+x_best,width/2,24);
  //text("Y="+best_fit,width/2,48);
  println(frameCount); //,"\tX:\t",x_best,"\tY:\t",best_fit);
  
  //// Zmiana stanu:
  //if(selection_by_duels)
  //{
  //  Pop.clonal_offspring_by_duels(selection_rate,mutation_rate,maximize);
  //}
  //else
  //{
  //  Pop.sort_by_fitness(maximize);
  //  Pop.clonal_offspring(selection_rate,mutation_rate);
  //}
}

//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - https://github.com/borkowsk/bookProcessingPL
//-////////////////////////////////////////////////////////////////////////////////////////////////////////
//_EOC
