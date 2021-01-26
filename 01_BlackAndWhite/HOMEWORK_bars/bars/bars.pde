//Przykład 4 słupków, ale bez FOR!!!
//DATA. Wartości mogą być dowolne
//"final" znaczy mniej więcej tyle co "constant"
final float d0=100,d1=180,d2=50,d3=25;

//Zmienne pomocnicze
float maxd=max(d0,d1,max(d2,d3));// max() może mieć 2 lub 3 parametry
float curr=0;

size(550,350);//rozmiar w zasadzie dowolny
println(maxd,"in",width,"x",height,"window");

//coordinate system
stroke(128);
line(0,0,0,height-1);//Pionowa linia
line(0,0,5,10);//Strzałka
textAlign(LEFT,TOP);text(maxd,0,0);//Wartość max w oknie

line(0,height-1,width,height-1);//Horizontalna
//line(width,height-1,width-10,height-5);//Strzałka

//Słupki
stroke(0);fill(255);
curr=d0/maxd*height;
rect(width/6,height-curr,width/6,curr-2);
curr=d1/maxd*height;
rect(width/6*2,height-curr,width/6,curr-2);
curr=d2/maxd*height;
rect(width/6*3,height-curr,width/6,curr-2);
curr=d3/maxd*height;
rect(width/6*4,height-curr,width/6,curr-2);
