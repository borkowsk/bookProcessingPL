//Pętla z dwiema instrukcjami w bloku

size(500,500); //Potrzebny większy rozmiar okna
noSmooth(); //Bez wygładzania konturów

for(int i=0;i<256;i++) //POWTARZAJ 256x
{ //Instrukcja blokowa - POCZĄTEK
  stroke(i);
  line(i*2,i*2,0,500);
} //KONIEC

//http://processingwedukacji.blogspot.com
