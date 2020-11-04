size(300,300);

rectMode(CORNER);  // Domyślne rectMode to CORNER
fill(155);  // Białe wypełnienie
rect(25, 25, 50, 50);  // Rysuje białe rect w trybie CORNER

stroke(255);
point(25,25);//BIAŁY PUNKT
point(50,50);//BIAŁY PUNKT
stroke(0);

rectMode(CORNERS);  // Ustawiamy rectMode na CORNERS ('S' robi różnicę)
fill(50);  // Ciemno szare wypełnienie
rect(50, 50, 75, 75);  // Rysuje szary rect w trybie CORNERS

stroke(255);
point(50,50);//BIAŁY PUNKT
point(75,75);//BIAŁY PUNKT
stroke(0);

rectMode(RADIUS);  // Ustawiamy rectMode na RADIUS
fill(200);  // Jasno szare wypełnienie
rect(150, 150, 30, 30);  // Rysuje jasny rect w trybie RADIUS

stroke(255);
point(150,150);//BIAŁY PUNKT
stroke(0);

rectMode(CENTER);  // Ustawiamy rectMode na CENTER
fill(255);  // Białe wypełnienie
rect(250, 250, 30, 30);  // Rysuje biały rect w trybie CENTER

stroke(0);
point(250,250);//CZARNY PUNKT
