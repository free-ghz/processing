void setup() {
  size(1000, 1000);
  colorMode(RGB, 256, 256, 256);
  noSmooth();
  noStroke();
  fill(#000000);
  rect(0, 0, 100, 100);
}

void draw() {
  System.err.println("Load tileset");
  var tileset = loadImage("tileset.png");
  var tileSide = 14; // in pixels
  var tilesWide = tileset.width / tileSide;
  var tilesHigh = tileset.height / tileSide;
  var tiles = new ArrayList<PImage>();
  for (int outerTileRow = 0; outerTileRow < tilesHigh; outerTileRow++) {
    for (int outerTileCol = 0; outerTileCol < tilesWide; outerTileCol++) {
      var tile = tileset.get(
          outerTileCol * tileSide,
          outerTileRow * tileSide, 
          tileSide,
          tileSide
      );
      tiles.add(tile);
    }
  }
  
  System.err.println("Finding best tile for input");
  var input = loadImage("tileset2.png");
  var inputWide = input.width / tileSide;
  var inputHigh = input.height / tileSide;
  for (var y = 0; y < inputHigh; y++) {
    for (var x = 0; x < inputWide; x++) {
      var inputTile = input.get(
          x * tileSide,
          y * tileSide,
          tileSide,
          tileSide
      );
      var tileToDraw = findBestTile(inputTile, tiles);
      image(tileToDraw, 1 + (x * tileSide), 1 + (y * tileSide));
    }
  }
  
  
  
  
  noLoop();
  save("output.png");
  System.out.println("finito");
}

private PImage findBestTile(PImage subject, List<PImage> tiles) {
  PImage best = tiles.get(0);
  var score = similarity(subject, best);
  for (int i = 1; i < tiles.size(); i++) {
    var suspect = tiles.get(i);
    var suspectScore = similarity(subject, suspect);
    if (suspectScore < score) {
      score = suspectScore;
      best = suspect;
    }
  }
  return best;
}

int similaritySquare = 14;
private int similarity(PImage a, PImage b) {
  var aCopy = a.copy();
  var bCopy = b.copy();
  aCopy.resize(similaritySquare, similaritySquare);
  bCopy.resize(similaritySquare, similaritySquare);
  var diff = 0;
  var pixels = similaritySquare * similaritySquare;
  for (int i = 0; i < pixels; i++) {
    var aColor = new Color(aCopy.pixels[i]);
    var bColor = new Color(bCopy.pixels[i]);
    diff += aColor.diff(bColor);
  }
  return diff;
}
