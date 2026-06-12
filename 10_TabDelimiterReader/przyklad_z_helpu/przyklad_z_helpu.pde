  
BufferedReader reader;
String line;
 
void setup() {
  //Otwórz plik jak w przykładzie createWriter()
  reader = createReader("data.txt"); 
  size(200,200);
  background(0);
}

/*
void exit(){
  reader.close(); //"Exception" w analizie kodu! Błąd PROCESSINGU
  super.exit();
}
*/

void draw() {
  try {
    line = reader.readLine(); //Wykonujemy czytanie ZABEZPIECZONE linii
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    //Przerwij czytanie z powodu błędu lub pustego pliku
    noLoop();  
    //reader.close(); //"Exception" w analizie kodu! Błąd PROCESSINGU
  } else {
    println(line);
    String[] pieces = split(line, TAB); //Dzielimy linie tam gdzie są tabulatory
    int x = int(pieces[0]);
    int y = int(pieces[1]);
    int s = int(pieces[2]);
    println(x,' ',y,' ',s);
    stroke(s);
    point(x, y);
  }
} 
