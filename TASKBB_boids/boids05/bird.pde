/// Klasa reprezentująca ptaka.
class Bird
{
  float x, y, z;     //!< pozycja
  float vx, vy, vz;  //!< wektor szybkosci
  float tx, ty, tz;  //!< pozycja aktualnego celu
  color co; //!< potrzebujemy koloru, żeby odróżnić ptaki
  
  Bird(float north_south,float east_west,float down_up,boolean targ) //!< Konstruktor
  {
    co=color(random(256),random(256),random(256));
    if(targ)
    {
      vx=vy=vz=0; 
      tx=random(north_south);
      ty=random(east_west);
      tz=0;
    }
    else
    {
      tx=-north_south;ty=-east_west;tz=0; // To nie jest prawdziwy cel.
      vx=random(north_south/1000)-north_south/2000;
      vy=random(east_west/1000)-east_west/2000;
      vz=0;
    }
    x=random(north_south);
    y=random(east_west);
    z=down_up/2+random(down_up/4);
  }
  
  boolean isTargeted()
  {
    return tx>=0 && ty>=0;
  }
  
  void showBird(float d) //!< wizualizacja pojedynczego ptaka.
  {
    stroke(co);
    fill(red(co),green(co),blue(co),128);
    float angle=atan2(vy,vx); // Wektor prędkości jest bardziej uniwersalnym wskaźnikiem kierunku.
    arc(x,y,d*0.9,d*0.9,angle-QUARTER_PI/6,angle+QUARTER_PI/6);
    noStroke();
    angle+=PI;
    arc(x,y,d,d,angle-QUARTER_PI/2,angle+QUARTER_PI/2);
    angle-=HALF_PI;
    arc(x,y,d,d,angle-QUARTER_PI/5,angle+QUARTER_PI/2);
    angle+=PI;
    arc(x,y,d,d,angle-QUARTER_PI/2,angle+QUARTER_PI/5); 
  }
  
} //end_of_class

/// @date 2026-01-15 (modified)