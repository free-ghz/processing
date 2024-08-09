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
  public Surface convolve(Kernel kernel, OutOfBoundsStrategy oobStrat) {
    var kernelSide = kernel.getSide();
    var kernelOffset = (kernelSide/2);
    var newValues = new Color[values.length];
    for (var i = 0; i < values.length; i++) {
      var surfacePivotX = i%width;
      var surfacePivotY = i/width;
      Color collector = new Color(0, 0, 0);
      for (var kY = 0; kY < kernelSide; kY++) {
        for (var kX = 0; kX < kernelSide; kX++) {
          var surfaceSampleX = surfacePivotX + kX - kernelOffset;
          var surfaceSampleY = surfacePivotY + kY - kernelOffset;
          var sampledColor = oobStrat.correct(
            new Point(surfaceSampleX, surfaceSampleY), 
            this
           );
          var processedColor = kernel.process(kX, kY, sampledColor);
          collector = collector.add(processedColor);
        }
        newValues[i] = collector;
      }
    }
    return new Surface(newValues, width, height);
  }
}
