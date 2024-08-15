interface Agent {
  Color process(int surfaceX, int surfaceY, Surface surface, OutOfBoundsStrategy outOfBoundsStrategy);
}
final Agent INVERT_AGENT = (x, y, surface, oob) -> {
  var sample = surface.getColor(x, y);
  var invertedSample = COLOR_WHITE.subtract(sample);
  return invertedSample;
};


public interface ValueCombiner {
  Color nowKiss(Color surfaceColor, Color kernelColor);
}
ValueCombiner ignoreColor(ValueCombiner parent, Color ignoree) {
  return (a, b) -> {
    if (a.equals(ignoree)) return a;
    return parent.nowKiss(a, b);
  };
}
final ValueCombiner MULTIPLICATION_VALUE_COMBINER = (a, b) -> {
  return a.multiply(b);
};
final ValueCombiner ADDITION_VALUE_COMBINER = (a, b) -> {
  return a.add(b);
};
final ValueCombiner SUBTRACTION_VALUE_COMBINER = (a, b) -> {
  return a.subtract(b);
};
final ValueCombiner REPLACE_VALUE_COMBINER = (original, kernelResult) -> kernelResult;


public interface OutOfBoundsStrategy {
  Color correct(int x, int y, Surface surface);
}
final OutOfBoundsStrategy BLACK_OOB_STRATEGY = (x, y, surface) -> {
  if (x < 0) return COLOR_BLACK;
  if (y < 0) return COLOR_BLACK;
  if (x >= surface.getWidth()) return COLOR_BLACK;
  if (y >= surface.getHeight()) return COLOR_BLACK;
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
