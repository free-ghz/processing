import java.util.Random;

void setup() {
  size(400, 400);
  colorMode(RGB, 256, 256, 256);
  noSmooth();
  stroke(#ffffff);
  fill(#000000);
  rect(0, 0, 400, 400);
}

void draw() {
  var anchorX = new int[]{126, 313, 28};
  var anchorY = new int[]{185, 196, 365};
  var random = new Random();
  
  var x = anchorX[0];
  var y = anchorY[0];
  for(int i = 0; i < 10000; i++) {
    var p = random.nextInt(3);
    var nextX = (x + anchorX[p])/2;
    var nextY = (y + anchorY[p])/2;
    point(nextX, nextY);
    x = nextX;
    y = nextY;
  }
  
  noLoop();
  save("output.png");
}
