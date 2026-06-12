/// Abstrakcja miasta jako fraktal typu "dywanu Sierpińskiego"
/// @author Wojciech Borkowski
//-////////////////////////////////////////////////////////////

float limit=1; // Najmniejsza dopuszczalna szerokość ulicy i alei.

float fcars=0.05; // Ile miejsca na ulice lub aleje.
int   streetcount=0;
int   avenuecount=0;

void setup()
{
  size(600,600); //513?
  noSmooth();
  street(0,height); //Ulice są poziome
  avenue(0,width); //Aleje są pionowe
  println(streetcount,avenuecount);
}

void avenue(float start,float end)
{
  float len=end-start; //Szerokość pasa zabudowy
  float weight=len*fcars; //Szerokość alei
  if(weight<limit) return; //Czy nie za wąska dla samochodu?
  avenuecount++; //Zliczenie
  
  strokeWeight(weight);stroke(0);
  float center=(start+end)/2;
  line(center,0,center,height); //Aleje są pionowe
  avenue(start,center-weight/2);
  avenue(center+weight/2,end);
  //Kontrola
  //strokeWeight(0);stroke(random(255),255,random(255));
  //line(center,0,center,height);
}

void street(float start,float end)
{
  float len=end-start; //Szerokość pasa zabudowy
  float weight=len*fcars; //Szerokość ulicy
  if(weight<limit) return; //Czy nie za wąska dla samochodu?
  streetcount++; //Zliczenie
  
  strokeWeight(weight);stroke(0);
  float center=(start+end)/2;
  line(0,center,width,center); //Ulice są poziome
  street(start,center-weight/2);
  street(center+weight/2,end);
}
