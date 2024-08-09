import java.math.BigDecimal;

final int wideness = 350;
final int zoom = 2;
double maxIter = 10; // 150 till 250. börja iter 214
final float bound = 2.0;

double zoompointX = -0.749201101; // new BigDecimal("-0.7492011193060755").doubleValue();; //-0.749201101;
double zoompointY =  new BigDecimal("0.09999979981443996").doubleValue(); // 0.099999799;
double windowSize = 1.3; // 2.0981565752083828E-10; //1.3;
double windowTresh = 2.0981565752083828E-10;

void setup() {
  size(700, 700);
  colorMode(HSB, 256, 1, 1, 1);
  noSmooth();
}

int bigIt = 0;
void draw() {
  System.out.println(bigIt++ + ": " + windowSize + " @ " + zoompointX + " by " + zoompointY + " maxit " + maxIter);
  var minX = zoompointX - windowSize;
  var minY = zoompointY - windowSize;
  var maxX = zoompointX + windowSize;
  var maxY = zoompointY + windowSize;
  var brot = mandelbrot(minX, minY, maxX, maxY);
  drawMandelbrot(brot);
  if (bigIt >= 500) {
    maxIter = maxIter + 0.1;
  } else if (bigIt >= 250) {
    maxIter += 0.012;
  } else {
    maxIter += 0.068;
  }
  windowSize = windowSize * 0.99;
  // zoompointY = zoompointY - 0.00000000001;
  if (windowSize < windowTresh) System.out.println("trip! " + maxIter);
  saveFrame("frames/#####.png");
}

void drawMandelbrot(int[][] bounded) {
  noStroke();
  for (int i = 0; i < wideness; i++) {
    for (int j = 0; j < wideness; j++) {
      color paint = #000000;
      if (bounded[j][i] > 0) {
        paint = color(bounded[j][i], 1, 1);
      }
      fill(paint);
      rect(i * zoom, j * zoom, zoom, zoom);
    }
  }
}

int[][] mandelbrot(double minX, double minY, double maxX, double maxY) {
  int[][] result = new int[wideness][wideness];
  double xFrac = (maxX - minX)/((double)wideness);
  double yFrac = (maxY - minY)/((double)wideness);
  for (int i = 0; i < wideness; i++) {
    for (int j = 0; j < wideness; j++) {
      double x = minX + (j*xFrac);
      double y = minY + (i*yFrac);
      Point c = new Point(x, y);
      int iterations = bound(c, maxIter, bound);
      result[i][j] = iterations;
    }
  }
  return result;
  
}

int bound(Point c, double maxIterations, double bound) {
  Point looper = new Point(0, 0);
  for (int i = 0; i < maxIterations; i++) {
    looper = looper.mul(looper).add(c);
    if (looper.gt(new Point(bound, bound))) return i;
  }
  return 0;
}
class Point {
  private double r;
  private double i;
  public Point(double r, double i) {
    this.r = r;
    this.i = i;
  }
  
  public Point add(Point other) {
    double newr = this.r + other.r;
    double newi = this.i + other.i;
    return new Point(newr, newi);
  }
  public Point mul(Point other) {
    // (ac - bd) + i(ad + bc)
    double newr = (this.r * other.r) - (this.i * other.i);
    double newi = (this.r * other.i) + (this.i * other.r);
    return new Point(newr, newi);
  }
  public boolean gt(Point other) {
    return other.r < this.r && other.i < this.i;
  }
  
  public String toString() {
    return "(" + r + "+" + i + "i)";
  }
}
