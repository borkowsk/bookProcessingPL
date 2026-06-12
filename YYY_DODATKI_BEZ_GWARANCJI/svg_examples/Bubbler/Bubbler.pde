/// Program do wizualizacji bąbelkowej - z przykładu:
/// Loading Tabular Data * by Daniel Shiffman.  
/// https://processing.org/examples/loadsavetable.html
/**
 * This example demonstrates how to use loadTable()
 * to retrieve data from a CSV file and make objects 
 * from that data.
 *
 * Here is what the TEST.CSV looks like:
 * (WARNING! First name of column have allways leading space!)
 *
 id,x,y,diameter,name
 1,160,103,43.19838,Happy
 2,372,137,52.42526,Sad
 3,273,235,61.14072,Joyous
 4,121,179,44.758068,Melancholy
 */
import processing.svg.*; ///< https://processing.org/reference/libraries/svg/index.html
//import processing.pdf.*; ///< https://processing.org/reference/libraries/pdf/index.html

/// Data filename. It can be a full path or name of
/// a file located in the "data" directory of the script!
//String fileName="/home/borkowsk/SCC/private/SocialImpact2/Grapher/testpoza.csv";
//String fileName="testNew.csv";
String fileName="BixSBixSi.csv"; ///< from DataIntegrator on RTSI data
String options="header";

//String fileName="/home/borkowsk/SCC/private/SocialImpact2/RToSInfluence/src/RTSIPNASbr140/results/RTSIsc1.48cRnd0000000016_Ne.4Si50_Cr.0Bi10.00-30SBi05.00-5nA160Am0.0Sm0.25mT0.001No0Al0.1Be0eT0eA160eS0eFS0eFa0.out";
//String options="header,tsv";

/// Path to graphics driver class
String driver="";    ///< Possible are: P2D, P3D, FX2D, PDF, SVG
//String driver=SVG; ///< Other possible are: P2D, P3D, FX2D, PDF
//String driver=PDF; ///< Other possible are: P2D, P3D, FX2D, SVG

//String output="output.pdf"; ///< for PDF
String output="output.svg";   ///< for SVG
//String output="";           ///< for others than PDF or SVG

float TEXTSIZE=14;
float BUBBLE_OPACITY=255;
float BUBBLE_MAXDIAM=20;
float BUBBLE_VERDIAM=56;

int   reqWidth=1000; ///< required width of scatter graph
int   reqLegend=300; ///< required width of legend
int   reqHeight=560; ///< required hight of scatter graph
int   reqStatus=int(BUBBLE_VERDIAM+TEXTSIZE*7); ///< required hight of scatter bar
color LEGEND_BACKGROUND=color( 144,111,144 );

int   outputSelector=1; ///< what type of visualisation? 0 - no any.

/// Names of used variables
String CaseName="filename";//""$REPET";
String VarX="Bi";//"H9";//" ambientTemp";//" meanTemp";//" StepCounter";//" ambientTemp";
String VarY="SBi";//" StepCounter";//"meanOpinion";
String VarDiam="providersCount";//"providersCount";//" liveCount";
String VarRed="meanDistSelf";
String VarGreen="providersCount";//meanDistSelf";//" StepCounter";//" meanTemp";//"$REPET";// ambientTemp";//" StepCounter";//
String VarBlue="";//meanDistSelf";//" meanTemp";//$REPET";//" StepCounter";

boolean usedName=CaseName.length()>0;
boolean usedX=VarX.length()>0;
boolean usedY=VarY.length()>0;
boolean usedDiam=VarDiam.length()>0;
boolean usedRed=VarRed.length()>0;
boolean usedGreen=VarGreen.length()>0;
boolean usedBlue=VarBlue.length()>0;
//boolean used=.length()>0;

public void settings() 
{ 
  if(driver.length()>0)
  {
    if(output.length()<=0)
    {
      
    }
    println("driver:",driver,"\noutput:",output);
    size(reqWidth+reqLegend,reqHeight+reqStatus,driver,output);
  }
  else
    size(reqWidth+reqLegend,reqHeight+reqStatus);
}

void setup()
{ 
  println("'Bubbler' - Program do wizualizacji bąbelkowej");
  println("(c) 2022 https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI");
  println("OPTIONS are:","X","Y","D","R","G","B","CASENAME","FILENAME","FILEOPTIONS","OUTPUT");
  println("Separator is ':'. For example: 'R:$id'\n");
  
  //noSmooth();
  loadData(fileName,options); // Loading data and print variable names!
  
  //initDictionary(fileName);
  //saveDictionary(fileName);
  loadDictionary(fileName);
  
  println("\nFor make output graphics press SPACE!");
  textSize(TEXTSIZE);
  
  if(outputSelector>0
  && usedX && usedY
  ) // For now only one type.
  {
    frameRate(10);
    ellipseMode(CENTER);  // Set ellipseMode to CENTER
    //ellipseMode(RADIUS);  // Set ellipseMode to RADIUS
    //DEF_BUBBLE_SHAPE=BubbShape.Rect;
    makeBubbles();
  }
  else
  exit();
}

void draw() 
{
  if(outputSelector>0) // For now only one.
    drawBubbles(); //Drawing scatter plot with sizable and colorable points represented by diferent shapes
 
  if(reqStatus>0) fillStatus();
  
  // PDF and SVG required exit in draw to save data into file
  if(output.length()>0 && driver.length()>0 ) 
     exit();
}

void fillStatus()
{
  float colscaleBeg=height-reqStatus+BUBBLE_VERDIAM/2;
  textAlign(LEFT,TOP);  
  if(usedX){ fill(64); text( "X: "+VarX + " : " + dictionaryInfo(VarX), BUBBLE_MAXDIAM,colscaleBeg+=TEXTSIZE); }
  if(usedY){ fill(128,0,0); text( "Y: "+VarY + " : " + dictionaryInfo(VarY), BUBBLE_MAXDIAM,colscaleBeg+=TEXTSIZE); }
  if(usedDiam){ fill(0); text( "D: "+VarDiam + " : " + dictionaryInfo(VarDiam), BUBBLE_MAXDIAM,colscaleBeg+=TEXTSIZE); }
  if(usedRed){ fill(255,0,0); text( "R: "+VarRed + " : " + dictionaryInfo(VarRed), BUBBLE_MAXDIAM,colscaleBeg+=TEXTSIZE); }
  if(usedGreen){ fill(0,255,0); text( "G: "+VarGreen + " : " + dictionaryInfo(VarGreen), BUBBLE_MAXDIAM,colscaleBeg+=TEXTSIZE); }
  if(usedBlue){ fill(0,0,255); text( "B: "+VarBlue + " : " + dictionaryInfo(VarBlue), BUBBLE_MAXDIAM,colscaleBeg+=TEXTSIZE); }
  if(usedName){ fill(0); text( "CaseName: "+CaseName + " : " + dictionaryInfo(CaseName), BUBBLE_MAXDIAM ,colscaleBeg+=TEXTSIZE); }
}

//*===========================================================================================================
/// "Bubbler" - Program do wizualizacji bąbelkowej
/// 2022 @link "https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI"
//*////////////////////////////////////////////////////////////////////////////////////////////////////////////
