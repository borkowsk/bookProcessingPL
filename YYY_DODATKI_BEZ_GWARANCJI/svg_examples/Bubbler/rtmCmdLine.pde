///   Reading model parameters from command line.  @file rtmCmdLine.pde
///   https://github.com/borkowsk/
//*///////////////////////////////////////////////////////////////////////////////////

String windowTitle=CaseName+"_x:"+VarX+"_y:"+VarY+"_d:"+VarDiam+"_R:"+VarRed+"_G:"+VarGreen+"_B:"+VarBlue;  ///< Window title, optionally changed within parameters
int   debug_level=0;///< GLOBAL!

void checkCommandLine() /// Parsing command line if available
{ 
    //extern int debug_level;
    
    //Is passing parameters possible?
    if(args==null)
    {
       //if(debug_level>0) 
       println("Command line parameters not available");
       return; //Not available!!!
    }

    if(debug_level>0)
    {
      println("args length is " + args.length);
      for(int a=0;a<args.length;a++)
          print(args[a]," ");
      println();
    }
    
    //... UTILISE PARAMETERS BELOW ...
    int Ecount=0;//Number of erros in parameters utilising
    
    for(int a=0;a<args.length;a++)
    {
      windowTitle+=" ";windowTitle+=args[a];
      
      String[] list = split(args[a], ':');
      if(debug_level>1)
      { 
        for(String s:list) 
          print("'"+s+"'"+' ');
        println();
      }
      

      if(list[0].equals("CONSOLE_STATS")) // vname as boolean set into true
      {
        //*_extern* criterion currCriterion;
        //CONSOLE_STATS=true;
        //println("CONSOLE_STATS:",CONSOLE_STATS);
      }
      else
      if(list[0].equals("TRUST_EPOCH")) //vname:i
      {
        //epochOfTrust=Integer.parseInt(list[1]);
        //println("How offten trust is reseted (in steps):",epochOfTrust);
      } 
      else
      //BubbShape DEF_BUBBLE_SHAPE=BubbShape.Circle;
      
      if(list[0].equals("MAXDIAM") || list[0].equals("maxdiam")) // vname:A
      {
         BUBBLE_OPACITY=Float.parseFloat(list[1]); //float BUBBLE_OPACITY=128;                         
         println("OPACITY of bubbles (0..255):",BUBBLE_OPACITY);                             
      }                                
      else
      if(list[0].equals("MAXDIAM") || list[0].equals("maxdiam")) // vname:A
      {
         BUBBLE_MAXDIAM=Float.parseFloat(list[1]);   //float BUBBLE_MAXDIAM=17;
         BUBBLE_VERDIAM=BUBBLE_MAXDIAM;
         println("MAXDIAM of bubbles:",BUBBLE_MAXDIAM);
      }                                
      else
      if(list[0].equals("VERDIAM") || list[0].equals("verdiam")) // vname:A
      {
         BUBBLE_VERDIAM=Float.parseFloat(list[1]);   //float BUBBLE_VERDIAM=48;
         BUBBLE_VERDIAM=BUBBLE_MAXDIAM;
         println("MAXDIAM/VERDIAM of bubbles:",BUBBLE_MAXDIAM,BUBBLE_VERDIAM);
      }                                
      else
      //if(list[0].equals("SCRBIAS")) // vname:A:B
      //{      
        //*_extern* float         SCRAMB_BIAS_MEAN;//=0; // Desired mean value of bias for SCRAMBLERS
        //*_extern* float         SCRAMB_BIAS_DISP;//=10;// Desired dispersion for SCRAMBLERS. Each BIAS is inside range (mean-dispersion,mean+dispersion)
        //SCRAMB_BIAS_MEAN=Float.parseFloat(list[1]); // TU JEST OK!
        //SCRAMB_BIAS_DISP=Float.parseFloat(list[2]);
        //println("SCRBIAS:",SCRAMB_BIAS_MEAN,"+-",SCRAMB_BIAS_DISP);
      //}
      //else
      //if(list[0].equals("ALFABETAGAMA") ) // vname:A:B:C
      //{
      //Współczynniki się nie wykluczają! Można uczyć się i za pomocą ALFA - indywidualnych ludzi, i za pomocą BETA - zaufania do społeczności
      //*_extern* float  ALFA=0.1;///!!! How mach up or down trust when learning from reality? (ALPHA is defined by Processing)
      //*_extern* float  BETA=0.1;///each link is changed by +-betha/k. Let us assume that k = sqrt(n) for starters.
      //*_extern* float  GAMA=0.1;///How much agent change own reliability in each step of learning
      //  ALFA=Float.parseFloat(list[1]);
      //  BETA=Float.parseFloat(list[2]);
      //  GAMA=Float.parseFloat(list[3]);
      //  println("ALFA:",ALFA,"; BETA",BETA,"; GAMA:",GAMA);
      //}
      //else
      //if(list[0].equals("RAINBOW")) //vname as swich
      //{
        //with_rainbow=!with_rainbow;
        //println("Now RAINBOW is"+(with_rainbow?"ON":"OFF"));
      //}
      //else
      if(list[0].equals("x") || list[0].equals("X")) // vname:string
      {
        VarX=list[1]; //String VarX="H9";//" ambientTemp";//" meanTemp";//" StepCounter";//" ambientTemp";
        println("X:",VarX);
      }
      else
      if(list[0].equals("y") || list[0].equals("Y")) // vname:string
      {
        VarY=list[1]; //String VarY=" StepCounter";//"meanOpinion";
        println("Y:",VarY);
      }
      else
      if(list[0].equals("d") || list[0].equals("D") || list[0].equals("diameter") || list[0].equals("Diameter") ) // vname:string
      {
        VarDiam=list[1]; //String VarDiam="providersCount";//" liveCount";
        println("D:",VarDiam);
      }
      else
      if(list[0].equals("r") || list[0].equals("R") || list[0].equals("red") || list[0].equals("RED") ) // vname:string
      {
        VarRed=list[1]; //String VarRed="$REPET";
        println("R:",VarRed);
      }
      else
      if(list[0].equals("g") || list[0].equals("G") || list[0].equals("green") || list[0].equals("GREEN") ) // vname:string
      {
        VarGreen=list[1]; //String VarGreen="$REPET";//" StepCounter";//" meanTemp";//"$REPET";// ambientTemp";//" StepCounter";//
        println("G:",VarGreen);
      }
      else
      if(list[0].equals("b") || list[0].equals("B") || list[0].equals("blue") || list[0].equals("BLUE") ) // vname:string
      {
        VarBlue=list[1]; //String VarBlue="";//" StepCounter";//" meanTemp";//$REPET";//" StepCounter";
        println("B:",VarBlue);
      }
      else
      if(list[0].equals("CASE") || list[0].equals("case") || list[0].equals("CASENAME") || list[0].equals("casename")) // vname:string
      {
        CaseName=list[1]; //String CaseName="$REPET";
        println("CASENAME:",CaseName);
      }
      else
      if(list[0].equals("filename") || list[0].equals("FILENAME")) // vname:string
      {
        fileName=list[1]; // fileName
        println("filename:",fileName);
        println("It can be a absolute path or name of a file located in the \"data\" directory of the script!");
        println("(WARNING: Relative paths may behave very strange!");
      }
      else
      if(list[0].equals("fileoptions") || list[0].equals("FILEOPTIONS")) // vname:string
      {
        options=list[1]; //options
        println("fileoptions:",options);
        println("may contain \"header\", \"tsv\", \"csv\", or \"bin\" separated by commas");
        println("NOTE: Proper file extension work instaed of option tsv,csv option"); 
        println("EXAMPLE: \"header\" \"header,tsv\"");
      }
      else
      if(list[0].equals("output") || list[0].equals("OUTPUT")) // vname:string
      {
        output=list[1]; //String output=""; ///< for others than PDF or SVG
        println("output:",output);
        println("It can be a absolute path or sole name of a file which will be located in the directory of the script!");
        println("(WARNING: Relative paths may behave very strange!");
      }
      else
      if(list[0].equals("HELP"))
      {
        Ecount=100;
      }
      else
      if(list[0].equals(""))
      {
        println("Empty parameter at position",a,"detected");
      }
      else
      {
        println("Unknown parameter '"+args[a]+"' detected");
        Ecount++;//OK
      }
    }
        
    if(Ecount!=0 )
    {
      if(Ecount!=100)
        println("Failed to understand",Ecount,"parameters");
      println("Need HELP???");
      println("OPTIONS:","X","Y","D","R","G","B","CASENAME","FILENAME","FILEOPTIONS","OUTPUT");
      exit();
    }
    
    //UPDATE
    usedName=CaseName.length()>0;
    usedX=VarX.length()>0;
    usedY=VarY.length()>0;
    usedDiam=VarDiam.length()>0;
    usedRed=VarRed.length()>0;
    usedGreen=VarGreen.length()>0;
    usedBlue=VarBlue.length()>0;
    windowTitle=CaseName+"_x:"+VarX+"_y:"+VarY+"_d:"+VarDiam+"_R:"+VarRed+"_G:"+VarGreen+"_B:"+VarBlue;
}


//*===========================================================================================================
/// "Bubbler" - Program do wizualizacji bąbelkowej
/// 2022 @link "https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI"
//*////////////////////////////////////////////////////////////////////////////////////////////////////////////
