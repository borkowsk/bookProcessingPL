//Czytanie danych tekstowych
//(format zapisu wg. alternatywnego schematu)
String FileName="log.txt";
BufferedReader reader;
String line;
 
void setup() {
  frameRate(100);
  // Open the file from the createWriter() example
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
    // Stop reading because of an error or file is empty
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
