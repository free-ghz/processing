public class Color {
  private final static int FLAG_RED =   0b00000000111111110000000000000000;
  private final static int FLAG_GREEN = 0b00000000000000001111111100000000;
  private final static int FLAG_BLUE =  0b00000000000000000000000011111111;
  public final double r;
  public final double g;
  public final double b;
  public Color(color in) {
    this.r = ((in & FLAG_RED)>>16)/255.0;
    this.g = ((in & FLAG_GREEN)>>8)/255.0;
    this.b = (in & FLAG_BLUE)/255.0;
  }
  public Color(double r, double g, double b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  private double clamp(double value) {
    return Math.min(1.0, Math.max(0.0, value));
  }
  
  public color getProcessingColor() {
    return color(
      (int)(clamp(r)*255),
      (int)(clamp(g)*255), 
      (int)(clamp(b)*255)
    );
  }
  
  public double diff(Color other) {
    return Math.abs(getLumen() - other.getLumen());
  }
  
  private double getLumen() {
    return (0.299*r) +
           (0.587*g) +
           (0.114*b); 
  }
  
  public Color multiply(Color other) {
    var calcR = r * other.r;
    var calcG = g * other.g;
    var calcB = b * other.b;
    var result =  new Color(calcR, calcG, calcB);
    // System.out.println("Multiplying " + this + " + " + other + " to create " + result);
    return result;
  }
  public Color add(Color other) {
    var rSum = r + other.r;
    var gSum = g + other.g;
    var bSum = b + other.b;
    var result = new Color(rSum, gSum, bSum);
    // System.out.println("Adding " + this + " + " + other + " to create " + result);
    return result;
  }
  public String toString() {
    return "(" + r + ", " + g + ", " + b + ")";
  }
}
    
