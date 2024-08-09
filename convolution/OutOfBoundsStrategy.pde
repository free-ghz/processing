public class Point {
  public final int x;
  public final int y;
  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}
public interface OutOfBoundsStrategy {
  Color correct(Point point, Surface surface);
}

OutOfBoundsStrategy blackOobStrategy = (point, surface) -> {
  var black = new Color(#000000);
  if (point.x < 0) return black;
  if (point.y < 0) return black;
  if (point.x >= surface.getWidth()) return black;
  if (point.y >= surface.getHeight()) return black;
  return surface.getColor(point.x, point.y);
};
