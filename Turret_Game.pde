//https://youtu.be/kjFlIxGzABY?t=82
// interesting video

int shootSpeed = 25, bulletSize = 7; //shootSpeed in frames per bullet
int enemySpawnRate = 100; //one will spawn every number of frames
int score = 0;
float ax, bx, cx, ay, by, cy;
boolean loseGame = false;
PVector mousePosition;
float[] bulletPosX = {}, bulletPosY = {};
ArrayList<Bullet> bullets;
ArrayList<Enemy> enemies;

void setup() {
  background(0);
  size(1000, 1000);
  bullets = new ArrayList<Bullet>();
  enemies = new ArrayList<Enemy>();
  ax = 0;
  ay = - 30;
  bx = - 15;
  by =  15;
  cx = 15;
  cy = 15;
}

void draw() {
  background(0);
  if (loseGame) {
    loseGame();
  } else {
    translate(width/2, height/2);
    spawn();
    printEssentials();
    enemyUpdate();
    bulletUpdate();
    turretRotate();
  }
}

void turretRotate() {
  mousePosition = new PVector(mouseX - width/2, mouseY - height/2);
  float theta = mousePosition.heading();
  rotate(theta + HALF_PI);
  fill(255);
  noStroke();
  triangle(ax, ay, bx, by, cx, cy);
}

void bullet(int i) {
  int n = 0;
  float[] newbulletPosX = new float[bulletPosX.length - 1], newbulletPosY = new float[bulletPosY.length - 1];
  bulletPosX[i] = 0;
  bulletPosY[i] = 0;
  for (int j = 0; j < bulletPosX.length; j++) {
    if (abs(bulletPosX[j]) > 0) {
      newbulletPosX[j - n] = bulletPosX[j];
      newbulletPosY[j - n] = bulletPosY[j];
    } else {
      n += 1;
    }
  }
  arrayCopy(newbulletPosX, bulletPosX);
  arrayCopy(newbulletPosY, bulletPosY);
}

void spawn() {
  if (frameCount%shootSpeed == 0) {
    bullets.add(new Bullet(mousePosition));
    bulletPosX = append(bulletPosX, 0);
    bulletPosY = append(bulletPosY, 0);
  }
  if (frameCount%enemySpawnRate == 0) {
    enemies.add(new Enemy());
    if (enemySpawnRate != shootSpeed) {
      enemySpawnRate -= 0.5;
    }
  }
}

void loseGame() {
  background(0);
  fill(255);
  textSize(140);
  textAlign(CENTER);
  text("You", width/2, height/2 - 70);
  text("Lose", width/2, height/2 + 50);
  textSize(70);
  text("Score:", width/2 - 25, height/2 + 170);
  text(score, width/2 + 115, height/2 + 170);
  noLoop();
}

void enemyUpdate() {
  for (int i = enemies.size() - 1; i >= 0; i--) {
    Enemy enemy1 = enemies.get(i);
    enemy1.update();
    if (enemy1.checkKill()) {
      loseGame = true;
      break;
    }
    if (enemy1.killed(bulletPosX, bulletPosY)) {
      bullets.remove(enemy1.bulletI);
      bullet(enemy1.bulletI);
      enemies.remove(i);
      score += 1;
    }
    enemy1.display();
  }
}

void bulletUpdate() {
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet bullet1 = bullets.get(i);
    if (bullet1.gone()) {
      bullets.remove(i);
      break;
    }
    bullet1.update();
    bullet1.display();
    bulletPosX[i] = bullet1.position.x;
    bulletPosY[i] = bullet1.position.y;
  }
}

void printEssentials() {
 textSize(40);
    fill(200);
    text(score, width/2 - 50, -height/2 + 50);
    noFill();
    stroke(200,0,0);
    strokeWeight(5);
    ellipse(0,0,55,55);
}
