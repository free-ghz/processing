import java.util.Arrays;

public class Surface {
  private final Color[] values;
  private final int width;
  private final int height;
  private Surface(Color[] values, int width, int height) {
    this.values = values;
    this.width = width;
    this.height = height;
  }
  public Surface(PImage image) {
    image.loadPixels();
    var pixelLength = image.pixels.length;
    values = new Color[pixelLength];
    for (var i = 0; i < pixelLength; i++) {
      values[i] = new Color(image.pixels[i]);
    }
    width = image.width;
    height = image.height;
  }
  public int getWidth() {
    return this.width;
  }
  public int getHeight() {
    return this.height;
  }
  public Color getColor(int x, int y) {
    int where = x + (y * width);
    return values[where];
  }
}
