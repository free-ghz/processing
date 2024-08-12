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
  var input = loadImage("furry.gif");
  Color brig = new Color(0.29, 0.29, 0.29);
  Color bri2 = new Color(0.14, 0.14, 0.14);
  Color mids = new Color(0, 0, 0);
  Color loom = new Color(-0.12, -0.12, -0.12);
  Color shad = new Color(-0.06, -0.06, -0.06);
  Color dark = new Color(-0.18, -0.18, -0.18);
  var kernel = new Kernel(
    new Color[]{
      dark, shad, loom, loom, mids,
      dark, shad, loom, mids, mids,
      shad, loom, mids, mids, bri2,
      loom, mids, mids, bri2, brig,
      mids, mids, mids, bri2, brig
    },
    5,
    multiplicationCombiner
  );
  
  
  var surface = new Surface(input);
  var convolved = surface.convolve(kernel, wrapOobStrategy);
  /*for (int i = 0; i < 21 ; i++) {
    convolved = convolved.convolve(kernel, wrapOobStrategy);
  }*/
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
