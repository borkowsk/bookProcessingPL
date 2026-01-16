/// Decyzje i działania ptaków mają konsekwencje fizyczne
void moveBirds()
{
   for(int i=0;i<HM_BIRDS;i++)
   {
     Bird current=birds.get(i);
     // Przesuwanie ptaków...
     current.x+=current.vx;
     current.y+=current.vy;
     current.z+=current.vz;
     
     // Sprawdzanie kolizji do chmur i ziemi.
     if(current.z>=MAX_CEIL)
     {
       current.z=MAX_CEIL;
       current.vz*=-1;
     }
     else 
     if(current.z<=0)
     {
       current.vx=current.vy=current.vz=0;
     } 
   }
}

/// @date 2025-11-25 (modified)