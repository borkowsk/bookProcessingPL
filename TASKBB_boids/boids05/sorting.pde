// Sztuczka magiczna - sortowanie zaczerpnięte z języka JAVA.
//-//////////////////////////////////////////////////////////

import java.util.*;

void sortBirds() ///< Sortowanie, bo ptaki lecące niżej muszą być narysowane jako pierwsze!
{
  birds.sort(new Comparator<Bird>() {
      public int compare(Bird b1, Bird b2) // Tutaj potrzebujemy czystej składni jez. JAVA.
      {
         if(b1.z<b2.z) return -1;
         else if(b1.z>b2.z) return 1;
         else return 0;
      }
    });
}

/// @date 2025-12-10 (modified)