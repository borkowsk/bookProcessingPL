/// Create a new row, so new bubble with random diameter
void mousePressed()
{
  for (Bubble b : bubbles) 
  {
    if(b==null) continue;
    b.rollover(mouseX, mouseY,true);
  }
  /*
  TableRow row = table.addRow();
  // Set the values of that row
  row.setInt(" id",(int)random(9999));
  row.setFloat("x", mouseX);
  row.setFloat("y", mouseY);
  row.setFloat("diameter", random(40, 80));
  row.setString("name", "Blah");

  // If the table has more than 10 rows
  if (table.getRowCount() > 10) {
    // Delete the oldest row
    table.removeRow(0);
  }

  // Writing the CSV back to the same file
  saveTable(table, "data/testNew.csv");
  filename="testNew.csv";
  // And reloading it
  loadData();
  makeBubbles();
  */
}

void keyPressed()
{
  if(key==' ')
  {
    if(output.length()==0)
      output="X_"+VarX+"_Y_"+VarY+"_D_"+VarDiam+"_R_"+VarRed+"_G_"+VarGreen+"_B_"+VarBlue+"_cs_"+CaseName;
    save(output);
    println("Saved output file:",output);
  }
}
//*===========================================================================================================
/// "Bubbler" - Program do wizualizacji bąbelkowej
/// 2022 @link "https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI"
//*////////////////////////////////////////////////////////////////////////////////////////////////////////////
