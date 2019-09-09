class Bullet {

  PVector position;
  int bulletSize = 7;
  float velocity = 2;

  Bullet(PVector pos) {
    position = pos;
    position.setMag(30);
  }

  void display() {  
    noStroke();
    fill(255);
    ellipse(position.x, position.y, bulletSize, bulletSize);
  }

  void update() {
    float mag = position.mag();
    position.setMag(mag + velocity);
  }
  
  boolean gone() {
   if (position.mag() >= 707) {
     return true;
   } else {
     return false;
   }
  }
}
