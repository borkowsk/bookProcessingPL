// Zainspirowany Sakodą asynchroniczny MODEL OPARTY NA AGENTACH używający dyskretnej geometrii 1D lub 2D
//-/////////////////////////////////////////////////////////////////////////////////////////////////////

//Parametry modelu
int side=100; //długość boku głównej macierzy
String modelName="Sakoda0.5ABM";
float density=0.45;

//Parametry wizualizacji etc...
int cwidth=8; //długość boku komórki w wizualizacji
int STATUSHEIGH=40;
int STEPSperVIS=1;
int FRAMEFREQ=20;

World TheWorld=new World(side); //... ale również zostanie zainicjowany wewnątrz setup()

void setup()
{
  //Grafika
  size(800,840); //Nie można użyć tu zmiennych :-(
  frameRate(FRAMEFREQ);
  background(255,255,200);
  strokeWeight(2);
  
  //Okno 
  println("REQUIRED SIZE OF PAINTING AREA IS "+(cwidth*side)+"x"+(cwidth*side+STATUSHEIGH));
  println("CURRENT SIZE OF PAINTING AREA IS "+width+"x"+height);
  cwidth=(height-STATUSHEIGH)/side;
  
  //Model
  TheWorld.initializeModel(); //Inicjalizacja of the World
  visualizeModel(TheWorld); //Pierwszy raz wizualizacja
}

void draw()
{
  modelStep(TheWorld); //OBA ROZWIĄZANIA SĄ ZDEFINIOWANE
  //TheWorld.modelFullStep();
    
  if(TheWorld.getTimeStep() % STEPSperVIS == 0 ) //Ale gdy model jest uruchomiony, wizualizacja powinna być wykonywana od czasu do czasu
    visualizeModel(TheWorld);

  statusLine();
}

void statusLine()
{
  fill(255);noStroke();rect(0,side*cwidth,width,STATUSHEIGH);
  fill(0);
  textAlign(LEFT, TOP);text(liveCount+"  "+meanStress,0,side*cwidth);
  textAlign(LEFT, BOTTOM); text(TheWorld.getTimeStep()+")  Fps:"+ frameRate,0,side*cwidth+STATUSHEIGH-2);
}

interface simulation_world
{
  void   initializeModel();
  void   changeState();
  void   makeStatistics();
  void   modelFullStep();
  float  getTimeStep(); //„Getter” dla kroku symulacji
};

//-/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM SAKODA MAIN 
//-/////////////////////////////////////////////////////////////////////////////////////////
