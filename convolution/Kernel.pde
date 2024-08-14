import java.util.List;

public class Kernel {
  private final Color[] values;
  private final int side;
  private ValueCombiner combiner;
  private ResultCombinator resultCombinator;
  private Kernel(Color[] values, int side, ValueCombiner combiner, ResultCombinator resultCombinator) {
    this.values = values;
    this.side = side;
    this.combiner = combiner;
    this.resultCombinator = resultCombinator;
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
  public Color combine(Color originalColor, Color kernelResult) {
    return resultCombinator.combine(originalColor, kernelResult);
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


interface ResultCombinator {
  Color combine(Color original, Color kernelResult);
}
ResultCombinator replace = (original, kernelResult) -> kernelResult;
ResultCombinator add = (original, kernelResult) -> kernelResult.add(original);


public Kernel kernelFromArray(double[][] values, ValueCombiner combiner, ResultCombinator resultCombinator) {
  var side = values.length;
  var arrayLength = side * side;
  var colors = new Color[arrayLength];
  for (int y = 0; y < side; y++) {
    for (int x = 0; x < side; x++) {
      int i = (y * side) + x;
      var val = values[y][x];
      var vColor = new Color(val, val, val);
      colors[i] = vColor;
    }
  }
  return new Kernel(colors, side, combiner, resultCombinator);
}
