class Enemy {

  PVector position;
  int velocity = 1, bulletI = -1;
  float size = 50, red, green;

  Enemy() {
    position = PVector.random2D();
    position.setMag(707);
    red = random(200,255);
    green = random(100,220);
  }

  void update() {
    float mag = position.mag();
    position.setMag(mag - velocity);
  }

  void display() {
    noStroke();
    fill(red, green, 0);
    rectMode(CENTER);
    rect(position.x, position.y, size, size);
  }

  boolean checkKill() {
    if (dist(position.x, position.y, 0, 0) <= 50) {
    return true;
    } else {
      return false;
    }
  }

  boolean killed(float[] x, float[] y) {
    boolean k = false;
    for (int i = 0; i < x.length; i ++) {
      //float distX = (position.x + size/2 - x[i]) * (position.x - x[i]);
      //float distY = (position.y - y[i]) * (position.y - y[i]);
      if (x[i] < position.x + size/2 && x[i] > position.x - size/2 && y[i] < position.y + size/2 && y[i] > position.y - size/2) {
        k = true;
        bulletI = i;
      }
    }
    if (k) {
      return true;
    } else {
      return false;
    }
  }
}
