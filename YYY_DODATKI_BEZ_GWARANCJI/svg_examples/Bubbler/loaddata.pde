/// Load CSV file into a Table object
/// "header" option indicates the file has a header row
/// WARNING! First name have allways leading space!

Table table; ///< A Table object

void loadData(String filename,String options)
{
  println("filename:",filename);
  table = loadTable(filename,options);
  println("Rows:",table.getRowCount(),"Colums:",table.getColumnCount());
  if(table.getRowCount()==0 || table.getColumnCount()==0)
  {
    println("Strange file, exiting...");
    exit();
  }
  print("Column names (case sensitive): ");
  String[] names=table.getColumnTitles();
  for(String cname : names) 
    print("'"+cname+"' ");//! WARNING! First name (may) have allways leading space!
  println("\nBe careful with spaces, when they are included in names!");
}

//*===========================================================================================================
/// "Bubbler" - Program do wizualizacji bąbelkowej
/// 2022 @link "https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI"
//*////////////////////////////////////////////////////////////////////////////////////////////////////////////
