//* Random names generation
//*////////////////////////////////////////////////
int RSEED=113;

char[] vowels={'a','e','i','o','u','y'};
char[] consonants={'b','c','d','f','g','h','k','l','m','n','p','r','s','t','v','x','z'};

String name(int len)
{
  String s="";
  boolean vowel=random(1.0)<0.33;
  for(int i=0;i<len;i++)
  {
    if(vowel)
      s+=vowels[(int)random(vowels.length)];
    else
      s+=consonants[(int)random(consonants.length)];
      
    if(i==0)
      s=s.toUpperCase();
      
    vowel=vowel?(random(1.0)>0.90):(random(1.0)<0.75);
  }
  
  return s;
}

void setup()
{
  size(200,200);
  textSize(32);
  frameRate(10);
  textAlign(CENTER,CENTER);
  fill(0);
  randomSeed(RSEED);
}

String currname="";

void draw()
{
  if(frameCount % 10 == 0 )
  {
    currname=name( (int)(4+random(5)) );
    background(255);
    text(currname,width/2,height/2);
    //print("\n"+currname);
  }
}

void mouseClicked()
{
  print("\n"+currname);
}
