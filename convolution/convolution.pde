void setup() {
  noLoop();
  noSmooth();
  noStroke();
  size(98, 98);
  colorMode(RGB, 256, 256, 256);
  fill(#888888);
  rect(0, 0, 1000, 1000);
}

void draw() {
  var input = loadImage("input3.png");
  
  Color full = new Color(1, 1, 1);
  Color redd = new Color(0.25, 0, 0);
  Color blue = new Color(0, 0.25, 0);
  Color spec = new Color(0.25, 0.25, 1);
  Color dark = new Color(0, 0, 0);
  var surface = new Surface(input);
  var kernel = new Kernel(
    new Color[]{
      redd, redd, dark,
      redd, spec, blue,
      dark, blue, blue
    },
    3,
    multiplicationCombiner
  );
  var convolved = surface.convolve(kernel, blackOobStrategy);
  
  for (var x = 0; x < convolved.getWidth(); x++) {
    for (var y = 0; y < convolved.getHeight(); y++) {
      var xyColor = convolved.getColor(x, y);
      var xyProcessingColor = xyColor.getProcessingColor();
      stroke(xyProcessingColor);
      point(x, y);
    }
  }
  save("output.png");
}
