int width = 11;



void setup() {
  int[][] integers = new int[width][width];
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < width; j++) {
      integers[i][j] = 0;
    }
  }
  
  int center = width/2;
  integers[width-1][width-1] = 1;
  integers[0][0] = -1;
  
  for (int i = 0; integers[width-1][1] == 0; i++) {
    integers = pass(integers);
    printSquare(integers);
    System.err.println("^^^ " + i);
  }
  
  int negaSum = 0;
  int posiSum = 0;
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < width; j++) {
      if (integers[i][j] > 0) {
        posiSum += integers[i][j];
      } else if (integers[i][j] < 0) {
        negaSum -= integers[i][j];
      }
    }
  }
  var doubles = new double[width][width];
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < width; j++) {
      var summo = posiSum;
      if (integers[i][j] < 0) summo = negaSum;
      doubles[i][j] = ((double)integers[i][j])/((double)summo);
    }
  }
  printFinal(doubles);
}

void printFinal(double[][] source) {
  System.out.println();
  System.out.print("new double[][]{");
  for (int a = 0; a < width; a++) {
    System.out.print("{");
    for (int i = 0; i < width; i++) {
      System.out.print(source[a][i]);
      if (i < width - 1) {
        System.out.print(",");
      }
    }
    System.out.print("}");
    if (a < width - 1) {
      System.out.print(",");
    }
  }
  System.out.print("}");
}

void printSquare(int[][] source) {
  System.out.println("=============");
  for (int[] row : source) {
    for (int i = 0; i < width; i++) {
      System.out.print(row[i] + "\t");
    }
    System.out.println();
  }
  System.out.println();
}

int[][] pass(int[][] source) {
  int[][] newIntegers = new int[width][width];
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < width; y++) {
      var sum = 0;
      for (int a = -1; a < 2; a++) {
        for (int b = -1; b < 2; b++) {
          int cx = x + a;
          int cy = y + b;
          if (cx < 0 || cx >= width) continue;
          if (cy < 0 || cy >= width) continue;
          sum += source[cx][cy];
        }
      }
      newIntegers[x][y] = sum;
    }
  }
  return newIntegers;
}
