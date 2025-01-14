//  "BILA" - MODEL RUCHU PUNKTU MATERIALNEGO - kolejne przybliżenia
//*////////////////////////////////////////////////////////////////
//  Program Processingu w trybie 2 - z widocznymi funkcjami
//*////////////////////////////////////////////////////////////////
int FR=100; //Na ile kroków dzielimy sekundę?

void setup() //Jest wykonywane raz - po uruchomieniu
{
  size(500,500);
  //noSmooth(); //Bez wygładzania lini? Po prostu odkomentować 
  background(0,0,200); //rgB
  frameRate(FR);
}

float h=0;
float x=0;
float vh=150; //prędkość pionowa w pikselach/SEKUNDE (!)
float vx=150; //prędkość pozioma
float ah=0;   //Przyśpieszenie/hamowanie - w pionie
float ax=0;   //I w poziomie
float M=0.95; //Wydajność odbicia sprężystego 1-B = ile energi kinetycznej się rozprasza nie wraca do prędkości po odbiciu

float R=random(255),G=random(255),B=random(255);
void draw() //Jest wykonywane w niewidocznej pętli
{
  //Wizualizacja
  R+=random(-2.0,2.0);
  G+=random(-2.0,2.0);
  B+=random(-2.0,2.0); //Losuje z zakresu i o tyle powiększa (jaki ujemna to pomniejsza)
  //print(R,' ');//,G,' ',B,"; ");
  fill(R,G,B);
  stroke(R/2,G/2,B/2);
  ellipse(x,height-h,25,25);
  
  //Właściwy model
  ah+=random(-100.0,100.0)*1/FR; //Sterowanie wg. preferencji
  ax+=random(-100.0,100.0)*1/FR; //może być asymetryczne - można zobaczyć do czego to prowadzi
  
  //Działanie przyśpieszeń
  vh+=ah*1/FR; //Powiększ prędkość o zmianę prędkości czyli przyśpieszenie pomnozone przez jednostkę czasu  //<>//
  vx+=ax*1/FR;
  h+=vh*1/FR;  //Zmień wysokość o drogę czyli prędkość pomnożoną przez jednostkę czasu
  x+=vx*1/FR;  //Zmień położenie poziome

  //Odbijamy od ścianek okna! Upraszczamy mechanizm odbicia
  if(h<0) 
  {
    vh=-vh*M;
    h=0; //Trochę oszukujemy
  }
  else
  if(height<h)
  {
    vh=-vh*M;
    h=height; //Trochę oszukujemy
  }
  //else //A jakby to wykomentować?
  if(x<0)
  {
     vx=-vx*M;
     x=0; //Trochę oszukujemy
  }
  else
  if(width<x)
  {
     vx=-vx*M;
     x=width; //Trochę oszukujemy
     //print(x,' ');
  }
}
