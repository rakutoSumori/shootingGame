Game game;

void setup() {
  size(500, 500);
  colorMode(HSB, 360, 100, 100);
  background(180, 100, 100);
  noStroke();
  game = new Game();
}

void draw() {
  background(180, 100, 100);
  game.draw();
}

class Game {
  float vx;
  float vy;
  final int obstacleNum = 1000;
  Player player;
  Exit exit;
  Obstacle[] obstacle;

  Game() {
    vx = 3;
    vy = 0;
    player = new Player();
    exit = new Exit(vx, vy);
    obstacle = new Obstacle[obstacleNum];
    for (int i = 0; i < 5; i++) {
      obstacle[i] = new Obstacle();
    }
  }

  void draw() {
    player.move();
    player.show();
    for (int i = 0; i < 5; i++) {
      obstacle[i].generate();
      obstacle[i].move();
      obstacle[i].show();
    }

    exit.move();
    exit.show();
  }

  int getObstacleNum() {
    return obstacleNum;
  }
  Obstacle[] getObstacle() {
    return obstacle;
  }
}

class Player {
  float x;
  float y;
  float d;
  float wholeX;
  float wholeY;

  Player() {
    d = 30;
    x = d / 2;
    y = mouseY;
    wholeX = d / 2;
    wholeY = height - mouseY;
  }

  void move() {
    y = mouseY;
    if (y < d / 2) {  // ウインドウからはみ出さないようにする
      y = d / 2;
    } else if (y > height - d / 2) {
      y = height - d / 2;
    }
    wholeY = height - mouseY;
  }

  void show() {
    ellipse(x, y, d, d);
  }
}

class Obstacle {
  float x;
  float y;
  float d;
  //float w;
  float vx;
  float vy;
  int gObstacleNum;    // 生成された障害物の数
  float coefficient;  // 障害物を生成するときに使う係数
  boolean isGenerate;  // trueは生成済み

  Obstacle() {
    d = random(5, 50);
    x = width + 50;
    y = random(0 + d / 2, height);
    vx = random(1, 8);
    vy = 0;
    gObstacleNum = 5;
    coefficient = 1;
    isGenerate = false;
  }

  void move() {
    x = x - vx;
    y = y + vy;
  }

  void show() {
    fill(0, 100, 100);
    ellipse(x, y, d, d);
  }

  void generate() {
    for (int i = 0; i < 5 * coefficient; i++) {
      if (game.getObstacle()[i].getX() < width / 2) {  // 障害物がwidth / 2までいったらindexが5個後の障害物を生成
        if (i + 5 < game.getObstacleNum() && game.getObstacle()[i + 5].getIsGenerate()) {  // indexがオーバーしていないかつ
          game.getObstacle()[i + 5] = new Obstacle();
          gObstacleNum += 1;
          println(gObstacleNum);
          if (gObstacleNum % 5 == 0) {
            coefficient += 1;
          }
        }
      }
    }
  }

  float getX() {
    return x;
  }
  void setIsGenerate(boolean isGenerate) {
    this.isGenerate= isGenerate;
  }
  boolean getIsGenerate() {
    return isGenerate;
  }
}

class Background {
  float blockX;
  float blockY;
  final float blockWidth = 30;
  float vx;
  float vy;

  Background() {
    blockX = 0;
    blockY = height - blockWidth * 3;
  }
}

class Gimmick {
}

class ChangeOfDirection {
}

class Exit {
  float x;
  float y;
  float vx;
  float vy;
  final float w = 50;
  final float h = 100;

  Exit(float vx, float vy) {
    x = 1000;
    y = height / 2;
    this.vx = vx;
    this.vy = vy;
  }

  void move() {
    x = x - vx;
    y = y - vy;
  }

  void show() {
    fill(60, 100, 100);
    rect(x, y, w, h);
  }
}
