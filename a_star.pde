float chanceForWall = .2;
Grid grid;

void setup() {
  size(600,600);
  frameRate(60);
  grid = new Grid(30,30);
  grid.show();
}

void draw() {
  if (grid == null) {
    delay(3000);
    grid = new Grid(30,30);
  }
  if (grid.update() || grid.openSet.size() == 0 || grid.closedSet.size() >= (grid.cols * grid.rows) / 4 || grid.end.generateNeighbors(grid.cells, false).size() == 0) {
    grid.show();
    grid = null;
    return;
  }
  grid.show();
}

void mousePressed() {
  grid.update();
  grid.show();
}

boolean have(ArrayList<Cell> list, Cell object) {
  for (Cell c : list) if (c == object) return true;
  return false;
}
