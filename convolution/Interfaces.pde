interface Agent {
  Color process(int surfaceX, int surfaceY, Surface surface, OutOfBoundsStrategy outOfBoundsStrategy);
}


public interface ValueCombiner {
  Color nowKiss(Color surfaceColor, Color kernelColor);
}
ValueCombiner ignoreBlack(ValueCombiner parent) {
  return (a, b) -> {
    if (a.getLumen() == 0) return a;
    return parent.nowKiss(a, b);
  };
}
final ValueCombiner MULTIPLICATION_VALUE_COMBINER = (a, b) -> {
  return a.multiply(b);
};
final ValueCombiner ADDITION_VALUE_COMBINER = (a, b) -> {
  return a.add(b);
};
final ValueCombiner REPLACE_VALUE_COMBINER = (original, kernelResult) -> kernelResult;


public interface OutOfBoundsStrategy {
  Color correct(int x, int y, Surface surface);
}
final OutOfBoundsStrategy BLACK_OOB_STRATEGY = (x, y, surface) -> {
  var black = new Color(#000000);
  if (x < 0) return black;
  if (y < 0) return black;
  if (x >= surface.getWidth()) return black;
  if (y >= surface.getHeight()) return black;
  return surface.getColor(x, y);
};
final OutOfBoundsStrategy CLOSEST_OOB_STRATEGY = (x, y, surface) -> {
  var x2 = Math.max(0, Math.min(surface.getWidth() - 1, x));
  var y2 = Math.max(0, Math.min(surface.getHeight() - 1, y));
  return surface.getColor(x2, y2);
};
final OutOfBoundsStrategy WRAP_OOB_STRATEGY = (x, y, surface) -> {
  while (x < 0) {
    x += surface.getWidth();
  }
  while (y < 0) {
    y += surface.getHeight();
  }
  return surface.getColor(x % surface.getWidth(), y%surface.getHeight());
};
