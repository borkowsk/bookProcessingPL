/// stado ptaków (boids 2D)
//-////////////////////////

final int NORD_SOUTH=1000; ///< maksymalna odległość z północy na południe
final int WEST_EAST=1000;  ///< maksymalna odległość z zachodu na wschód
final int MAX_CEIL=200;    ///< maksymalny pułap lotu
final int HM_BIRDS=100;    ///< ile ptaków
final boolean TARGETED=false;  ///< Czy otrzymują swoje cele w ramach inicjalizacji?

final boolean VIEW_TARGETING=true; ///< Show lines for current targets?

// Parametry algorytmu Boids (patrz: https://people.ece.cornell.edu/land/courses/ece4760/labs/s2021/Boids/Boids.html)
final float   protectedRange=min(NORD_SOUTH,WEST_EAST)/50.0; ///< „Zakres, w którym odlatują od innych”
final float   protectedRangeSquared=protectedRange*protectedRange;
final float   visualRange=min(NORD_SOUTH,WEST_EAST)/15.0;   ///< „Zakres, w którym zmierzają do środka masy stada”
final float   visualRangeSquared=visualRange*visualRange;
final float   avoidFactor=0.04;
final float   matchingFactor=0.05;
final float   centeringFactor=0.005;
final float   turnFactor=0.02;
final float   maxSpeed=10;
final float   minSpeed=6;
final float   margin=100;
final float   westMargin=margin;
final float   eastMargin=WEST_EAST-margin;
final float   nordMargin=margin;
final float   southMargin=NORD_SOUTH-margin;
final float   groundMargin=max(protectedRange,MAX_CEIL*0.05);
final float   ceilMargin=MAX_CEIL*0.95;

ArrayList<Bird> birds;     ///< wszystkie nasze ptaki w kontenerze z jezyka JAVA

void initBirds()
{
  birds=new ArrayList(HM_BIRDS);
  for(int i=0;i<HM_BIRDS;i++)
    birds.add(new Bird(NORD_SOUTH,WEST_EAST,MAX_CEIL,TARGETED));
}

/// @note Zakładamy, że ptaki są zawsze prawidłowo posegregowane pod względem wysokości.
void showBirds()
{
   for(int i=0;i<HM_BIRDS;i++)
   {
     Bird current=birds.get(i);
     float ZRatio=current.z/MAX_CEIL;
     current.showBird(2+ZRatio*20); // Parametr - sposób na prezentację wysokości na teraz.
     if(VIEW_TARGETING && current.isTargeted())
     {
       stroke(red(current.co)/2,green(current.co)/2,blue(current.co)/2);
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
  frameRate(25);
  println("protectedRange:",protectedRange,"visualRange:",visualRange);
}

void draw()
{
  moveBirds();
  sortBirds();
  background(32);
  showBirds();
  decisions();
  fill(255);
  //text(str(frameRate)+" frm/sec",10,height-10);
}

/// @date 2026-01-15 (modified)