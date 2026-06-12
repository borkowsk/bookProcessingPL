int gridSize = 50;
int[][] grid;
float sameTypeThreshold = 0.5; // Agents want at least 50% of neighbors to be the same type
int empty = 0, typeA = 1, typeB = 2;

void setup() {
  size(500, 500);
  grid = new int[gridSize][gridSize];
  initializeGrid();
  //noLoop();
}

void draw() {
  background(255);
  drawGrid();
  for (int i = 0; i < 100; i++) { // Perform 1000 moves
    updateGrid();
  }
}

void initializeGrid() {
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      float r = random(1);
      if (r < 0.3) {
        grid[i][j] = typeA;
      } else if (r < 0.6) {
        grid[i][j] = typeB;
      } else {
        grid[i][j] = empty;
      }
    }
  }
}

void drawGrid() {
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      if (grid[i][j] == typeA) {
        fill(255, 0, 0); // Red for type A
      } else if (grid[i][j] == typeB) {
        fill(0, 0, 255); // Blue for type B
      } else {
        fill(255); // White for empty
      }
      rect(i * width/gridSize, j * height/gridSize, width/gridSize, height/gridSize);
    }
  }
}

void updateGrid() {
  int i = int(random(gridSize));
  int j = int(random(gridSize));
  if (grid[i][j] != empty && !isHappy(i, j)) {
    for (int di = -1; di <= 1; di++) {
      for (int dj = -1; dj <= 1; dj++) {
        int ni = (i + di + gridSize) % gridSize;
        int nj = (j + dj + gridSize) % gridSize;
        if (grid[ni][nj] == empty) {
          grid[ni][nj] = grid[i][j];
          grid[i][j] = empty;
          return;
        }
      }
    }
  }
}

boolean isHappy(int i, int j) {
  int sameType = 0;
  int differentType = 0;
  for (int di = -1; di <= 1; di++) {
    for (int dj = -1; dj <= 1; dj++) {
      if (di == 0 && dj == 0) continue; // Skip the agent itself
      int ni = (i + di + gridSize) % gridSize;
      int nj = (j + dj + gridSize) % gridSize;
      if (grid[ni][nj] == grid[i][j]) {
        sameType++;
      } else if (grid[ni][nj] != empty) {
        differentType++;
      }
    }
  }
  return sameType >= sameTypeThreshold * (sameType + differentType);
}
