float brushSize = 100;
float red, green, blue;
int shape=0;
boolean colourSelect = false;
boolean sizeSelect = false;
boolean shapeSelect = false;
boolean preview = true;
boolean eraser = false;
PImage background;
String[] works;
int pieceNumber;

void setup() {
  size(3000, 1500);
  background(255);
  save("background.png");
  background = loadImage("background.png");
  works = loadStrings("Works.txt");
  pieceNumber = int(works[0]);
}

void draw() {
  noStroke();
  if (mousePressed && mouseX>450) {
    preview = false;
    paint();
  } else {
    image(background, 0, 0);
  }
  if (preview) {
    preview();
  }
  toolBox();
  if (colourSelect) {
    colourSelect();
  } else if (sizeSelect) {
    sizeSelect();
  } else if (shapeSelect) {
    shapeSelect();
  } else {
    fill(255);
    noStroke();
    rectMode(CORNER);
    rect(200, 0, 200, height);
  }
  strokeWeight(1);
  stroke(0);
  line(200, 0, 200, height);
  line(400, 0, 400, height);
}

void mouseReleased() {
  if (mouseX>450) {
    save("background.png");
    background = loadImage("background.png");
    preview = true;
  }

  if (dist(mouseX, mouseY, 100, 675)<50) {
    sizeSelect=false;
    shapeSelect=false;
    colourSelect=false;
    eraser = !eraser;
  }
}

void mouseWheel(MouseEvent event) {
  if (event.getCount()<0) {
    if (brushSize>=10) {
      brushSize-=event.getCount()*10;
    } else if (brushSize>1) {
      brushSize-=event.getCount();
    }
  }
  if (event.getCount()>0) {
    if (brushSize>10) {
      brushSize-=event.getCount()*10;
    } else if (brushSize>1) {
      brushSize-=event.getCount();
    }
  }
}

void keyReleased() {
  if (key == ' ') {
    preview = false;
    pieceNumber++;
    String n = str(pieceNumber);
    String[] works = split(n, ' ');
    saveStrings("Works.txt", works);
    String name = "Masterpiece"+n+".png";
    image(background, 0, 0);
    save(name);
    preview = true;
  }
}

void paint() {
  if (mouseButton == LEFT) {
    fill(red, green, blue);
    if (eraser) {
      fill(255);
    }
    noStroke();
    if (shape == 0) {
      ellipse(mouseX, mouseY, brushSize, brushSize);
    } else if (shape == 1) {
      rectMode(CENTER);
      rect(mouseX, mouseY, brushSize, brushSize);
    } else if (shape == 2) {
      triangle(mouseX-brushSize/2, mouseY+brushSize/2, mouseX, mouseY-brushSize/2, mouseX+brushSize/2, mouseY+brushSize/2);
    } else {
      shape = 0;
    }
  }
}

void preview() {
  noStroke();
  fill(red, green, blue);
  if (eraser) {
    strokeWeight(1);
    stroke(0);
    fill(255);
  }
  if (shape == 0) {
    ellipse(mouseX, mouseY, brushSize, brushSize);
  } else if (shape == 1) {
    rectMode(CENTER);
    rect(mouseX, mouseY, brushSize, brushSize);
  } else if (shape == 2) {
    triangle(mouseX-brushSize/2, mouseY+brushSize/2, mouseX, mouseY-brushSize/2, mouseX+brushSize/2, mouseY+brushSize/2);
  } else {
    shape = 0;
  }
}

void toolBox() {
  rectMode(CORNER);
  noStroke();
  fill(150);
  rect(0, 0, 200, height);

  //colour select
  fill(red, green, blue);
  ellipse(100, 75, 100, 100);
  fill(0);
  textSize(20);
  textAlign(CENTER, TOP);
  text("COLOUR", 100, 150);
  if (dist(mouseX, mouseY, 100, 75)<50 && mousePressed) {
    sizeSelect=false;
    shapeSelect=false;
    eraser=false;
    colourSelect=true;
  }

  //brush size select
  fill(255);
  ellipse(100, 275, 100, 100);
  fill(0);
  ellipse(100, 275, 75, 75);
  textSize(20);
  fill(255);
  textAlign(CENTER, CENTER);
  text(int(brushSize), 100, 275);
  fill(0);
  textAlign(CENTER, TOP);
  text("BRUSH SIZE", 100, 350);
  if (dist(mouseX, mouseY, 100, 275)<50 && mousePressed) {
    colourSelect=false;
    shapeSelect=false;
    sizeSelect=true;
  }

  //brush shape select
  fill(255);
  ellipse(100, 475, 100, 100);
  fill(0);
  if (shape == 0) {
    ellipse(100, 475, 50, 50);
  } else if (shape == 1) {
    rectMode(CENTER);
    rect(100, 475, 50, 50);
  } else if (shape == 2) {
    triangle(75, 500, 100, 450, 125, 500);
  } else {
    ellipse(100, 475, 50, 50);
  }
  fill(0);
  textSize(20);
  textAlign(CENTER, TOP);
  text("BRUSH SHAPE", 100, 550);
  if (dist(mouseX, mouseY, 100, 475)<50 && mousePressed) {
    colourSelect=false;
    sizeSelect=false;
    shapeSelect=true;
  }

  //eraser
  noStroke();
  if (eraser) {
    strokeWeight(3);
    stroke(255, 0, 0);
  }
  fill(255);
  ellipse(100, 675, 100, 100);
  strokeWeight(1);
  stroke(0);
  ellipse(100, 675, 50, 50);
  fill(0);
  textSize(20);
  textAlign(CENTER, TOP);
  text("ERASER", 100, 750);

  //clear canvas
  fill(255);
  ellipse(100, 875, 100, 100);
  fill(0);
  textSize(20);
  textAlign(CENTER, TOP);
  text("CLEAR CANVAS", 100, 950);
  if (dist(mouseX, mouseY, 100, 875)<50 && mousePressed) {
    sizeSelect=false;
    shapeSelect=false;
    colourSelect=false;
    background(255);
    save("background.png");
    background = loadImage("background.png");
    preview = true;
  }
}

void shapeSelect() {
  rectMode(CORNER);
  noStroke();
  fill(200);
  rect(200, 0, 200, height);

  //circle
  fill(255);
  ellipse(300, 75, 100, 100);
  fill(0);
  ellipse(300, 75, 50, 50);
  if (dist(mouseX, mouseY, 300, 75)<50 && mousePressed) {
    shape = 0;
    shapeSelect = false;
  }

  //square
  fill(255);
  ellipse(300, 225, 100, 100);
  fill(0);
  rectMode(CENTER);
  rect(300, 225, 50, 50);
  if (dist(mouseX, mouseY, 300, 225)<50 && mousePressed) {
    shape = 1;
    shapeSelect = false;
  }

  //triangle
  fill(255);
  ellipse(300, 375, 100, 100);
  fill(0);
  triangle(275, 400, 300, 350, 325, 400);
  if (dist(mouseX, mouseY, 300, 375)<50 && mousePressed) {
    shape = 2;
    shapeSelect = false;
  }
}

void sizeSelect() {
  rectMode(CORNER);
  noStroke();
  fill(200);
  rect(200, 0, 200, height);

  fill(255);
  ellipse(300, 75, 100, 100);
  fill(0);
  ellipse(300, 75, 5, 5);
  if (dist(mouseX, mouseY, 300, 75)<50 && mousePressed) {
    brushSize = 5;
    sizeSelect = false;
  }

  fill(255);
  ellipse(300, 225, 100, 100);
  fill(0);
  ellipse(300, 225, 10, 10);
  if (dist(mouseX, mouseY, 300, 225)<50 && mousePressed) {
    brushSize = 10;
    sizeSelect = false;
  }

  fill(255);
  ellipse(300, 375, 100, 100);
  fill(0);
  ellipse(300, 375, 25, 25);
  if (dist(mouseX, mouseY, 300, 225)<50 && mousePressed) {
    brushSize = 25;
    sizeSelect = false;
  }

  fill(255);
  ellipse(300, 525, 100, 100);
  fill(0);
  ellipse(300, 525, 50, 50);
  if (dist(mouseX, mouseY, 300, 525)<50 && mousePressed) {
    brushSize = 50;
    sizeSelect = false;
  }

  fill(255);
  ellipse(300, 675, 100, 100);
  fill(0);
  ellipse(300, 675, 95, 95);
  textSize(20);
  fill(255);
  textAlign(CENTER, CENTER);
  text("100", 300, 675);
  if (dist(mouseX, mouseY, 300, 675)<50 && mousePressed) {
    brushSize = 100;
    sizeSelect = false;
  }

  fill(255);
  ellipse(300, 825, 100, 100);
  fill(0);
  ellipse(300, 825, 95, 95);
  textSize(20);
  fill(255);
  textAlign(CENTER, CENTER);
  text("200", 300, 825);
  if (dist(mouseX, mouseY, 300, 825)<50 && mousePressed) {
    brushSize = 200;
    sizeSelect = false;
  }

  fill(255);
  ellipse(300, 975, 100, 100);
  fill(0);
  ellipse(300, 975, 95, 95);
  textSize(20);
  fill(255);
  textAlign(CENTER, CENTER);
  text("300", 300, 975);
  if (dist(mouseX, mouseY, 300, 975)<50 && mousePressed) {
    brushSize = 300;
    sizeSelect = false;
  }

  fill(255);
  ellipse(300, 1125, 100, 100);
  fill(0);
  ellipse(300, 1125, 95, 95);
  textSize(20);
  fill(255);
  textAlign(CENTER, CENTER);
  text("400", 300, 1125);
  if (dist(mouseX, mouseY, 300, 1125)<50 && mousePressed) {
    brushSize = 400;
    sizeSelect = false;
  }

  fill(255);
  ellipse(300, 1275, 100, 100);
  fill(0);
  ellipse(300, 1275, 95, 95);
  textSize(20);
  fill(255);
  textAlign(CENTER, CENTER);
  text("500", 300, 1275);
  if (dist(mouseX, mouseY, 300, 1275)<50 && mousePressed) {
    brushSize = 500;
    sizeSelect = false;
  }

  fill(255);
  ellipse(300, 1425, 100, 100);
  fill(0);
  ellipse(300, 1425, 95, 95);
  textSize(20);
  fill(255);
  textAlign(CENTER, CENTER);
  text("1000", 300, 1425);
  if (dist(mouseX, mouseY, 300, 1425)<50 && mousePressed) {
    brushSize = 1000;
    sizeSelect = false;
  }
}

void colourSelect() {
  rectMode(CORNER);
  noStroke();
  fill(200);
  rect(200, 0, 200, height);

  fill(255);
  ellipse(300, 75, 100, 100);
  if (dist(mouseX, mouseY, 300, 75)<50 && mousePressed) {
    red = 255;
    green = 255;
    blue = 255;
    colourSelect = false;
  }

  fill(0);
  ellipse(300, 225, 100, 100);
  if (dist(mouseX, mouseY, 300, 225)<50 && mousePressed) {
    red = 0;
    green = 0;
    blue = 0;
    colourSelect = false;
  }

  fill(255, 0, 0);
  ellipse(300, 375, 100, 100);
  if (dist(mouseX, mouseY, 300, 375)<50 && mousePressed) {
    red = 255;
    green = 0;
    blue = 0;
    colourSelect = false;
  }

  fill(255, 150, 0);
  ellipse(300, 525, 100, 100);
  if (dist(mouseX, mouseY, 300, 525)<50 && mousePressed) {
    red = 255;
    green = 150;
    blue = 0;
    colourSelect = false;
  }

  fill(255, 255, 0);
  ellipse(300, 675, 100, 100);
  if (dist(mouseX, mouseY, 300, 675)<50 && mousePressed) {
    red = 255;
    green = 255;
    blue = 0;
    colourSelect = false;
  }

  fill(0, 255, 0);
  ellipse(300, 825, 100, 100);
  if (dist(mouseX, mouseY, 300, 825)<50 && mousePressed) {
    red = 0;
    green = 255;
    blue = 0;
    colourSelect = false;
  }

  fill(0, 255, 255);
  ellipse(300, 975, 100, 100);
  if (dist(mouseX, mouseY, 300, 975)<50 && mousePressed) {
    red = 0;
    green = 255;
    blue = 255;
    colourSelect = false;
  }

  fill(0, 0, 255);
  ellipse(300, 1125, 100, 100);
  if (dist(mouseX, mouseY, 300, 1125)<50 && mousePressed) {
    red = 0;
    green = 0;
    blue = 255;
    colourSelect = false;
  }

  fill(150, 0, 255);
  ellipse(300, 1275, 100, 100);
  if (dist(mouseX, mouseY, 300, 1275)<50 && mousePressed) {
    red = 150;
    green = 0;
    blue = 255;
    colourSelect = false;
  }

  fill(255, 0, 255);
  ellipse(300, 1425, 100, 100);
  if (dist(mouseX, mouseY, 300, 1425)<50 && mousePressed) {
    red = 255;
    green = 0;
    blue = 255;
    colourSelect = false;
  }
}
