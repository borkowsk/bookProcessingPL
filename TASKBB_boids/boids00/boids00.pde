/// stado ptaków
//-///////////////

class Bird
{
  float x, y, z;     //!< pozycja
  float vx, vy, vz;  //!< wektor szybkosci
  float tx, ty, tz;  //!< pozycja aktualnego celu
  color co; //!< potrzebujemy koloru, żeby odróżnić ptaki

  Bird(float north_south, float east_west, float down_up)
  {
    co=color(random(256), random(256), random(256));
    vx=vy=vz=0; 
    tx=random(north_south);
    ty=random(east_west);
    tz=0;
    x=random(north_south);
    y=random(east_west);
    z=random(down_up);
  }
} //end_of_class

final int NORD_SOUTH=1000; ///< maksymalna odległość z północy na południe
final int WEST_EAST=1000;  ///< maksymalna odległość z zachodu na wschód
final int MAX_CEIL=100;    ///< maksymalny pułap lotu
final int HM_BIRDS=20;     ///< ile ptaków

ArrayList<Bird> birds;     ///< wszystkie nasze ptaki w kontenerze z jezyka JAVA

void initBirds()
{
  birds=new ArrayList(HM_BIRDS); // Tworzy pustą listę o określonej pojemności początkowej...
  for (int i=0; i<HM_BIRDS; i++) // ... i wypelnia.
    birds.add(new Bird(NORD_SOUTH, WEST_EAST, MAX_CEIL));
}

/// @note Zakładamy, że ptaki są zawsze prawidłowo posegregowane pod względem wysokości.
void showBirds()
{
  for (int i=0; i<HM_BIRDS; i++)
  {
    Bird current=birds.get(i);
    float ZRatio=current.z/MAX_CEIL;
    fill(red(current.co), green(current.co), blue(current.co));
    ellipse(current.x, current.y, 2+ZRatio*100,2+ZRatio*100); //To jest sposób na prezentację wysokości na teraz.
  }
}

void settings()
{
  size(WEST_EAST, NORD_SOUTH);
}

void setup()
{
  initBirds();
  sortBirds();
  showBirds();
}

/// @date 2025 (initial)