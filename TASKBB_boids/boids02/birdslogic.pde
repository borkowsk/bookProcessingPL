// decyzje i działania ptaków
void decisions()
{
   for(int i=0;i<HM_BIRDS;i++)
   {
     Bird current=birds.get(i);
     thinkAndDo1(current);
   }
}

int signum(float v)
{
  if(v<0) return -1;
  else if(v>0) return 1;
  else return 0;
}

/// prosta orientacja na cel.
void thinkAndDo1(Bird me)
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
    me.vx=0; //<>//
    me.tz=1000; // Wysokość docelowa jest teraz nieosiągalna
  }
  else //JESZCZE NIE! Podejdź bliżej! :-)
  {
    me.vx=dx*0.01; if(abs(me.vx)<1) me.vx=signum(dx);
    me.vy=dy*0.01; if(abs(me.vy)<1) me.vy=signum(dy);
    me.vz=dz*0.01; if(abs(me.vz)<0.1) me.vz=signum(dz)*0.1;
    println(me.vx,me.vy,me.vz);
  }
}

/// @date 2025-11-25 (modified)