// Agent is a one of two central class of each ABM model
///////////////////////////////////////////////////////////////
class Agent
{
  //float dummy;//ATRYBUT DEMONSTRACYJNY - POTEM MOŻNA USUNĄĆ
  //NOWY KOD
  int   state;
  float immunity;
  
  Agent()//Konstruktor agenta. Inicjuje atrybuty
  {
    //dummy=0;
    //NOWY KOD
    state=Susceptible;
    immunity=random(0.0,1.0);//Zamiast PTransfer!
  }
}

///////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM: AGENT FOR FILL UP
///////////////////////////////////////////////////////////////////////////////////////////
