class Automata2D implements Agent {
  private int[] rule;
  private int width;
  private int cellStates;
  
  public Automata2D(long ruleNumber, int cellStates, int width) {
    this.rule = createRulesetFromNumber(ruleNumber, cellStates, width);
    this.width = width;
    this.cellStates = cellStates;
  }
  
  Color process(int surfaceX, int surfaceY, Surface surface, OutOfBoundsStrategy outOfBoundsStrategy) {
    int offset = width/2;
    int x = surfaceX-1;
    Color[] inputColors = new Color[width];
    var spotColor = outOfBoundsStrategy.correct(surfaceX, surfaceY, surface);
    if (spotColor.equals(COLOR_BLACK)) {
      return new Color(spotColor);
    }
    
    for (var i = 0; i < width; i++) {
      int y = surfaceY - offset + i;
      var sampledColor = outOfBoundsStrategy.correct(x, y, surface);
      inputColors[i] = sampledColor;
    }
    return automate(inputColors);
  }
  
  private int getCellState(double value) {
    value = Math.min(1.0, Math.max(0.0, value));
    return (int) Math.floor(value * (cellStates - 0.01)); // tee hee!
  }
  
  private Color automate(Color[] input) {
    int[][] inputStates = new int[width][3];
    for (int i = 0; i < width; i++) {
      inputStates[i][0] = getCellState(input[i].r);
      inputStates[i][1] = getCellState(input[i].g);
      inputStates[i][2] = getCellState(input[i].b);
    }
    double[] outputChannels = new double[3];
    for (int channel = 0; channel < 3; channel++) {
      int state = 0;
      for (int w = 0; w < width; w++) {
        var multiplyer = (int)Math.pow(cellStates, w);
        state += inputStates[w][channel] * multiplyer;
      }
      double outputForChannel = rule[state];
      outputChannels[channel] = outputForChannel;
    }
    return new Color(
      outputChannels[0],
      outputChannels[1],
      outputChannels[2]
    );
  }
}

int[] createRulesetFromNumber(long ruleNumber, int cellStates, int width) {
  // -, 2, 3 ->                 256
  // -, 2, 5 ->          4294967296
  // -, 3, 3 ->       7625597484987
  // -, 3, 5 -> 9223372036854775807 <- not the actual answer i think this is just MAX_LONG or something
  int possibleInputs = (int) Math.round(Math.pow(cellStates, width));
  System.out.println(cellStates + " cell states and width " + width + " gives " + possibleInputs + " possible inputs.");
  long maxRules = Math.round(Math.pow(cellStates, possibleInputs));
  System.out.println("That makes for " + maxRules + " rules. You've chosen rule " + ruleNumber + ".");
  
  var r = ruleNumber;
  var lookupTable = new int[possibleInputs];
  for (int i = 0; i < possibleInputs; i++, r = r / cellStates) {
    int stateForI = (int)(r % cellStates);
    lookupTable[i] = stateForI;
  }
  System.out.println("Done calculating rule.");
  
  return lookupTable;
}

final Automata2D A23RULE113 = new Automata2D(113, 2, 3);
/* Interesting (2,3) rules for black content on white:
  4, 6, 8, 12, 16, 18, 22, 24, 26, 28, 32, 34, 40, 52, 56, 62 (triangles!)
  64, 66, 68, 70, 72 (triangles!), 76, 82, 86, 94, 96, 98, 102, 104, 112, 118
*/
