void setup() {
  noLoop();
  noSmooth();
  noStroke();
  size(444, 444);
  colorMode(RGB, 256, 256, 256);
  fill(#888888);
  rect(0, 0, 1000, 1000);
}

void draw() {
  var fileName = "rail.png";
  var input = loadImage(fileName);
  var kernel = EMBOSS11;
  
  
  var surface = new Surface(input);
  
  var convolved = actOnSurface(kernel, surface, CLOSEST_OOB_STRATEGY, ADDITION_VALUE_COMBINER);
  
  var outputImage = createImage(convolved.width, convolved.height, ARGB);
  input = loadImage(fileName);
  for (var x = 0; x < convolved.getWidth(); x++) {
    for (var y = 0; y < convolved.getHeight(); y++) {
      var xyColor = convolved.getColor(x, y);
      var xyColorOriginal = input.get(x, y);
      var xyProcessingColor = xyColor.getProcessingColor();
      if (xyColorOriginal == #000000) {
        xyProcessingColor = color(0, 0, 0, 0);
      }
      outputImage.set(x, y, xyProcessingColor);
      stroke(xyProcessingColor);
      point(x, y);
    }
  }
  outputImage.save("output.png");
}

Surface actOnSurface(
    Agent agent,
    Surface surface,
    OutOfBoundsStrategy outOfBoundsStrategy,
    ValueCombiner resultCombiner
) {
  int surfaceLength = surface.getWidth() * surface.getHeight();
  var newColors = new Color[surfaceLength];
  for (int i = 0; i < surfaceLength; i++) {
    int x = i % surface.getWidth();
    int y = i / surface.getWidth();
    var agentResult = agent.process(x, y, surface, outOfBoundsStrategy);
    var combinedResult = resultCombiner.nowKiss(surface.getColor(x, y), agentResult);
    newColors[i] = combinedResult;
  }
  return new Surface(newColors, surface.getWidth(), surface.getHeight());
}
