/// stado ptaków (boids 2D)
//-////////////////////////

final int NORD_SOUTH=1000; ///< maksymalna odległość z północy na południe
final int WEST_EAST=1000;  ///< maksymalna odległość z zachodu na wschód
final int MAX_CEIL=100;    ///< maksymalny pułap lotu
final int HM_BIRDS=50;     ///< ile ptaków
final boolean targeted=false;  ///< Czy otrzymują swoje cele w ramach inicjalizacji?

// Parametry algorytmu Boids (patrz: https://people.ece.cornell.edu/land/courses/ece4760/labs/s2021/Boids/Boids.html)
final float   protectedRange=min(NORD_SOUTH,WEST_EAST)/50.0; ///< „Zakres, w którym odlatują od innych”
final float   protectedRangeSquared=protectedRange*protectedRange;
final float   visualRange=min(NORD_SOUTH,WEST_EAST)/15.0;   ///< „Zakres, w którym zmierzają do środka masy stada”
final float   visual_range_squared=visualRange*visualRange;
final float   avoidfactor=0.04;
final float   matchingfactor=0.05;
final float   centeringfactor=0.005;
final float   turnfactor=0.02;
final float   maxspeed=4;
final float   minspeed=2;
final float   margin=100;
final float   leftmargin=margin;
final float   rightmargin=WEST_EAST-margin;
final float   topmargin=margin;
final float   bottommargin=NORD_SOUTH-margin;

ArrayList<Bird> birds;     ///< wszystkie nasze ptaki w kontenerze z jezyka JAVA

void initBirds()
{
  birds=new ArrayList(HM_BIRDS);
  for(int i=0;i<HM_BIRDS;i++)
    birds.add(new Bird(NORD_SOUTH,WEST_EAST,MAX_CEIL,targeted));
}

/// @note Zakładamy, że ptaki są zawsze prawidłowo posegregowane pod względem wysokości.
void showBirds()
{
   for(int i=0;i<HM_BIRDS;i++)
   {
     Bird current=birds.get(i);
     float ZRatio=current.z/MAX_CEIL;
     current.showBird(2+ZRatio*20); // Parametr - sposób na prezentację wysokości na teraz.
     if(current.isTargeted())
     {
       stroke(red(current.co),green(current.co),blue(current.co));
       line(current.x,current.y,current.tx,current.ty);
     }
   }
}

void settings()
{
  size(WEST_EAST,NORD_SOUTH);
}

void setup()
{
  initBirds();
  sortBirds();
  showBirds();
  decisions();
  frameRate(20); // Na początku powoli
}

void draw()
{
  moveBirds();
  sortBirds();
  background(32);
  showBirds();
  decisions();
}

/// @date 2026-01-15 (modified)