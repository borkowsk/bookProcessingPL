/// Populacja agentów genetycznych do rozwiązywania jednowymiarowych problemów.
//-////////////////////////////////////////////////////////////////////////////
/// @date 2026-06-08 (last modification)
import java.lang.Math;

/// "GAgatek" czyli agent algorytmu genetycznego.
/// Gagatek to potoczne określenie oznaczające figlarza, łobuziaka lub osobę lekkomyślną, 
/// zdolną do nieodpowiedzialnych wybryków i drobnych wykroczeń.  
/// Synonimami są tu m.in. urwis, ancymonek, ziółko czy spryciarz.
class GAgatek
{
  int       gene; ///< Geny są inicjowane w konstruktorze.
  double fitness; ///< Fitness to dopiero określi środowisko. 
  GAgatek(int i_gene){ gene=i_gene;fitness=-Double.MAX_VALUE; }
};

class GAPopulation
{
  GAgatek[] all;
  
  double  minx,range; ///< Zakres wartości x w jakim szukamy.
  boolean gray_coded;
  
  GAPopulation(int size,double min_x,double max_x,boolean use_Gray)
  {
    all=new GAgatek[size];
    
    minx=min_x;
    range=max_x-min_x;
    gray_coded=use_Gray;
    
    for(int i=0;i<size;i++)
    {
      double r=Math.random()*range; 
      int as_NKB=map_(r,range);
      int as_gray=toGray(as_NKB);
      println(minx+r,'\t',r,'\t',toBin(as_NKB,32),'\t',minx+unmap_(as_NKB,range),'\t',toBin(as_gray,32),'\t',minx+unmap_(fromGray(as_gray),range)); //Test kodowania
      if(gray_coded)
        all[i]=new GAgatek(as_gray);
      else
        all[i]=new GAgatek(as_NKB);
    }
  }
  
  /// Odczytanie warości zakodowanej w genie konkretnego gagenta.
  double get_val(int index)
  {                                      assert(index<all.length);
    int from_gene=all[index].gene;
    if(gray_coded)
      return minx+unmap_(fromGray(from_gene),range);
    else
      return minx+unmap_(from_gene,range);  // NKB
  }
  
  /// Ustawienie nowej wartości fitness uzyskanej "ze środowiska".
  void set_fitness(int index,double new_fitness)
  {                                     assert(index<all.length);
    all[index].fitness=new_fitness;
  }
  
  /// Odczytanie wartości fitness.
  /// @return Wartość ustawioną w set_fitness, a jak jeszcze nie policzone to -Double.MAX_VALUE;
  double get_fitness(int index)
  {                                     assert(index<all.length);
    return all[index].fitness;
  }
  
  // MAPOWANIE ZAKRESU 0..maxVal na zakres integerów i z powrotem.
  //==============================================================
  
  // Szerokość zakresu docelowego (dla int jest to dokładnie 4 294 967 295).
  final double targetRange = (double) Integer.MAX_VALUE - (double) Integer.MIN_VALUE;
        
  private int map_(double val, double maxVal) 
  {
        // Zabezpieczenie przed wartościami spoza zakresu [0, maxVal]
        if (val <= 0) return Integer.MIN_VALUE;
        if (val >= maxVal) return Integer.MAX_VALUE;

        // Obliczenie zmapowanej wartości
        double mapped = (double) Integer.MIN_VALUE + (val / maxVal) * targetRange;

        return (int) Math.round(mapped);
  }

  private double unmap_(int codedVal, double maxVal) 
  {
      // Obliczenie pozycji codedVal w zakresie int (od 0 do 1)
      double percentage = ((double) codedVal - (double) Integer.MIN_VALUE) / targetRange;

      // Skalowanie powrotne do zakresu [0, maxVal]
      double unmapped = percentage * maxVal;

      // Zabezpieczenie przed minimalnymi błędami zaokrągleń zmiennoprzecinkowych
      if (unmapped <= 0) return 0.0;
      if (unmapped >= maxVal) return maxVal;

      return unmapped;
  }
  
};
