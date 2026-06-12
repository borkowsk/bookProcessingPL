// Świat jest jedną z dwóch centralnych klas każdego modelu ABM
//-/////////////////////////////////////////////////////////////


class World implements simulation_world
{
  int _counter=0;
  
  //Agent agents[]; //Jednowymiarowa tablica agentów
  //OR
  Agent agents[][]; //Dwuwymiarowa tablica agentów
  
  World(int side) //Konstruktor obiektu "Świata"
  {
    //agents=new Agent[side];
    //OR
    agents=new Agent[side][side];
  }
   
  float  getTimeStep() //„Getter” dla kroku symulacji
  {
    return _counter;
  }
  
  void initializeModel()
  {
    initializeAgents(this.agents);
    //inne inicjalizacje
    //...
  }
  
  void changeState()
  {
    changeAgents(this.agents);
    //inne zmiany
    //...
  }
  
  void makeStatistics()
  {
    doStatisticsOnAgents(this.agents);
  }
  
  void modelFullStep()
  {
     this.changeState(); //„this” jest tutaj zbędne. Tylko przykładowo.
     this.makeStatistics();
     
     //inne zmiany...
     //...
     
     _counter++;
  }
  
}

// Bardziej rozbudowane funkcjonalności są definiowane jako funkcje samodzielne,
// nie jako metody z powodu niewystarczająco elastycznej składni w Processingu.
//-/////////////////////////////////////////////////////////////////////////////

void visualizeModel(World world)
{
  visualizeAgents(world.agents);
}

//-/////////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: WORLD OF SAKODA
//-/////////////////////////////////////////////////////////////////////////////////////////////
