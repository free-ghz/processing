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
  
  public color getProcessingColor() {
    return color(r, g, b);
  }
  
  public int diff(Color other) {
    return Math.abs(getLumen() - other.getLumen());
  }
  
  private int getLumen() {
    return (int)(0.299*(double)r) + 
           (int)(0.587*(double)g) + 
           (int)(0.114*(double)b); 
  }
}
    
