// Świat jest jedną z dwóch centralnych klas każdego modelu ABM
//-/////////////////////////////////////////////////////////////

class World implements simulation_world
{
  int _counter=0; //znak '_' jest konwencjonalnym oznaczeniem nazw "wewnętrznych"
  
  //Agent agents[]; //Jednowymiarowa tablica agentów OR ...
  Agent agents[][]; //Dwuwymiarowa tablica agentów
  
  World(int side) //Konstruktor obiektu "Świata"
  {
    //agents=new Agent[side]; //OR
    agents=new Agent[side][side];
  }
  
  float  getTimeStep() //„Getter” dla kroku symulacji
  {
    return _counter;
  }
  
  void initializeModel() //Metoda 1.
  {
    initializeAgents(this.agents);
  }
  
  void changeState() //Metoda 2.
  {
    changeAgents(this.agents);
  }
  
  void makeStatistics()
  {
    doStatisticsOnAgents(this.agents);
  }
  
  void modelFullStep()
  {
     this.changeState();
     this.makeStatistics();
     
     //Inne zmiany...
     //...
     
     _counter++;
  }
};

//Dla statystyki
float meanStress=0;
int   liveCount=0;

// Bardziej rozbudowane funkcjonalności można zdefiniować jako funkcje samodzielne,
// nie jako metody ze względu na niewystarczająco elastyczną składnię Processingu (i jęz. JAVA)
//-/////////////////////////////////////////////////////////////////////////

void visualizeModel(World world)
{
   visualizeAgents(world.agents);
}

void modelStep(World world)
{
   world.changeState();   
   world.makeStatistics();
   world._counter++; //Wykorzystanie pola wewnętrznego!!! Processing na to pozwala, ale to "zła praktyka".
}

//-/////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF SAKODA
//-/////////////////////////////////////////////////////////////////////////////////////////////
