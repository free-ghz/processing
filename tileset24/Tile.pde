import java.util.List;

public class Tile {
  private final color[] colors;
  private final int side;
  private Tile(color[] colors, int side) {
    this.colors = colors;
    this.side = side;
  }
}
