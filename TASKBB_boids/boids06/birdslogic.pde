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
    println("Caught! Change a goal, now!");
    me.vx=0;
    me.vy=0;
    me.vz=0;
    if(me.tz<MAX_CEIL/2)
    {
      me.tz=MAX_CEIL-1; // Taka wysokość jest możliwa do osiągnięcia.
    }
    else 
    {
      me.tx=-NORD_SOUTH;me.ty=-WEST_EAST;me.tz=MAX_CEIL+1; // Not the real target.
    }
  }
  else // JESZCZE NIE! Podejdź bliżej! :-)
  {
    me.vx=dx*0.01; if(abs(me.vx)<1) me.vx=signum(dx);
    me.vy=dy*0.01; if(abs(me.vy)<1) me.vy=signum(dy);
    me.vz=dz*0.01; if(abs(me.vz)<0.1) me.vz=signum(dz)*0.1;
    println(me.vx,me.vy,me.vz);
  }
}

/// Implementacja algorytmu boids (teraz 3D)
/// Zobacz: https://people.ece.cornell.edu/land/courses/ece4760/labs/s2021/Boids/Boids.html
void thinkAndDoBoids(Bird boid,int my_index)
{
  // Dla każdego "boidu" - jest jeden poziom wyżej. . .  //for each boid (boid):
  
      // Wyzeruj wszystkie zmienne akumulatorowe.
      float xpos_avg, ypos_avg, zpos_avg, xvel_avg, yvel_avg, zvel_avg, neighboring_boids, close_dx, close_dy, close_dz;
      xpos_avg=ypos_avg=zpos_avg=xvel_avg=yvel_avg=zvel_avg=neighboring_boids=close_dx=close_dy=close_dz = 0.0;
  
      // Dla każdego innego "dziecka" w stadzie . . .
      //for each other boid (otherboid):
      for(int i=0;i<HM_BIRDS;i++)
      if(i!=my_index)
      {
          Bird otherboid=birds.get(i);
          
          // Oblicz różnice we współrzędnych x,y,z
          float dx = boid.x - otherboid.x;
          float dy = boid.y - otherboid.y;
          float dz = boid.z - otherboid.z;
  
          // Czy wszystkie te różnice są mniejsze niż zasięg widzenia?
          if (abs(dx)<visualRange && abs(dy)<visualRange && abs(dz)<visualRange)
          {
              // Jeśli tak, oblicz kwadrat odległości
              float squared_distance = dx*dx + dy*dy + dz*dz;
  
              // Czy kwadratowa odległość jest mniejsza od zakresu chronionego?
              if (squared_distance < protectedRangeSquared)
              {
                  // Jeśli tak, dolicz różnicę współrzędnych x,y,z dla pobliskiego boida
                  close_dx += boid.x - otherboid.x;
                  close_dy += boid.y - otherboid.y;
                  close_dz += boid.z - otherboid.z;
              }
              // Jeśli inny nie znajduje się w zasięgu ochrony, to czy znajduje się w zasięgu wzroku?
              else if (squared_distance < visualRangeSquared)
                   {
                      // Dodaj współrzędne x,y,z i prędkość x,y,z innego boidu do zmiennych akumulatorowych
                      xpos_avg += otherboid.x;
                      ypos_avg += otherboid.y;
                      zpos_avg += otherboid.z;
                      
                      xvel_avg += otherboid.vx;
                      yvel_avg += otherboid.vy;
                      zvel_avg += otherboid.vz;
                      
                      // Zwiększ liczbę boidów w zasięgu wzroku o 1.
                      neighboring_boids ++;
                   }
          }        
      } // koniec dla "if (i!=myIndex)"
      
      // Gdy w zasięgu wzroku znajdowały się jakieś boidy...
      if (neighboring_boids > 0) 
      {
          // Podziel zmienne akumulatora przez liczbę boidów w zasięgu wzroku
          xpos_avg = xpos_avg/neighboring_boids;
          ypos_avg = ypos_avg/neighboring_boids;
          zpos_avg = zpos_avg/neighboring_boids;
          
          xvel_avg = xvel_avg/neighboring_boids;
          yvel_avg = yvel_avg/neighboring_boids;
          zvel_avg = zvel_avg/neighboring_boids;
  
          // Dodaj wkład centrowania i dopasowania do prędkości (z odpowiednimi czynnikami skali)
          boid.vx = (boid.vx + 
                     (xpos_avg - boid.x)*centeringFactor + 
                     (xvel_avg - boid.vx)*matchingFactor);
  
          boid.vy = (boid.vy + 
                     (ypos_avg - boid.y)*centeringFactor + 
                     (yvel_avg - boid.vy)*matchingFactor);
                     
          boid.vz = (boid.vz + 
                     (zpos_avg - boid.z)*centeringFactor + 
                     (zvel_avg - boid.vz)*matchingFactor);           
      }
      
      // Dodaj wkład unikania do prędkości (tez z czynnikiem skali)
      boid.vx = boid.vx + (close_dx*avoidFactor);
      boid.vy = boid.vy + (close_dy*avoidFactor);
      boid.vz = boid.vz + (close_dz*avoidFactor);
  
      // Jeśli boid znajduje się blisko krawędzi, spraw, aby obracał się o współczynnik obrotu, 
      // ale proporcjonalnie do odległości od dozwolonego obszaru
      if(boid.x < westMargin)
          boid.vx = boid.vx + turnFactor*abs(boid.x - westMargin);
      if(boid.x > eastMargin)
          boid.vx = boid.vx - turnFactor*abs(boid.x - eastMargin);
          
      if(boid.y > southMargin)
          boid.vy = boid.vy - turnFactor*abs(boid.y - southMargin);
      if(boid.y < nordMargin)
          boid.vy = boid.vy + turnFactor*abs(boid.y - nordMargin);

      if(boid.z > ceilMargin)
          boid.vz = boid.vz - turnFactor*abs(boid.z - ceilMargin);
      if(boid.z < groundMargin)
          boid.vz = boid.vz + turnFactor*abs(boid.z - groundMargin);
  
      // Oblicz nowa prędkość boidu.
      // (Powolne! Wyszukaj algorytm „alfa max plus beta min”)
      float speed = sqrt(boid.vx*boid.vx + boid.vy*boid.vy + boid.vz*boid.vz); // Funkcja sqrt jest dość "droga"
  
      // Wymuszaj minimalne i maksymalne prędkości
      if (speed < minSpeed)
      {
          boid.vx = (boid.vx/speed)*minSpeed;
          boid.vy = (boid.vy/speed)*minSpeed;
          boid.vz = (boid.vz/speed)*minSpeed;
      }
      
      if (speed > maxSpeed)
      {
          boid.vx = (boid.vx/speed)*maxSpeed;
          boid.vy = (boid.vy/speed)*maxSpeed;
          boid.vz = (boid.vz/speed)*maxSpeed;
      }
      
      // Aktualizacja pozycji boida - jest w worldphysics!
}


/// @date 2026-01-15 (modified)