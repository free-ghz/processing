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
  var fileName = "rotor.png";
  var input = loadImage(fileName);
  var surface = new Surface(input);
  input = loadImage(fileName);
  
  // for (long aa = 0; aa < 7625597484987L; aa+=17174769111L) {
  var mess = surface;
  var agent = new Automata2D(72, 2, 3);
  for (int i = 0; i < 30; i++) {
    mess = actOnSurface(agent, mess, CLOSEST_OOB_STRATEGY, SUBTRACTION_VALUE_COMBINER);
    
    var mess2 = actOnSurface(INVERT_AGENT, mess, CLOSEST_OOB_STRATEGY, REPLACE_VALUE_COMBINER);
    mess2 = actOnSurface(EMBOSS7, mess2, CLOSEST_OOB_STRATEGY, ignoreColor(ADDITION_VALUE_COMBINER, COLOR_BLACK));
    mess2 = actOnSurface(CHROMATIC_ABBERATION_5, mess2, CLOSEST_OOB_STRATEGY, REPLACE_VALUE_COMBINER);
    mess2 = actOnSurface(INVERT_AGENT, mess2, CLOSEST_OOB_STRATEGY, REPLACE_VALUE_COMBINER);
    mess = mess2;
  
  var outputImage = createImage(mess.width, mess.height, ARGB);
  for (var x = 0; x < mess.getWidth(); x++) {
    for (var y = 0; y < mess.getHeight(); y++) {
      var xyColor = mess2.getColor(x, y);
      var xyColorOriginal = mess.getColor(x, y);
      var xyProcessingColor = xyColor.getProcessingColor();
      /*if (xyColorOriginal.equals(COLOR_WHITE)) {
        xyProcessingColor = #ffffff;
      }*/
      outputImage.set(x, y, xyProcessingColor);
      stroke(xyProcessingColor);
      point(x, y);
    }
  }
  var frameDigit = "00000000" + (i + 9);
  frameDigit = frameDigit.substring(frameDigit.length() - 4);
  outputImage.save("zazz/" + frameDigit +".png");
  }
  System.err.println("done"); 
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
