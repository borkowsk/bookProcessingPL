// Przykład na okno o zmiennych rozmiarach. 
// Reaguje na ciagnięcie rogu i walenie w klawiaturę.

void setup() 
{
  size(400, 400);
  surface.setResizable(true);
}

void draw()
{
  background(255);
  line(100, 100, width-100, height-100);
}

void keyPressed() 
{
  int side=round(random(100, 600));
  surface.setSize(side,side);
}

// https://github.com/borkowsk/bookProcessingPL
