// Synchronizacja w parze dwu iteracji równania logistycznego 
/////////////////////////////////////////////////////////////////////
static float  DefaultAlfa=0.20000000000; // Siła symetrycznego związku
static long   MyRSeed=0; // Inicjalizacja liczb losowych - jak 0 to z czasu.
static int    backgrey=128; // Kolor tła

//Parametry wizualizacji
static final boolean Clean=true; //Czy czyścić poprzedni stan
static final boolean Continuous=true; //Czy morfować pośrednie stany? ("oszustwo" dla tego modelu!)
static final int     VISUAL=10;  // Co ile klatek liczymy nowy stan? (pomiędzy to morfing)
static final int     Frames=50;  // Tempo filmu
static final int     VisRate=1000; // Maksymalne tempo programu
static final boolean All=false; // Czy zapisujemy każdą klatkę czy co VISUAL?
static final int     resetTime=1000*VISUAL; // Co ile klatek zmieniamy parametr Alfa?

class singiel
{
  double x1,x2;
  double r;
  double alfa;
  float getX1(){ return (float)x1;}
  float getX2(){ return (float)x2;}  
  
  singiel(float iX,float iR,float iAlfa)
  {
    x1=x2=iX;r=iR;alfa=iAlfa;
  }
  void next() //Bez pary
  {
    x1=x2;
    x2=x1*r*(1-x1);
  }
}

  void next4couple(singiel F,singiel S)
  {
    F.x2=F.x2*(1-F.alfa)+S.x2*F.alfa;
    S.x2=S.x2*(1-S.alfa)+F.x2*S.alfa;
    F.next();
    S.next();
  }

singiel First,Second;

int radius=400;
int pos=radius;
int viscounter=0;
int stecounter=0;
int vert=300;

float xFo,xSo; //Przed poprzednie stany - do wizualizacji "continous"

void status()
{
  ellipseMode(CENTER); 
  textSize(20);
  textAlign(CENTER);
  text("r="+First.r,pos,20);
  text("r="+Second.r,pos*3,20);
  text("alfa="+DefaultAlfa,pos*2,20);
  println(First.x1+" "+First.r+" "+First.alfa);
  println(Second.x1+" "+Second.r+" "+Second.alfa);
  
  fill(0);stroke(64);
  rectMode(CORNER);
  rect(pos*1.5,vert-radius/2,pos,pos);
  rectMode(CENTER); 
}

void setup()
{
  long unixTime = System.currentTimeMillis() / 1000L;
  if(MyRSeed==0) MyRSeed=unixTime;
  if(MyRSeed!=0) randomSeed(MyRSeed);
  
  First=new  singiel(random(1000)/1000.0,3.4+random(600)/1000.0,DefaultAlfa);
  Second=new singiel(random(1000)/1000.0,3.4+random(600)/1000.0,DefaultAlfa);
  xFo=First.getX1();
  xSo=Second.getX1();
  
  //size(1200,800);
  size(1280,720); //HDTV 720p  1280×720
  background(backgrey);
  delay(100);
  frameRate(250);
  //noSmooth();
  
  radius=width/4;
  pos=radius;
  vert=height/2;
  initVideoExport(this,"couple5_"+nf(MyRSeed,11,0)+".mp4",Frames);
  FirstVideoFrame();

  status();

  NextVideoFrame(); //Video frame
}

boolean wantReset=false;

void draw()
{
  stroke(0);
  
  if(wantReset || frameCount % resetTime == 0 )
  {
    backgrey=(int)random(144);
    background(backgrey);
    //DefaultAlfa=random(0.5)*random(0.5); //Wersja bez 5_ w nazwie miała dwa randomy tutaj
    DefaultAlfa=random(0.5);
    First.alfa=DefaultAlfa;
    Second.alfa=DefaultAlfa;
    status();
    wantReset=false;
    stecounter=0; // do wizualizacji punktów
  }
  
  if(Clean)
  {
     fill(backgrey);
     noStroke();
     rect(pos  ,vert,radius+3,radius+3);
     rect(pos*3,vert,radius+3,radius+3);
  }
  
  if(Continuous)
  {
    // noStroke();
    float pp=(float)viscounter/VISUAL; // Który etap morfingu (0..1)
    
    fill(0,160,120+130*pp); //,256/VISUAL);
    
    float af=pp*(First.getX1()-xFo); // Os A
    float bf=pp*(First.getX2()-First.getX1()); // Os B pierwszego
    ellipse(pos  ,vert,round((xFo+af)*radius),round((First.getX1()+bf)*radius) ); // println("pp:"+pp+" A:"+round((xFo+af)*radius)+" B:"+round((First.getX1()+bf)*radius)+" af:"+af+" bf:"+bf);
    
    af=pp*(Second.getX1()-xSo); // Os A
    bf=pp*(Second.getX2()-Second.getX1()); // Os B drugiego
    ellipse(pos*3,vert,round((xSo+af)*radius),round((Second.getX1()+bf)*radius) );
  }
  else
  {
   if(stecounter%2==0) fill(0,150+viscounter*5,100+viscounter*10);
                  else fill(0,100+viscounter*10,150+viscounter*5);
   ellipse(pos  ,vert,round(First.getX1()*radius),round(First.getX2()*radius));
   ellipse(pos*3,vert,round(Second.getX1()*radius),round(Second.getX2()*radius));
  }
  
  if(++viscounter==VISUAL)
  { 
   xFo=First.getX1();  // Stany przed-poprzednie ...
   xSo=Second.getX1(); // ... do wizualizacji ciągłej
   
   next4couple(First,Second); // TYLKO CO "VISUAL" RAMEK JEST SYMULACJA
   
   // println("x:"+xFo+" "+First.getX1()+" "+First.getX2());
   stroke(30+stecounter,30+stecounter/2,stecounter/4);
   point(pos*1.5+pos*First.getX2(),vert+radius/2-pos*Second.getX2());
   
   viscounter=0;
   stecounter++;
   println("Fr/s:",frameRate);
   
   if(!All) NextVideoFrame();//Video frame
  }
  
  if(All) NextVideoFrame();//Video frame
}

//  Event handlers:
// ////////////////

void keyPressed()   { wantReset=true; }

void mousePressed() { exit(); }
