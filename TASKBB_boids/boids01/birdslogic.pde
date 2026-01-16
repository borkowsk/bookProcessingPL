/// decyzje i działania ptaków
void decisions()
{
   for(int i=0;i<HM_BIRDS;i++)
   {
     Bird current=birds.get(i);
     thinkAndDo0(current);
   }
}

/// prosta orientacja na cel
void thinkAndDo0(Bird me)
{
  float dx=me.tx-me.x;
  float dy=me.ty-me.y;
  float dz=me.tz-me.z;
  
  // Czy cel został osiągnięty?
  if(dx==0 && dy==0 && dz==0)
  {
    println("Caught! Go up!");
    me.vx=0;
    me.vy=0;
    me.vx=0;
    me.tz=1000; // Wysokość docelowa jest teraz nieosiągalna //<>//
  }
  else // Cel zbliża się niczym w paradoksie "Zenona z Elei"   ;-)
  {
    me.vx=dx*0.01;
    me.vy=dy*0.01;
    me.vz=dz*0.01;
  }
}

/// @date 2025-11-25 (modified)