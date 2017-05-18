class GameObject {

  PVector pos, tar, stem;
  float speed, size; 
  color leafs, bird = color(255, 0, 0), trunk = color (200, 150, 200);

  GameObject(float x, float y) {

    pos = new PVector(x, y);
  }

  void update() {
  }

  void render() {
  }
}

class Birds extends GameObject {

  boolean right;


  Birds(float x, float y, float speed) {

    super(x, y);
    this.speed = speed; 
    size= 25;

    int dice = (int)random(0, 2);

    if ( dice == 0) {
      right = true;
    } else {

      right = false;
    }
  }

  void update() {

    if (right) {
      pos.x += speed;
    } else {
      pos.x -= speed;
    }

    if ( pos.x < 0 - size/2 || pos.x > width + size/2) {
      birdCount --;
      assets.remove(this);
    }
  }

  void render() {

    fill(bird);
    if (right) {
      ellipse(pos.x, pos.y, size, size);
      ellipse(pos.x+ (size * 0.75f), pos.y, size/2, size/2);
    } else {
      ellipse(pos.x, pos.y, size, size);
      ellipse(pos.x-(size * 0.75f), pos.y, size/2, size/2);
    }
  }
}

class Trees extends GameObject {

  float growth, growthRate = 5.0f, trunkSize = 0;
  int lefeCount = (int)random(3, 8);
  PVector[] lefePos = new PVector[lefeCount];

  Trees(float x, float y, float growFactor) {

    super(x, y); 

    tar = pos;
    growth = growFactor;
    size = 50;
    leafs = color((int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
  }

  void update() {
    if (trunkSize < growth) {
      trunkSize += growthRate;
      tar = new PVector(pos.x, pos.y - trunkSize);
      println(tar);

      float pointGen = TWO_PI / lefePos.length, theta=0, cx, cy;
      for (int i =0; i < lefePos.length; i ++) {

        cx = tar.x + sin(theta)  * (size * 0.75f);
        cy = tar.y - cos(theta) * (size * 0.75f);

        lefePos[i] = new PVector(cx, cy);
        theta += pointGen;
      }
    }
  }

  void render() {
    stroke(trunk);
    strokeWeight(2);
    line(pos.x, pos.y, tar.x, tar.y );
    noStroke();
    fill(leafs);
    ellipse(tar.x, tar.y, size, size);

    for (int i =0; i< lefePos.length; i++) {
     
      ellipse(lefePos[i].x, lefePos[i].y, size/2, size/2);
    }
  }
}