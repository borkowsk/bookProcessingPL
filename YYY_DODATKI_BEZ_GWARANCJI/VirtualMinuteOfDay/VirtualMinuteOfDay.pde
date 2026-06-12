import java.util.Date;

String defDataPath="/data/wb/SCC/public/bookProcessingPL/21_many_other_things/VirtualMinuteOfDay/vdate";

/// @brief   Funkcja odliczająca co-minutowe markery czasu w oparciu o plik. 
/// @details Każde wywołanie podaje kolejną minutę wirtualnej doby.
/// @param datafile - Konieczna jest pełna ścieżka do pliku, bo przy samej nazwie pliku zapis jest do katalogu projektu, 
///                   a odczyt z katalogu "data/" projektu.
///                   Taka właściwość funkcji `loadStrings()` i `saveStrings()` Processing-u.
long nextVirtualMinuteOfDay(String datafile)
{
  println("VDay:\t",datafile);
  if(dataFile(datafile).isFile()) // Jeśli był już taki plik...
  {
    String[] lines = loadStrings(datafile);
    
    if(lines.length>0) { // ... i miał pierwszą linie.
        long vnowm=Long.parseLong(lines[0],10);  println("Was:\t",vnowm);
        Date vnow=new Date(vnowm); //Virtually now.
        int minutes=vnow.getMinutes();
        if(minutes==59)
        {
          minutes=0;
          vnow.setMinutes(minutes);
          int hours=vnow.getHours();
          
          if(hours==23) //Nie da się więcej upchnąć markerów minutowych w tej dobie.
          {
            println("Wirtualna doba",vnow.toLocaleString(),"została wyczerpana!\n");
            println("Jeśli to był dzień wcześniejszy od realnego to skasuj plik:");
            println(datafile);
            exit();
          }
          
          hours++;
          vnow.setHours(hours);
        }
        else
        {
          minutes++;
          vnow.setMinutes(minutes);
        }
        
        vnowm=vnow.toInstant().toEpochMilli();
        lines[0]=vnowm+""; println("New:\t",lines[0]);
        saveStrings(datafile, lines);
        
        return vnowm;
    }
       
  }

  println("New file",datafile,"will be created!");  

  // BLOK AWARYJNY - NOWY PLIK:
  long nowm=System.currentTimeMillis();
  Date now=new Date(nowm);
  now.setHours(0);
  now.setMinutes(1);
  now.setSeconds(0);
  nowm=now.toInstant().toEpochMilli();
  String nows=nowm+" ";  println(nows);
  String[] nowlist=split(nows,' ');
  saveStrings(datafile, nowlist);
  return nowm;
}

void setup()
{
  long lvd=nextVirtualMinuteOfDay(defDataPath+".txt");

  Date now=new Date(lvd);

  println("As milli:   ",lvd,'\n',
          "default:   ", now.toString(),'\n',
          "local:     ", now.toLocaleString(),'\n',
          "as instant:", now.toInstant(),'\n',
          "GMT:       ", now.toGMTString(),'\n'
           );
}
