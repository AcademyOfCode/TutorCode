class Player {
  float x, y, vx, vy, s;

  public Player(float x, float y, float vx, float vy, float s) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.s = s;
  }

  public void run() {
    drawThis();
    move();
  }

  private void drawThis() {
    noStroke();
    fill(255);
    ellipse(x, y, s, s);
  }
  
  public void setSpeed(float x, float y) {
    vx = x;
    vy = y;
  }

  private void move() {
    x+=vx;
    y+=vy;
    loopThis();
  }

  private void loopThis() {
    if (x-s/2>width) {
      x = 0-s/2;
    }
    if (x+s/2<0) {
      x = width+s/2;
    }
    if (y-s/2>height) {
      y = 0-s/2;
    }
    if (y+s/2<0) {
      y = height+s/2;
    }
  }
}
