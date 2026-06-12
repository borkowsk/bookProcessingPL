import java.io.FileReader;
import java.io.BufferedReader;
import java.text.*;//SimpleTextFormat;

StringDict variablesInformation;


String  dictionaryInfo(String keyStr)
{
  String out=variablesInformation.get(keyStr);
  if(out!=null)
      return out;
  else
      return "???";
}

void initDictionary()
{
  variablesInformation=new StringDict(new String[][] {
   { "var1", "To jest zmienna 1" },
   { "var2", "To jest zmienna 2" },
   { "var3", "To jest zmienna 3" }
 });
 
 println(variablesInformation);
}

void loadDictionary(String corename)
{
  String filename=corename+".dict";
  java.io.File file=new java.io.File(filename);
  if(file.exists())
  {
    SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//dd/MM/yyyy
    String strDate = sdfDate.format(file.lastModified());
    println("Dictionary load from:",file.getAbsolutePath(),strDate);
    BufferedReader reader=createReader(file.getAbsolutePath());
    variablesInformation=new StringDict(reader);
    println(variablesInformation);
  }
  else
  {
    println("Not exist file:",file.getAbsolutePath());
    initDictionary();
    println("Default dictionary was made!");
  }
}

void saveDictionary(String corename)
{
  if(variablesInformation!=null && corename!=null && corename.length()>0)
  {
    String filename=corename+".dict";
    java.io.File file=new java.io.File(filename);
    println("Dictionary saved in:",file.getAbsolutePath());
    variablesInformation.save(file);
  }
}
