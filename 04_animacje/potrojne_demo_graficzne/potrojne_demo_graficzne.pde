//Processing ma swoją specyficzną strukturę aplikacji, która nieco utrudnia tworzenie
//programów sekwencyjnych, jakimi zazwyczaj są dema graficzne. Ale można to obejść...
////////////////////////////////////////////////////////////////////////////////////////

//Inicjalizacja programu
int W;
void setup()
{
  size(600,600);
  W=width;
}

int radius(int D) //Funkcja losująca ułamek rozmiaru okna
{
  return int(random(W/D));
}

void draw1() // demo nr 1
{
  fill(random(255),random(255),random(255),random(255)); //Czwarty parmetr oznacza przezroczystość
  float r=radius(10);
  ellipse(random(W),random(W),r,r);
}

void draw2() // demo nr 2
{
  fill(random(255),random(255),random(255),random(255));
  float r=radius(10);
  rect(random(W),random(W),r,r);
}

int i=0;
int R=0;
void draw3() // demo nr 3
{
  if(R==0) //Tylko pierwszy raz
      R=10+radius(2);
  fill(0,i%256,0,128);//rGb
  arc(W/2,W/2, R, R, radians(i-10),radians(i));
  i+=10;
}

int frame=0;
void draw()  // kolejno używa każdej z funkcji definiujących dema
{
  if(frame<500)
    draw1();
  else if(frame<999)
    draw2();
  else draw3(); 
  
  frame++;
}

// https://github.com/borkowsk/bookProcessingPL
