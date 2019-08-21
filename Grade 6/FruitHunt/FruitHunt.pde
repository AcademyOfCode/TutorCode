Player player;
Fruit fruit;
Enemy enemy;
int score, lives;

void setup() {
  size(2000, 1500);
  player = new Player(width/2, height/2, 0, 0, width/20);
  fruit = new Fruit(random(width), random(height), width/60);
  enemy = new Enemy(random(width), random(height), 3, width/30);
  score = 0;
  lives = 5;
}


void draw() {
  background(0);
  if (lives!=0) {
    runGame();
  } else {
    gameOver();
  }
}

void keyPressed() {
  if (key == 'w') {
    player.setSpeed(0, -5);
  }
  if (key == 'a') {
    player.setSpeed(-5, 0);
  }
  if (key == 's') {
    player.setSpeed(0, 5);
  }
  if (key == 'd') {
    player.setSpeed(5, 0);
  }
}

void runGame() {
  player.run();
  fruit.run();
  enemy.run();
  collisionDetection();
  fill(255);
  textSize(width/50);
  textAlign(LEFT, TOP);
  text("SCORE: "+score, 0, 0);
  textAlign(RIGHT, TOP);
  text("LIVES: "+lives, width, 0);
}

void gameOver() {
  textSize(width/10);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width/2, height/2-height/15);
  textSize(width/25);
  text("SCORE: "+score, width/2, height/2+height/15);
}

void collisionDetection() {
  if (dist(fruit.x, fruit.y, player.x, player.y)<player.s/2+fruit.s/2) {
    score++;
    enemy.v+=0.5;
    fruit.move();
  }
  if (dist(fruit.x, fruit.y, enemy.x, enemy.y)<enemy.s/2+fruit.s/2) {
    lives--;
    enemy.v-=0.5;
    fruit.move();
  }
}
