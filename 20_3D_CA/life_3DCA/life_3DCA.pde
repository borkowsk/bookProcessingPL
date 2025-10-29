// TRÓJWYMIAROWA gra w zycie.
//See: https://content.wolfram.com/sites/13/2023/02/16-4-7.pdf
//4,5/5 ; 5,..,7/6 ; 5,6/5 ; 6,..,8/5 (?) ; 2,3/5 ;  7,8/5
int SIDE=61;    // bok świata
int MINNEIB=7;  // najmniejsza dozwolonba liczba sąsiadów
int MAXNEIB=8;  // najwieksza dozwolonba liczba sąsiadów
int BIRNEIB=5;  // liczba sąsiadów konieczna do ozywienia komórki

float DENSITY=0.33; // poczatkowa gęstość komórek

int FRAMES=10; // liczba klatek na sekundę
color BACKGROUND=0; // kolor tła

int CELLS=0;   // M/SIDE - bok komórki
int TRANS=228; //nieprzeroczystość żywych komórek
int CELLDIV=3; //ile razy obiekt w komórce jest mniejszy od rozmiarów komórki.

float RotX=-0.05; // rotacja względem X
float RotY=-0;    // rotacja względem Y
float correction=0.25; //korekcja (offset) położenia X i Y komórki
float Zcorr=0;    // korekcja Z komórki


int [][][] theWorld;
int [][][] newWorld;

void initWorld()
{
  theWorld=new int [SIDE][SIDE][SIDE];
  newWorld=new int [SIDE][SIDE][SIDE];
  for (int a=0; a<SIDE; a++)
    for (int b=0; b<SIDE; b++)
      for (int c=0; c<SIDE; c++)
      {
        int state=(random(1.0)<DENSITY?1:0);
        theWorld[a][b][c]=state;
      }
  theWorld[SIDE/2][SIDE/2][SIDE/2]=1;   
}

void newStateOfWorld()
{
   for (int a=0; a<SIDE; a++)
   {
     int right = (a+1) % SIDE;         
     int left  = (SIDE+a-1) % SIDE;
     
     for (int b=0; b<SIDE; b++)
     {
       int dw = (b+1) % SIDE;         
       int up = (SIDE+b-1) % SIDE;
       
       for (int c=0; c<SIDE; c++)
       {
         int back = (c+1) % SIDE;         
         int forw = (SIDE+c-1) % SIDE;
         
         int state=theWorld[a][b][c];
         int newst=
                  +theWorld[right][b][c]
                  +theWorld[left ][b][c]
                  +theWorld[a][dw][c]
                  +theWorld[a][up][c]
                  +theWorld[right][dw][c]
                  +theWorld[right][up][c]
                  +theWorld[left][dw][c]
                  +theWorld[left][up][c]
                  
                  +theWorld[right][b][back]
                  +theWorld[left ][b][back]
                  +theWorld[a][dw][back]
                  +theWorld[a][up][back]
                  +theWorld[right][dw][back]
                  +theWorld[right][up][back]
                  +theWorld[left][dw][back]
                  +theWorld[left][up][back]
                  
                  +theWorld[right][b][forw]
                  +theWorld[left ][b][forw]
                  +theWorld[a][dw][forw]
                  +theWorld[a][up][forw]
                  +theWorld[right][dw][forw]
                  +theWorld[right][up][forw]
                  +theWorld[left][dw][forw]
                  +theWorld[left][up][forw]
                  
                  +theWorld[a][b][back]
                  +theWorld[a][b][forw]
         ;
         
         if(state==0)
             state=(newst==BIRNEIB?1:0);
         else    
             state=(MINNEIB<=newst && newst<=MAXNEIB ? 1:0);
         newWorld[a][b][c]=state;
       }
     }
   }
   
   int [][][] tmp=theWorld;
   theWorld=newWorld;
   newWorld=tmp;
}

void visualiseWorld()
{
  int HALF=SIDE/2;
  if(RotX!=0) rotateX(RotX);
  if(RotY!=0) rotateY(RotY);
  float R=CELLS/CELLDIV;
  for (int a=0; a<SIDE; a++)
  {
    float X=(a+correction)*CELLS;
    for (int b=0; b<SIDE; b++)
    {
      float Y=(b+correction)*CELLS;
      for (int c=0; c<SIDE; c++)
      {
        int state=theWorld[a][b][c];
        switch(state) { //Instrukcja wyboru pozwala nam wybrać dowolny kolor w zależności od liczby w konmórce
        case 0:continue;//fill(0, 0, 0, 32); break; 
        case 1:fill(255, 255, (c*255.0)/SIDE, TRANS);
          break;
        default:fill(255, 255, 255); //To się pojawiac nie powinno
          break;
        }

        float Z=-(c*CELLS)+Zcorr;
        pushMatrix();
        translate(X, Y, Z);
        sphere(R);
        //box(R,R,R);
        popMatrix();
        
        //if(c==HALF)
        //{
        //  rect(-50+a*4,-50+b*4,4,4);
        //}
      }
    }
  }
}

void setCameraZ()
{
  float fov = PI/2.5; //PI/3
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height),
    cameraZ/2.0,
    cameraZ*20.0 //How deep object is still randered.
    );
}

void setup()
{
  size(900, 900, P3D);
  noStroke();
  frameRate(FRAMES);
  setCameraZ();
  initWorld();
  float M=min(width, height);
  CELLS=int(M/SIDE);
  sphereDetail(8);
}

int i=0;
void draw()
{
  println(i);
  background(BACKGROUND);
  //lights();
  directionalLight(255, 255, 255, 0, 0, -1);

  visualiseWorld();

  //pushMatrix();
  //fill(255, 255, 0);
  //translate(min(width-i, 399), min(height-i, 399), -i);
  //sphere(150);
  //popMatrix();
  
  //RotY-=0.01;
  //Zcorr-=5;
  newStateOfWorld();
  i++;
}
