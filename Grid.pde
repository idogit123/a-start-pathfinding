class Grid {
  int cols, rows;
  float cellW, cellH;
  
  Cell[][] cells;
  Cell start, end;
  ArrayList<Cell> openSet = new ArrayList(), closedSet = new ArrayList(), pathSet = new ArrayList();
  
  Grid(int cols, int rows) {
    this.cols = cols;
    this.rows = rows;
    cellW = width / cols;
    cellH = height / rows;
    
    cells = new Cell[cols][rows];
    for (int i=0; i<cols; i++) {
      for (int j=0; j<cols; j++) {
        cells[i][j] = new Cell(i,j, random(1) < chanceForWall);
      }
    }
    start = cells[0][0];
    end = cells[cols-1][rows-1];
    start.isWall = false;
    end.isWall = false;
    openSet.add(start);
  }
  
  boolean update() {
    if (openSet.size() > 0) {
      // find the current best cell
      int bestIndex = 0;
      for (int i=0; i<openSet.size(); i++) if (openSet.get(i).fCost < openSet.get(bestIndex).fCost) bestIndex = i;
      Cell current = openSet.get(bestIndex);
      // move current from openSet to closedSet
      openSet.remove(current);
      closedSet.add(current);
      // check if found a path
      if (current == end) {
        Cell path = current;
        while (path != null) {
           pathSet.add(path);
           path = path.parent;
        }
        println("succes!");
        return true;
      }
      // get the current's neighbors
      ArrayList<Cell> neighbors = current.generateNeighbors(cells, false);
      // for each neighbor: n
      for (Cell n : neighbors) {
        if (have(closedSet, n) || n.isWall) continue;
        float tempGCost = current.gCost + 1;
        if (tempGCost < n.gCost || n.parent == null) {
          // calculate f cost of n
          float hCost = getHCost(n, end);
          float fCost = tempGCost + hCost;
          n.fCost = fCost;
          n.hCost = hCost;
          // if n is not in open add it to open
          if (n.parent == null) openSet.add(n);
          // set n parent to current
          n.parent = current;
        }
      }
    }
    return false;
  }
  
  void show() {
    for (int i=0; i<cols; i++) {
      for (Cell c : cells[i]) {
        color col = color(255);
        if (have(openSet, c)) col = color(0, 255, 0);
        if (have(closedSet, c)) col = color(255, 0, 0);
        if (have(pathSet, c)) col = color(0, 0, 255);
        if (c == end) col = color(255, 255, 0);
        if (c.isWall) col = color(0);
        c.show(col, cellW, cellH);
      }
    } 
  }
}
