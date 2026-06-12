// Agent jest jedną z dwóch centralnych klas każdego modelu ABM
//-////////////////////////////////////////////////////////////////
int Number_of_identities=3; //Ile jest wykluczających się tożsamości

class Agent
{
  float identity; //Tożsamość agenta: [1..Number_of_identities]
  float stress; //Stress w aktualnej pozycji [0..1]
  
  Agent() //Konstruktor Agenta
  {
    identity=round(random(1,Number_of_identities)); //Muszą bywać te same
    stress=0;
  }
};

//-/////////////////////////////////////////////////////////////////////////////////////////
//  https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI - ABM EXAMPLE: 
//  AGENT OF SAKODA MODEL & 2D BASIC INITIALISATION, STEP CHANGE & Wizualizacja
//-/////////////////////////////////////////////////////////////////////////////////////////
