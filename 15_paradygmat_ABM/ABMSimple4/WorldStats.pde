/// Statystyki świata symulacji.
/// @date 2026-06-12 (begin)
//*/////////////////////////////////////////////////////////////////////////////

int[] allCounts=null; ///< liczniki kierunków ruchu pieszych/spacerowiczów.

void census(World currWorld)
{
  // Przygotowanie...
  if(allCounts==null)
  {
    allCounts=new int[allDirs.length]; // Potrzebujemy nowego.
  }
  else
  {
    for(int i=0;i<allCounts.length;i++) // po prostu resetujemy liczniki.
      allCounts[i]=0;
  }
    
  // Rzeczywiste zliczanie:
  for(int row=0;row<WSide;row++)
    for(int col=0;col<WSide;col++)
      if(currWorld.plane[row][col]!=null)
      {
         Dirs tmp=currWorld.plane[row][col].direction;
         int  ind=tmp.ordinal(); // w którym kierunku
         allCounts[ind]++;
      }
      
  // Najprostsza prezentacja:    
  for(int i=0;i<allCounts.length;i++)
    print("\t",allCounts[i]);
   
  println(" ----- Step:",nf(frameCount,9),"-----");  
}
