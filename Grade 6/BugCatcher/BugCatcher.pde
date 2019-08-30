ArrayList<Character> keys = new ArrayList<Character>(); //<>//
ArrayList<Bug> bugs = new ArrayList<Bug>();
int score;
int timer;
int lives;
int interval;
Player player;

void setup() {
  size(2000, 1800);
  player = new Player();
  bugs.add(new Bug());
  score = 0;
  timer = 0;
  lives = 10;
  interval = (int)random(30, 120);
  frameRate(60);
}

void draw() {
  if (lives>0) {
    timer++;
    drawBackground();
    player.run();
    collision();
    addBugs();
    drawUI();
  } else {
    gameOver();
  }
}

void keyTyped() {
  if (!keys.contains(key)) {
    keys.add(key);
  }
}

void keyReleased() {
  if (keys.contains(key)) {
    keys.remove(new Character(key));
  }
}

void drawBackground() {
  noStroke();
  background(#B2F7FF);
  fill(#90E589);
  rectMode(CORNER);
  rect(0, height-height/25, width, height/25);
}

void drawUI() {
  fill(0);
  textSize(height/36);
  textAlign(LEFT, TOP);
  text("LIVES: "+lives, 5, 5);
  textAlign(RIGHT, TOP);
  text("SCORE: "+score, width-5, 5);
}

void collision() {
  for (int i=0; i<bugs.size(); i++) {
    bugs.get(i).run();
  }
  for (int i=bugs.size()-1; i>=0; i--) {
    if (bugs.get(i).collide()) {
      score += bugs.get(i).getWorth();
      lives += bugs.get(i).getImpact();
      if (bugs.get(i).getType() == 6) {
        player.invertControls();
      }
      bugs.get(i).moveOffScreen();
    }
    if (bugs.get(i).offScreen()) {
      bugs.remove(i);
    }
  }
}

void addBugs() {
  if (timer%interval==0) {
    bugs.add(new Bug());
    interval = (int)random(10, 90);
  }
}

void gameOver() {
  background(0);
  textAlign(CENTER, CENTER);
  fill(255, 0, 0);
  textSize(height/9);
  text("GAME OVER", width/2, height/2-height/18);
  fill(255);
  textSize(height/18);
  text("SCORE: "+score, width/2, height/2+height/18);
}
