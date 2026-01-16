/// decyzje i działania ptaków.
void decisions()
{
   for(int i=0;i<HM_BIRDS;i++)
   {
     Bird current=birds.get(i);
     if(current.isTargeted())
         thinkAndDoTarget(current);
     else
         thinkAndDoBoids(current,i);
   }
}

int signum(float v)
{
  if(v<0) return -1;
  else if(v>0) return 1;
  else return 0;
}

/// prosta orientacja na cel.
void thinkAndDoTarget(Bird me)
{
  float dx=me.tx-me.x;
  float dy=me.ty-me.y;
  float dz=me.tz-me.z;
  
  // Czy cel został osiągnięty?
  if(sqrt(dx*dx+dy*dy+dz*dz)<=1.0)
  {
    println("Caught! Go up!");
    me.vx=0;
    me.vy=0;
    me.vx=0;
    me.tz=MAX_CEIL+1; // Taka wysokość docelowa jest jednak nieosiągalna
  }
  else  // JESZCZE NIE! Podejdź bliżej! :-)
  {
    me.vx=dx*0.01; if(abs(me.vx)<1) me.vx=signum(dx);
    me.vy=dy*0.01; if(abs(me.vy)<1) me.vy=signum(dy);
    me.vz=dz*0.01; if(abs(me.vz)<0.1) me.vz=signum(dz)*0.1;
    println(me.vx,me.vy,me.vz);
  }
}

/// Implementacja algorytmu boids.
/// Zobacz: https://people.ece.cornell.edu/land/courses/ece4760/labs/s2021/Boids/Boids.html
void thinkAndDoBoids(Bird boid,int myIndex)
{
  // Dla każdego "boidu" - jest jeden poziom wyżej. . .  //for each boid (boid):
  
      // Wyzeruj wszystkie zmienne akumulatorowe.
      float xpos_avg, ypos_avg, xvel_avg, yvel_avg, neighboring_boids, close_dx, close_dy;
      xpos_avg=ypos_avg=xvel_avg=yvel_avg=neighboring_boids=close_dx=close_dy = 0.0;
  
      // Dla każdego innego "dziecka" w stadzie . . .
      //for each other boid (otherboid):
      for(int i=0;i<HM_BIRDS;i++)
      if(i!=myIndex)
      {
          Bird otherboid=birds.get(i);
          
          // Oblicz różnice we współrzędnych x i y
          float dx = boid.x - otherboid.x;
          float dy = boid.y - otherboid.y;
  
          // Czy obie te różnice są mniejsze niż zasięg widzenia?
          if (abs(dx)<visualRange && abs(dy)<visualRange)
          {
              // Jeśli tak, oblicz kwadrat odległości
              float squared_distance = dx*dx + dy*dy;
  
              // Czy kwadratowa odległość jest mniejsza od zakresu chronionego?
              if (squared_distance < protectedRangeSquared)
              {
                  // Jeśli tak, dolicz różnicę współrzędnych x i y dla pobliskiego boida
                  close_dx += boid.x - otherboid.x;
                  close_dy += boid.y - otherboid.y;
              }
              // Jeśli inny nie znajduje się w zasięgu ochrony, to czy znajduje się w zasięgu wzroku?
              else if (squared_distance < visual_range_squared)
                   {
                      // Dodaj współrzędne x,y i prędkość x,y innego boidu do zmiennych akumulatorowych
                      xpos_avg += otherboid.x;
                      ypos_avg += otherboid.y;
                      xvel_avg += otherboid.vx;
                      yvel_avg += otherboid.vy;
      
                      // Zwiększ liczbę boidów w zasięgu wzroku o 1.
                      neighboring_boids += 1;
                   }
          }        
      } // koniec dla "if (i!=myIndex)"
      
      // Gdy w zasięgu wzroku znajdowały się jakieś boidy...
      if (neighboring_boids > 0) 
      {
          // Podziel zmienne akumulatora przez liczbę boidów w zasięgu wzroku
          xpos_avg = xpos_avg/neighboring_boids;
          ypos_avg = ypos_avg/neighboring_boids;
          xvel_avg = xvel_avg/neighboring_boids;
          yvel_avg = yvel_avg/neighboring_boids;
  
          // Dodaj wkład centrowania i dopasowania do prędkości (z odpowiednimi czynnikami skali)
          boid.vx = (boid.vx + 
                     (xpos_avg - boid.x)*centeringfactor + 
                     (xvel_avg - boid.vx)*matchingfactor);
  
          boid.vy = (boid.vy + 
                     (ypos_avg - boid.y)*centeringfactor + 
                     (yvel_avg - boid.vy)*matchingfactor);
      }
      
      // Dodaj wkład unikania do prędkości (take z czynnikiem skali)
      boid.vx = boid.vx + (close_dx*avoidfactor);
      boid.vy = boid.vy + (close_dy*avoidfactor);
  
      // Jeśli boid znajduje się blisko krawędzi, spraw, aby obracał się o współczynnik obrotu, 
      // ale proporcjonalnie do odległości od dozwolonego obszaru
      if(boid.x < leftmargin)
          boid.vx = boid.vx + turnfactor*abs(boid.x - leftmargin);
      if(boid.x > rightmargin)
          boid.vx = boid.vx - turnfactor*abs(boid.x - rightmargin);
      if(boid.y > bottommargin)
          boid.vy = boid.vy - turnfactor*abs(boid.y - bottommargin);
      if(boid.y < topmargin)
          boid.vy = boid.vy + turnfactor*abs(boid.y - topmargin);

  
      // Oblicz nowa prędkość boidu.
      // (Powolne! Wyszukaj algorytm „alfa max plus beta min”)
      float speed = sqrt(boid.vx*boid.vx + boid.vy*boid.vy); // Funkcja sqrt jest dość "droga"
  
      // Wymuszaj minimalne i maksymalne prędkości
      if (speed < minspeed)
      {
          boid.vx = (boid.vx/speed)*minspeed;
          boid.vy = (boid.vy/speed)*minspeed;
      }
      
      if (speed > maxspeed)
      {
          boid.vx = (boid.vx/speed)*maxspeed;
          boid.vy = (boid.vy/speed)*maxspeed;
      }
      
      // Aktualizacja pozycji boida - jest w worldphysics!
      //boid.x = boid.x + boid.vx;
      //boid.y = boid.y + boid.vy;
}


/// @date 2026-01-15 (modified)