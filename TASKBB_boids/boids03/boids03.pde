/// stado ptaków
//-///////////////

final int NORD_SOUTH=1000; ///< maksymalna odległość z północy na południe
final int WEST_EAST=1000;  ///< maksymalna odległość z zachodu na wschód
final int MAX_CEIL=100;    ///< maksymalny pułap lotu
final int HM_BIRDS=10;     ///< ile ptaków

ArrayList<Bird> birds;     ///< wszystkie nasze ptaki w kontenerze z jezyka JAVA

void initBirds()
{
  birds=new ArrayList(HM_BIRDS); // Tworzy pustą listę o określonej pojemności początkowej.
  for(int i=0;i<HM_BIRDS;i++)
    birds.add(new Bird(NORD_SOUTH,WEST_EAST,MAX_CEIL));
}

/// @note Zakładamy, że ptaki są zawsze prawidłowo posegregowane pod względem wysokości.
void showBirds()
{
   for(int i=0;i<HM_BIRDS;i++)
   {
     Bird current=birds.get(i);
     float ZRatio=current.z/MAX_CEIL;
     current.showBird(2+ZRatio*100); // Parametr - sposób na prezentację wysokości na teraz.
     stroke(red(current.co),green(current.co),blue(current.co));
     line(current.x,current.y,current.tx,current.ty);
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
  background(64);
  showBirds();
  decisions();
}


/// @date 2025-12-10 (modified)