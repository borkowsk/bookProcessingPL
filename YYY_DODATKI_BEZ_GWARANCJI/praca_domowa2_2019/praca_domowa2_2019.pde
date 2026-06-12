size(612,612);
background(255);
for(int i=0;i<512;i+=4)
{
  fill(0,i,255-i);
  rect(i,i,100,100);
}
