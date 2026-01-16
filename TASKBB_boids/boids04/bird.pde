/// Klasa reprezentująca ptaka.
class Bird
{
  float x, y, z;     //!< pozycja
  float vx, vy, vz;  //!< wektor szybkosci
  float tx, ty, tz;  //!< pozycja aktualnego celu
  color co; //!< potrzebujemy koloru, żeby odróżnić ptaki
  
  Bird(float north_south,float east_west,float down_up) //!< Konstruktor
  {
    co=color(random(256),random(256),random(256));
    vx=vy=vz=0; 
    tx=random(north_south);
    ty=random(east_west);
    tz=0;
    x=random(north_south);
    y=random(east_west);
    z=down_up/2+random(down_up/2);
  }
  
  void showBird(float d) //!< wizualizacja pojedynczego ptaka.
  {
    stroke(co);
    fill(red(co),green(co),blue(co),128);
    float angle=atan2(ty-y,tx-x);
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

/// @date 2025-12-10 (modified)