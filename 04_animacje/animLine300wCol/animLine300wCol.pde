//Color line animation

void setup() 
{
  frameRate(32);
  size(256,300);
  //strokeWeight(3); //Odkomentuj żeby zobaczyć co się stanie
}

int pos = 0;

void draw() 
{
  //background(128); //Odkomentuj żeby zobaczyć co się stanie
  pos++;
  stroke(pos,50,50); //teraz kolor zależy od pozycji!
  line(pos, 20, pos, 280);
}

// https://github.com/borkowsk/bookProcessingPL
