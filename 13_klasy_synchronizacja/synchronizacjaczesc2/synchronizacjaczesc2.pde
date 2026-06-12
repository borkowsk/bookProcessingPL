//zdefiniowaliśmy klasę, teraz jej użyjemy, 
//-///////////////////////////////////////////////////////////////////////////////

final  float DefaultAlfa=0.1; //współczynnik "spięcia", synchronizacji
int Rozbieg=100;

singiel First, Second; // uchwyty do obiektów, jak zwykła liczba `float` czy `int`, 
                      //to że je zadeklarujemy nie oznacza ze istnieją same obiekty. 
                      //Obiekty powstaną później, więc uchwyty uchwycą dopiero to co powstanie

int Ws=400;                      
void setup()
{
  size(1200,800); //3*Ws , 2* Ws
  frameRate(1000);
  
 // First=new singiel // tworzymy nowy obiekt, będzie typu singiel wpisujemy konstrukt singiel
 First=new singiel(random(1.0), 3.5+random(0.5), DefaultAlfa); // 3,5 do 5 bo patrzymy na synchronizację w chaosie, wtedy jest najciekawsza
 Second=new singiel(random(1.0), 3.5+random(0.5), DefaultAlfa); //dwa systemy od siebie niezależne, zmieniając "alfa" możemy zwiększać ich wzajemną synchronizację
 
 println("1st:",First.x1+" "+First.r+" alfa:"+First.alpha()); //uchwyt do obiektu, robi za nazwę obiektu,
 println("2st:",Second.x1+" "+Second.r+" alfa:"+Second.alpha()); // kropka i nazwa pola lub nazwa metody
}


float scaleY(double X)
{
  return Ws-(float)X*Ws;
}

int N=0;

float Gre=0;
float Blu=255;
float Red=255;

void draw()
{
  next4couple(First,Second);
  //println("1st:",First.x1,"\t2nd:",Second.x1);
  
  if(N<2*Ws)
  {
    stroke(Red,0,0,25);
    line(N-1,scaleY(First.x1),N,scaleY(First.x2)); //musimy napisać, z którego obiektu bierzemy x1,x2
    
    stroke(0,0,Blu,25);
    line(N-1,scaleY(Second.x1),N,scaleY(Second.x2));
    stroke(0,0,25);
  
    stroke(255);
    point(N,scaleY(abs(First.x2-Second.x2)));
    
    stroke(0,255,0);
    point(2*Ws+First.x2*Ws,scaleY(Second.x2));
    
    if(N>Rozbieg) //to wyrzucić to będzie widać dojście do atraktora
    {
       noStroke();
       fill(0,Gre,0);ellipse(2*Ws+First.x2*Ws,scaleY(Second.x2),4.5,4.0);
       fill(Red,0,0);ellipse(First.x1*Ws,Ws+scaleY(First.x2),4.5,4.0);
       fill(0,0,Blu);ellipse(Ws+Second.x1*Ws,Ws+scaleY(Second.x2),4.5,4.0);
    }
    
    N++; // tu kończymy wyrzucanie
  }
  else
  {
    N=0;
    println("realFM:",frameRate,"\tX=",First.x1,Second.x2);
    First.x2=random(1.0);
    Second.x2=random(1.0);
    Gre=random(255);Blu=random(255);Red=random(255);
  }

}
