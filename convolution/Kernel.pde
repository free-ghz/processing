import java.util.List;

public class Kernel {
  private final Color[] values;
  private final int side;
  private ValueCombiner combiner;
  private Kernel(Color[] values, int side, ValueCombiner combiner) {
    this.values = values;
    this.side = side;
    this.combiner = combiner;
  }
  public int getSide() {
    return side;
  }
  public Color getColor(int x, int y) {
    int where = x + (y * side);
    return values[where];
  }
  public Color process(int x, int y, Color surfaceColor) {
    var kernelColor = getColor(x, y);
    return combiner.nowKiss(surfaceColor, kernelColor);
  }
}

public interface ValueCombiner {
  Color nowKiss(Color surfaceColor, Color kernelColor);
}
ValueCombiner ignoreBlack(ValueCombiner combiner) {
  return (a, b) -> {
    if (a.getLumen() == 0) return a;
    return combiner.nowKiss(a, b);
  };
}
ValueCombiner multiplicationCombiner = (a, b) -> {
  return a.multiply(b);
};
ValueCombiner additionCombiner = (a, b) -> {
  return a.add(b);
};
