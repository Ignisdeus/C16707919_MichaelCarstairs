//C16707919 
//Michael Carstairs

// the force of gravity
float gavForce= 0.98;
boolean canCall = true, canPlant = true;
ArrayList<GameObject> assets= new ArrayList<GameObject>();
ArrayList<GameObject> bgAssets= new ArrayList<GameObject>();
void setup() {

  size(960, 600);
  sky = color(0, 255, 255);
  ground = color(0, 255, 0);
}
color sky, ground;
int birdCount = 0, treeCount = 0; 
//back ground called every frame 
void backGround() {
  noStroke();
  fill(sky);
  rect(0, 0, width, height/2);
  fill(ground);
  rect(0, height/2, width, height/2);
}
Boolean windDir;
void draw() {
  backGround();

  if ( random(0, 1f) > 0.1f) {
    windDir =true;
  } else {
    windDir =false;
  }
  // for the chicks so they don't walk on top of trees
  for (int i = 0; i < bgAssets.size(); i ++) {
    GameObject c = bgAssets.get(i);
    c.update();
    c.render();
  }

  // draw form the array list 
  for (int i = 0; i < assets.size(); i ++) {
    GameObject c = assets.get(i);
    c.update();
    c.render();
  }
  if ( mouseY < height/2) {

    if (mousePressed && canCall == true && birdCount < 7) {
      canCall = false;
      birdCount ++;
      assets.add(new Birds(mouseX, mouseY, 5.0f));
    }
  }
  if ( mouseY > height/2) {
    if (mousePressed && canPlant == true && treeCount < 20) {
      canPlant = false;
      canCall = false;
      treeCount++;
      assets.add(new Trees(mouseX, mouseY, random(50, 100)));
    }
  }

  if (!mousePressed) {
    canCall = true;
    canPlant = true;
  }
}


  