//Load from internet
String[] lines = loadStrings("https://processing.org/reference/");

println("there are " + lines.length + " lines");

for (int i = 0 ; i < lines.length; i++) {
  println(lines[i]);
}
