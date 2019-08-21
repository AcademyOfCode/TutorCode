class Fruit {
  float x, y, s;

  public Fruit(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.s = s;
  }

  public void run() {
    noStroke();
    fill(0, 200, 0);
    ellipse(x, y, s, s);
  }

  public void move() {
    x = random(width);
    y = random(height);
  }
}
