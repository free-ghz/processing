public class Color {
  private final static int FLAG_RED =   0b00000000111111110000000000000000;
  private final static int FLAG_GREEN = 0b00000000000000001111111100000000;
  private final static int FLAG_BLUE =  0b00000000000000000000000011111111;
  private final int r;
  private final int g;
  private final int b;
  public Color(color in) {
    this.r = in & FLAG_RED;
    this.g = in & FLAG_GREEN;
    this.b = in & FLAG_BLUE;
  }
  public Color(int r, int g, int b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  private int clamp(int value) {
    return Math.min(255, Math.max(0, value));
  }
  
  public color getProcessingColor() {
    return color(
      clamp(r), // it's fun to allow OOB values but we should be safe when exporting
      clamp(g), 
      clamp(b)
    );
  }
  
  public int diff(Color other) {
    return Math.abs(getLumen() - other.getLumen());
  }
  
  private int getLumen() {
    return (int)(0.299*(double)r) + 
           (int)(0.587*(double)g) + 
           (int)(0.114*(double)b); 
  }
  
  public Color multiply(Color other) {
    double thisFloatR = ((double)r)/255.0;
    double thisFloatG = ((double)g)/255.0;
    double thisFloatB = ((double)b)/255.0;
    double otherFloatR = ((double)other.r)/255.0;
    double otherFloatG = ((double)other.g)/255.0;
    double otherFloatB = ((double)other.b)/255.0;
    var calcR = (int)((thisFloatR * otherFloatR) * 255);
    var calcG = (int)((thisFloatG * otherFloatG) * 255);
    var calcB = (int)((thisFloatB * otherFloatB) * 255);
    var result =  new Color(calcR, calcG, calcB);
    System.out.println("Multiplying " + this + " + " + other + " to create " + result);
    return result;
  }
  public Color add(Color other) {
    var rSum = r + other.r;
    var gSum = g + other.g;
    var bSum = b + other.b;
    var result = new Color(rSum, gSum, bSum);
    System.out.println("Adding " + this + " + " + other + " to create " + result);
    return result;
  }
  public String toString() {
    return "(" + r + ", " + g + ", " + b + ")";
  }
}
    
