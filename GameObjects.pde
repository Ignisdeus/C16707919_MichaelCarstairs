
// perent Class only background not using this as a perent 
class GameObject {

  PVector pos, tar, stem;
  float speed, size; 
  color  bird = color(255, 0, 0), trunk = color (200, 150, 200);

  GameObject(float x, float y) {

    pos = new PVector(x, y);
  }

  GameObject(float x, float y, float size) {

    pos = new PVector(x, y);
    this.size = size;
  }

  void update() {
  }

  void render() {
  }
}
// birds implmaented using GameObject as a perent 
boolean canLay = false;
class Birds extends GameObject {

  boolean right;


  Birds(float x, float y, float speed) {

    super(x, y);
    this.speed = speed; 
    size= 25;

    if ( random(0, 1) > 0.5f) {

      right = true;
    } else {

      right = false;
    }
    if ( random(0, 1) > 0.1f) {
      canLay =true;
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

    if (canLay) {
      if ( random(0, 1) > 0.25f) {
        canLay =false;
        assets.add(new Eggs(pos.x, pos.y, size/2));
      }
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
// trees implmented using the GameObjects class as a perent 
class Trees extends GameObject {

  float growth, growthRate = 5.0f, trunkSize = 0;
  int lefeCount = (int)random(3, 8);
  PVector[] lefePos = new PVector[lefeCount];
  color leafs;

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
      // println(tar);

      float pointGen = TWO_PI / lefePos.length, theta=0, cx, cy;
      for (int i =0; i < lefePos.length; i ++) {

        cx = tar.x + sin(theta)  * (size * 0.75f);
        cy = tar.y - cos(theta) * (size * 0.75f);

        lefePos[i] = new PVector(cx, cy);
        theta += pointGen;
      }
    }

    if ( random(0, 1) > 0.5f) {
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

      if ( random(0, 1f) < 0.01f) {
        assets.add(new FallingLeves(lefePos[i].x, lefePos[i].y, size * 0.2f, this.leafs));
      }
    }
  }
}

// added falling leves that react to a wind direction and gravity 

class FallingLeves extends GameObject {


  float termVol = 5.0f, windSpeed = 2f;
  color myColor;
  FallingLeves(float x, float y, float size, color c) {

    super(x, y, size); 
    speed =0;
    myColor = c;
    tar = new PVector(pos.x, pos.y + random(100, 150));
  }

  void update() {

    // due to light ait gravity whont have as high and effect :) 
    if ( speed < termVol) {
      speed += gavForce/ 4;
    }

    if ( pos.y < tar.y) {
      pos.y += speed;
      if ( windDir) {

        pos.x+= windSpeed;
      } else {
        pos.x-= windSpeed;
      }
    } else {

      size -= 0.1f;
    }

    if (size < 0 ) {
      assets.remove(this);
    }
  }


  void render() {
    fill(myColor);
    ellipse(pos.x, pos.y, size, size);
  }
}
// 10 % that a bird can lay an egg
class Eggs extends GameObject {

  float vertSpeed;

  Eggs(float x, float y, float size) {

    super(x, y, size); 
    tar = new PVector(pos.x, random(height/2, height - size * 3));
  }

  void update() {

    if ( pos.y < tar.y) {
      pos.y += vertSpeed;
      vertSpeed += gavForce;
    } else if ( random(0,1) < 0.1f) {
      bgAssets.add(new Chicks(pos.x, pos.y, size));
      assets.remove(this);
    }
  }

  void render() {
    fill(255);
    ellipse(pos.x, pos.y, size, size* 1.5f);
  }
}

class Chicks extends GameObject {

  boolean right;
  Chicks(float x, float y, float size) {

    super(x, y, size);
    speed = 0.2f;

    if ( random( 0, 1) > 0.5f) {
      right = true;
    } else {

      right = false;
    }
  }

  void update() {

    if ( right) {
      pos.x += speed;
    } else {
      pos.x -= speed;
    }

    if ( pos.x < 0 + size || pos.x > width -size) {
      right = ! right;
    }
  }

  void render() {
    fill(bird);
    ellipse(pos.x, pos.y, size, size);
  }
}