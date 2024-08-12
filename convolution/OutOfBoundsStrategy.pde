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

OutOfBoundsStrategy closestOobStrategy = (point, surface) -> {
  var x = Math.max(0, Math.min(surface.getWidth() - 1, point.x));
  var y = Math.max(0, Math.min(surface.getHeight() - 1, point.y));
  return surface.getColor(x, y);
};

OutOfBoundsStrategy wrapOobStrategy = (point, surface) -> {
  var x = point.x;
  while (x < 0) {
    x += surface.getWidth();
  }
  var y = point.y;
  while (y < 0) {
    y += surface.getHeight();
  }
  return surface.getColor(x % surface.getWidth(), y%surface.getHeight() );
};
