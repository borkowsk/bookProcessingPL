//Program Processingu w trybie 2 - z widocznymi funkcjami
//////////////////////////////////////////////////////////

void setup() //Jest wykonywane raz - po uruchomieniu
{
  size(500,500);
  background(0,0,200); //rgB
  noSmooth(); //Bez wygładzania lini 
  ellipse(250, 250, 200, 200);
}


int i=0; //Nasz własny licznik wykonań
void draw() //Jest wykonywane w niewidocznej pętli
{
  fill(0,i,0); //rGb
  arc(250, 250, 200, 200, radians(i-10),radians(i));
  i+=10;
}

// https://github.com/borkowsk/bookProcessingPL
