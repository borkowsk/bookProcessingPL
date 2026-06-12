//Czytanie danych tekstowych
//(format zapisu wg. alternatywnego schematu)
String FileName="log.txt";
BufferedReader reader;
String line;
 
void setup() {
  frameRate(100);
  //Otwórz plik jak w przykładzie createWriter()
  reader = createReader(FileName);    
}
 
void draw() {
  try {
    line = reader.readLine();
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  
  if (line == null) {
    //Przerwij czytanie z powodu błędu lub pustego pliku
    noLoop();  
  } else {
    int[] xyz=new int[3];
    int count=0;
    String[] pieces = split(line, '\t');
    for(String s:pieces) {
      int val=int(s);
      if(val!=0 || (!s.isEmpty() && s.charAt(0)=='0')) {
        print('"'+s+'"',TAB);
        xyz[count++]=val;
      }
    }
    
    if(count>0) {
      print(":"+TAB+xyz[0]+TAB+xyz[1]+TAB+xyz[2]);
      println();
    }
    
    //point(xyz[0], xyz[1]);
  }
} 
