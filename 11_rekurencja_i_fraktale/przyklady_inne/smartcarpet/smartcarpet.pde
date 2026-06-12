/// Ten "szkic" przedstawia fraktal znany jako „dywan Sierpińskiego” w 6 iteracjach
/// https://www.openprocessing.org/sketch/141019/
//-///////////////////////////////////////////////////////////////////////////////////

float s=729;  // długość boku kwadratu pierwszej iteracji
              // (aby uzyskać dokładność pikselową, powinna to być potęga liczby 3)
int cpt=0;    // służy do wyświetlania w konsoli liczby wywołań funkcji rekurencyjnej,
              //  która rysuje fraktal

void setup()
{
  size(729, 729);
  background(255);
  noStroke();
  noLoop();
  noSmooth();
  rectMode(CENTER);
}

void draw()
{
  translate(365, 365);  //przesuń początek następnego rysunku do środka okna
  fill(0);
  square(s);  //wywołanie funkcji rekurencyjnej
  println(cpt);
  //save("Sierpinski_carpet.png");  //odkomentuj, jeśli chcesz zapisać zdjęcie na swoim komputerze
}

void square(float side)
{
  side=side/3;  //przy każdej iteracji kwadraty są 3 razy mniejsze

  if (side>=1)  //Funkcja będzie wywoływana dopóki rozmiar kwadratu nie będzie równy 1 pikselowi, ponieważ nie ma sensu rysować obiektów mniejszych od 1 piksela!
  {
    cpt++;  //zwiększyć „licznik wywołań”

    pushMatrix();  //Zabezpiecz parametry geometrii i narysuj lewy górny kwadrat
    rect(0, 0, side, side);
    translate(-side, -side);
    square(side);
    popMatrix();

    pushMatrix();  //Zabezpiecz parametry geometrii i narysuj górny środkowy kwadrat
    rect(0, 0, side, side);
    translate(0, -side);
    square(side);
    popMatrix();

    pushMatrix();  //Zabezpiecz parametry geometrii i narysuj prawy górny kwadrat
    rect(0, 0, side, side);
    translate(side, -side);
    square(side);
    popMatrix();

    pushMatrix();  //Zabezpiecz parametry geometrii i narysuj środkowy prawy kwadrat
    rect(0, 0, side, side);
    translate(side, 0);
    square(side);
    popMatrix();

    pushMatrix();  //Zabezpiecz parametry geometrii i narysuj prawy dolny kwadrat
    rect(0, 0, side, side);
    translate(side, side);
    square(side);
    popMatrix();

    pushMatrix();  //Zabezpiecz parametry geometrii i narysuj dolny środkowy kwadrat
    rect(0, 0, side, side);
    translate(0, side);
    square(side);
    popMatrix();

    pushMatrix();  //Zabezpiecz parametry geometrii i narysuj lewy dolny kwadrat
    rect(0, 0, side, side);
    translate(-side, side);
    square(side);
    popMatrix();

    pushMatrix();  //Zabezpiecz parametry geometrii i narysuj środkowy lewy kwadrat
    rect(0, 0, side, side);
    translate(-side, 0);
    square(side);
    popMatrix();
  }
}
