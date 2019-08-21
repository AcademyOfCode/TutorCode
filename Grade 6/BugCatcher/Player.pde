class Player {
  float x;
  float y;
  float v; //velocity
  float s; //size
  int invert; //inverts controls if negative

  public Player() {
    x = width/2;
    y = height - height/30;
    s = height/20;
    v = width/150;
    invert = 1;
  }

  public void run() {
    display();
    move();
    looop();
  }

  private void display() {
    stroke(0);
    fill(255);
    rectMode(CENTER);
    rect(x, y, s*3, s);
  }

  private void move() {
    if (keys.contains('a')) {
      x-=v*invert;
    }
    if (keys.contains('d')) {
      x+=v*invert;
    }
  }

  private void looop() {
    if (x-s*2>width) {
      x = -s*2;
    }
    if (x+s*2<0) {
      x = width + s*2;
    }
  }

  public void invertControls() {
    invert = -invert;
  }

  public float left() {
    return x-s*1.5;
  }
  public float right() {
    return x+s*1.5;
  }
  public float top() {
    return y-s/2;
  }
  public float bottom() {
    return y+s/2;
  }
  public boolean inverted() {
    if (invert==1) {
      return false;
    } else {
      return true;
    }
  }
}
