//Przezroczyste losowe elipsy

float W; //Zmienna globalna

void setup()
{
  size(600,600);  //rozmiar okna
  frameRate(100); //szybkość animacji
  noStroke();     //bez konturów
  //Gdy już wiadomo jakie wymiary okna szukamy mniejszego
  W=min(width,height); //wartość minimalna z dwóch wartości
}

//Własna funkcja
int radius()
{
  return int(random(W/10));
}

//wizualizacja oraz dynamika (zmiana stanu)
void draw()
{
  float alfa=random(128); //Z wylosowaną przezroczystością
  fill(random(255),random(255),random(255),alfa);
  float r=radius();
  ellipse(random(W),random(W),r,r);
}

//https://github.com/borkowsk/bookProcessingEN
//https://github.com/borkowsk/bookProcessingPL
