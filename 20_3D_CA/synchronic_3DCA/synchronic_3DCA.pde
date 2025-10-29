//Trójwymiarowy, DETERMINISTYCZNY automat komórkowy - reguła "ZSUMUJ Z SĄSIADAMI I WEŹ MODULO". SYNCHRONICZNY.
//Siatka prostokatna, sąsiedztwo von Neumana.
//============================================================================================================
//
int SIDE=21;
int MAXSTATE=3;
int FRAMES=4;

float RotX=-0.05;
float RotY=-0;
int CELLS=90;
int TRANS=228;
int CELLDIV=5;
float correction=0.25;
float Zcorr=0;
color BACKGROUND=0;

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
        int state=0;//(int)random(MAXSTATE+0.9999);
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
         
         int state=theWorld[a][b][c]
                  +theWorld[right][b][c]
                  +theWorld[left ][b][c]
                  +theWorld[a][dw][c]
                  +theWorld[a][up][c]
                  +theWorld[a][b][back]
                  +theWorld[a][b][forw]
         ;
        
         state=state%(MAXSTATE+1);
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
        case 0:continue;//fill(0, 0, 0, 32);
        //  break; //Odpowiednio dobrany zestaw kolorów pozwala uzyskać ciekawe efekty
        case 1:fill(255, 255, 0, TRANS);
          break;
        case 2:fill(255,0,255, TRANS);
          break;
        case 3:fill(0,255,255, TRANS);
          break;
        case 4:fill(255, 0, 0, TRANS);
          break;
        case 5:fill(0, 0, 255, TRANS);
          break;
        case 6:fill(0, 255, 0, TRANS);
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
        
        if(c==HALF) //Wizualizacja przekroju jednej z płaszczyzn
        {
          rect(-50+a*4,-50+b*4,4,4);
        }
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

  //Różne testowe modyfikacje wizualizacji:
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
