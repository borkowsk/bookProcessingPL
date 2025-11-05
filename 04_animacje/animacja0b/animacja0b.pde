// Program z obiema funkcjami wymaganymi

void setup() //To działa raz na początku.
{
  size(500,200); //Ustalamy rozmiar okna,
  background(0,0,128); // kolor jego tła
  stroke(255,255,0); // i kolor punktów
}

void draw() //To działa w niewidocznej w kodzie, nieskończonej pętli
{
  point(random(width),random(height));
}

// https://github.com/borkowsk/bookProcessingPL
