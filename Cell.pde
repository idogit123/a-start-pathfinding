class Cell {
  // g = dist from start, h = dist to end, f = sum of g and h.
  boolean isWall = false;
  float gCost = 0, hCost = 0, fCost = 0; 
  int x, y;
  Cell parent = null;
  
  Cell(int col, int row, boolean isWall) {
    x = col;
    y = row;
    this.isWall = isWall;
  }
  
  void show(color col, float w, float h) {
    stroke(0);
    strokeWeight(1);
    fill(col);
    rect(x * w, y * h, w - 1, h - 1); 
  }
  
  ArrayList<Cell> generateNeighbors(Cell[][] map, boolean diagnals) {
    ArrayList<Cell> neighbors = new ArrayList();
    boolean notOnStart = y>0, notOnEnd = y<map[0].length-1;
    if (x > 0) {
      if (diagnals && notOnStart) neighbors.add(map[x - 1][y - 1]);
      if (diagnals && notOnEnd) neighbors.add(map[x - 1][y + 1]);
      neighbors.add(map[x - 1][y    ]);
    } if (x < map.length-1) {
      if (diagnals && notOnStart) neighbors.add(map[x + 1][y - 1]);
      if (diagnals && notOnEnd) neighbors.add(map[x + 1][y + 1]);
      neighbors.add(map[x + 1][y    ]);
    }
    if (notOnStart) neighbors.add(map[x    ][y - 1]);
    if (notOnEnd) neighbors.add(map[x    ][y + 1]);    
    return neighbors;
  }
}

float getHCost(Cell c, Cell goal) {
  return dist(c.x, c.y, goal.x, goal.y);
}
