/// Populacja agentów genetycznych do rozwiązywania jednowymiarowych problemów.
//-////////////////////////////////////////////////////////////////////////////
/// @date 2026-06-08 (last modification)
import java.lang.Math;
import java.util.Arrays;
import java.util.Comparator;

/// @brief "GAgatek" czyli agent algorytmu genetycznego.
/// @details
/// Gagatek to potoczne określenie oznaczające figlarza, łobuziaka lub osobę lekkomyślną, 
/// zdolną do nieodpowiedzialnych wybryków i drobnych wykroczeń.  
/// Synonimami są tu m.in. urwis, ancymonek, ziółko czy spryciarz.
class GAgatek
{
  int       gene; ///< Geny są inicjowane w konstruktorze.
  double fitness; ///< Fitness to dopiero określi środowisko.
  
  GAgatek(int i_gene){ gene=i_gene;fitness=-Double.MAX_VALUE; }
  void reset_gene(int i_gene) { gene=i_gene;fitness=-Double.MAX_VALUE; }
  //double get_fitness() { return fitness; }
};

class GAPopulation
{
  GAgatek[] all;
  
  double  minx,range; ///< Zakres wartości x w jakim szukamy.
  boolean gray_coded; ///< Czy używamy kodowania Graya?
  
  /// @brief Konstruktor.
  GAPopulation(int population_size,double min_x,double max_x,boolean use_Gray)
  {
    all=new GAgatek[population_size];
    
    minx=min_x;
    range=max_x-min_x;
    gray_coded=use_Gray;
    
    for(int i=0;i<population_size;i++)
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
  
  // Akcesory:
  //==========
  
  /// @brief Odczytanie wartości zakodowanej w genie konkretnego gagenta.
  double get_val(int index)
  {                                      assert(index<all.length);
    int from_gene=all[index].gene;
    if(gray_coded)
      return minx+unmap_(fromGray(from_gene),range);
    else
      return minx+unmap_(from_gene,range);  // NKB
  }
  
  /// @brief Ustawienie nowej wartości fitness uzyskanej "ze środowiska".
  void set_fitness(int index,double new_fitness)
  {                                     assert(index<all.length);
    all[index].fitness=new_fitness;
  }
  
  /// @brief Odczytanie wartości fitness.
  /// @return Wartość ustawioną w set_fitness, a jak jeszcze nie policzone to -Double.MAX_VALUE;
  double get_fitness(int index)
  {                                     assert(index<all.length);
    return all[index].fitness;
  }
  
  // GŁÓWNE OPERACJE GENETYCZNE:
  //============================
  
  /// @brief Sortowanie wg. fitness. @note Musi być już znane dla wszystkich gagatków!
  /// @param maximize - czy szukamy/promujemy maksimum wartości `fitness` czy przeciwnie - minimum (co ma sens przy funkcjach).
  void sort_by_fitness(boolean maximize)
  {
    // ZBYT NOWOCZEŚNIE - NAWET Processing 4 tego nie rozumie: Arrays.sort(all,Comparator.comparingDouble(GAgatek::get_fitness()));
    
    // Sortowanie rosnąco w starszym stylu z dwuparametrową funkcją "lambda":
    // Trochę to "magiczne" bo funkcje Lambda pochodzą z "arsenału" profesjonalnego.
    if(maximize)
      Arrays.sort(all, (obiektA, obiektB) -> Double.compare(obiektA.fitness, obiektB.fitness));
    else
      Arrays.sort(all, (obiektA, obiektB) -> Double.compare(obiektB.fitness, obiektA.fitness));
  }
  
  /// @brief Klonowanie genu. Nowa wartość może być identyczna lub różnić się jednym bitem.
  int randomized_clone(int parent_gene)
  {
    //...mutations...

    return parent_gene; 
  }
  
  /// @brief Produkcja potomstwa najlepiej przystosowanych. 
  /// @note Zakładamy, że wcześniej policzono fitness i wykonano sortowanie!
  /// @param selection_r - współczynnik selekcji czyli jaka część populacji zostanie bezpowrotnie zastąpiona.
  /// @param mutation_r - jak często zachodzi flip bitu w powstającym klonie gagatka.
  /// @details
  /// Powstaje `population_size*selection_r` nowych agentów będacych (niekiedy zmutowanymi) klonami rodziców 
  /// wylosowanych z `population_size*(1-selection_r)` gagatków z "górnej" części tablicy `all`.
  void clonal_offspring(float selection_r,float mutation_r)
  {
  }
  
  /// @brief Produkcja potomstwa zwycięzców pojedynków losowych par. 
  /// @note Zakładamy, że wcześniej policzono `fitness`, ale nie wykonano sortowania!
  /// @param selection_r - współczynnik selekcji czyli jaka część populacji zostanie bezpowrotnie zastąpiona.
  /// @param mutation_r - jak często zachodzi flip bitu w powstającym klonie gagatka.
  /// @param maximize - czy szukamy/promujemy maksimum wartości `fitness` czy przeciwnie - minimum (co ma sens przy funkcjach).
  /// @details
  /// Powstaje `population_size*selection_r` nowych agentów będacych (niekiedy zmutowanymi) klonami rodziców,
  /// którzy wygrali pojedynki na wartość `fitness` w parach wylosowanych z powtórzeniami. 
  void clonal_offspring_by_duels(float selection_r,float mutation_r,boolean maximize)
  {
  }
  
  // MAPOWANIE ZAKRESU 0..maxVal na zakres integerów i z powrotem.
  //==============================================================
  
  /// @brief Szerokość zakresu docelowego (dla int 32 jest to dokładnie 4 294 967 295).
  final double targetRange = (double) Integer.MAX_VALUE - (double) Integer.MIN_VALUE;
        
  /// @brief Prywatne kodowanie wartości double z zakresu 0...maxVal na cały "signed int" 32-bitowy.      
  private int map_(double val, double maxVal) 
  {
        // Zabezpieczenie przed wartościami spoza zakresu [0, maxVal]
        if (val <= 0) return Integer.MIN_VALUE;
        if (val >= maxVal) return Integer.MAX_VALUE;

        // Obliczenie zmapowanej wartości
        double mapped = (double) Integer.MIN_VALUE + (val / maxVal) * targetRange;

        return (int) Math.round(mapped);
  }

  /// @brief Prywatne dekodowanie wartości z int z powrotem na zadany zakres 0...maxVal.
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
