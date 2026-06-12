//   Zainspirowany Sakodą model AGENTOWY wykorzystujący dyskretną geometrię 1D lub 2D
//   @author Wojciech Borkowski
//-///////////////////////////////////////////////////////////////////////////////////////

//Parametry modelu
int side=100; //długość boku głównej macierzy
String modelName="ABMSakoda";
float density=0.55;

World TheWorld=new World(side); //... ale również zostanie zainicjowany wewnątrz setup()

//Parametry wizualizacji etc...
int cwidth=8; //
int STATUSHEIGH=40;
int STEPSperVIS=1;
int FRAMEFREQ=20;
boolean WITH_VIDEO=false;
boolean simulationRun=true; //Flaga startu/stopu

void setup()
{
  //Grafika
  size(800,840);
  frameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  
  //Model
  TheWorld.initializeModel();
  initializeStats(); //Wykomentowanie blokuje tworzenie pliku log!
  TheWorld.makeStatistics();
  
  //Okno 
  println("REQUIRED SIZE OF PAINTING AREA IS "+(cwidth*side)+"x"+(cwidth*side+STATUSHEIGH));
  cwidth=(height-STATUSHEIGH)/side;
    
  if(WITH_VIDEO) 
  {
    initVideoExport(this,modelName+".mp4",FRAMEFREQ);
    FirstVideoFrame();
  }
  
  //Zakończenie etapu konfiguracji
  println("CURRENT SIZE OF PAINTING AREA IS "+width+"x"+height); //-myMenu.bounds.height???
  visualizeModel(TheWorld); //Pierwszy raz wizualizacja
  if(!simulationRun)
    println("PRESS 'r' or 'ESC' to start simulation");
  else
    println("PRESS 's' or 'ESC' to pause simulation");
  NextVideoFrame(); //Wykorzystuje zmienną wewnętrzną do sprawdzenia, czy jest włączone
}

void draw()
{
  if(simulationRun)
  {
    TheWorld.modelFullStep();
  }
  
  writeStatusLine();
  
  if(!simulationRun //Po wstrzymaniu symulacji powinna działać tylko wizualizacja
  || TheWorld.getTimeStep() % STEPSperVIS == 0 ) //Ale gdy model jest uruchomiony, wizualizacja powinna być wykonywana od czasu do czasu
  {
    visualizeModel(TheWorld);
    NextVideoFrame(); //Wykorzystuje zmienną wewnętrzną do sprawdzenia, czy jest włączone
  }

}

void writeStatusLine()
{
  fill(255);noStroke();
  rect(0,side*cwidth,width,STATUSHEIGH);
  
  fill(0);textAlign(LEFT, TOP);
  text(liveCount+"  "+meanStress,0,side*cwidth);
  textAlign(LEFT, BOTTOM);
  text(TheWorld.getTimeStep()+")  Fps:"+ frameRate,0,side*cwidth+STATUSHEIGH-2);
}

//-/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM SAKODA MAIN 
//-/////////////////////////////////////////////////////////////////////////////////////////
