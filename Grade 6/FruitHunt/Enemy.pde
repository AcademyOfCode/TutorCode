class Enemy {
  float x, y, v, s;

  public Enemy(float x, float y, float v, float s) {
    this.x = x;
    this.y = y;
    this.v = v;
    this.s = s;
  }

  public void run() {
    drawThis();
    move();
  }

  void drawThis() {
    noStroke();
    fill(200, 0, 0);
    ellipse(x, y, s, s);
  }

  void move() {
    float h = dist(fruit.x, fruit.y, x, y);
    float dx = (x - fruit.x)/h;
    float dy = (y - fruit.y)/h;
    x-=dx*v;
    y-=dy*v;
  }
}
