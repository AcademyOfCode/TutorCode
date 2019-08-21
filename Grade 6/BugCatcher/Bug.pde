class Bug {
  float x; 
  float y;
  float v; //velocity
  float s; //size
  int worth; //how much it changes the score by
  int impact; //how much it changes the lives by
  int type; 

  public Bug() {
    x = random(width);
    y = random(-height/10, -height/6);
    s = height/10;
    worth = 0;
    impact = 0;
    float typeDecider = random(100);
    if (typeDecider < 40) {
      type = 1; //yellow beetle
      worth = 5;
      v = height/140;
    } else if (typeDecider < 50) {
      type = 2; //blue beetle
      worth = 15;
      v = height/180;
    } else if (typeDecider < 55) {
      type = 3; //health pack
      impact = 1;
      v = height/180;
    } else if (typeDecider < 70) {
      type = 4; //fire ant
      worth = -25;
      impact = -1;
      v = height/100;
    } else if (typeDecider < 85) {
      type = 5; //army ant
      worth = -100;
      impact = -3;
      v = height/80;
      s = height/50;
    } else {
      type = 6; //bamboo grub
      v = height/80;
      s = height/50;
    }
  }

  public void run() {
    display();
    fall();
  }

  private void display() {
    switch(type) {
    case 1:
      fill(255, 255, 0);
      break;
    case 2:
      fill(0, 0, 255);
      break;
    case 3:
      fill(0, 255, 0);
      break;
    case 4:
      fill(255, 0, 0);
      break;
    case 5:
      fill(255, 0, 0);
      break;
    case 6:
      fill(0, 255, 255);
      break;
    default:
      fill(0);
      println("Something has gone terribly wrong");
    }
    if (player.inverted()) {
      fill(random(256), random(256), random(256));
    }
    ellipse(x, y, s, s);
  }

  private void fall() {
    y+=v;
  }

  public boolean collide() {
    if (x > player.left() &&
      x < player.right() &&
      y + s/2 > player.top() &&
      y - s/2 < player.bottom()) {
      return true;
    } else {
      return false;
    }
  }

  public boolean offScreen() {
    if (y-s>height) {
      return true;
    } else {
      return false;
    }
  }

  public int getWorth() {
    return worth;
  }

  public int getImpact() {
    return impact;
  }

  public int getType() {
    return type;
  }

  public void moveOffScreen() {
    y = height+height/10;
  }
}
