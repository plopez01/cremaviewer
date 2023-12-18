color[] playerColors = {
  color(245, 154, 35),
  color(35, 245, 57),
  color(35, 124, 245),
  color(195, 35, 245)
};

color getPlayerColor(int playerId) {
  if (playerId < 0) return color(50);
  return playerColors[playerId];
}

Map<Integer, Integer> colorMap = Map.of(
  (int) 'R', color(152, 75, 72), // Rock
  (int) 'C', color(255), // Uncaptured cave
  (int) 'E', color(111, 72, 40), // Elevator
  (int) 'O', color(10, 30, 30), // Surface color(215, 250, 250)
  (int) 'G', color(250, 227, 13), // Gem
  (int) '0', playerColors[0], // Player 0 captured cave
  (int) '1', playerColors[1], // Player 1 captured cave
  (int) '2', playerColors[2], // Player 2 captured cave
  (int) '3', playerColors[3]       // Player 3 captured cave
  );

int VIEWER_MARGIN_HOR = 50;
int VIEWER_MARGIN_VER = 50;

class Renderer {

  int CELL_SIZE = (width - VIEWER_MARGIN_HOR) / MAP_WIDTH;

  UserInterface ui;

  // Round, y, x
  int[][][] map;

  Unit[][] units;

  Renderer(UserInterface ui, int[][][] map, Unit[][] units) {
    this.map = map;
    this.units = units;
    this.ui = ui;
  }

  void render(int turn) {
    // Draw map
    for (int x = 0; x < MAP_HEIGHT; x++) {
      // Vertical number indexs
      fill(255);
      textAlign(RIGHT);
      textSize(CELL_SIZE*0.9);
      text(x, VIEWER_MARGIN_VER-10, x*CELL_SIZE + VIEWER_MARGIN_VER + CELL_SIZE*0.85);
      for (int y = 0; y < MAP_WIDTH; y++) {

        // Horizontal number indexs
        if (x == 0) {
          fill(255);
          textSize(CELL_SIZE*0.9);
          textAlign(CENTER);
          text(y, y*CELL_SIZE + VIEWER_MARGIN_HOR + CELL_SIZE*0.5, VIEWER_MARGIN_HOR-10);
        }

        int data = map[turn][y][x];
        color cellColor = colorMap.getOrDefault(data, color(255, 0, 255));

        fill(cellColor);
        strokeWeight(0.2);
        if (data == 'O') stroke(255);
        else stroke(0);

        int xPos = y*CELL_SIZE + VIEWER_MARGIN_HOR;
        int yPos = x*CELL_SIZE + VIEWER_MARGIN_VER;

        int xPosCenter = round(xPos + CELL_SIZE/2.0);
        int yPosCenter = round(yPos + CELL_SIZE/2.0);

        square(xPos, yPos, CELL_SIZE);

        // Surface tiles
        if (data == 'O') {
          int sunStart = (MAP_WIDTH/2 + turn*2) % MAP_WIDTH;
          int sunEnd = (sunStart + MAP_WIDTH/2) % MAP_WIDTH;
          int sunMiddle = (sunStart + MAP_WIDTH/4) % MAP_WIDTH;
          int middleDist = manhattanDist(new PVector(y, 0), new PVector(sunMiddle, 0));

          //color sunColor = darkenColor(color(255, 220, 15), middleDist * 10);
          color sunColor = color(255, 255, 255, 255);

          if (sunEnd < sunStart) {
            if (y >= sunStart || y < sunEnd) {
              stroke(darkenColor(sunColor, 200));
              fill(sunColor, 255-255*pow(sin(radians(middleDist*3.8)), 3));
              square(xPos, yPos, CELL_SIZE);
            }
          } else {
            if (y >= sunStart && y < sunEnd) {
              stroke(darkenColor(sunColor, 200));
              fill(sunColor, 255-255*pow(sin(radians(middleDist*3.8)), 3));
              square(xPos, yPos, CELL_SIZE);
            }
          }
        }

        if (data == 'E') {
          fill(255, 248, 33);
          noStroke();

          // Elevator arrow
          float animationAmplitude = CELL_SIZE*0.1;
          int yOff = round(animationAmplitude * sin(radians(6*frameCount)) - animationAmplitude/2);

          triangle(xPosCenter-CELL_SIZE/4, yPosCenter+yOff, xPosCenter, yPosCenter-CELL_SIZE/3+yOff, xPosCenter+CELL_SIZE/4, yPosCenter+yOff);
          rect(xPosCenter-(CELL_SIZE/5)/2, yPosCenter+yOff, CELL_SIZE/5, CELL_SIZE/4);
        }
      }
    }

    // Draw units
    for (Unit unit : units[turn]) {
      if (unit == null) continue;
      int scaledX = round(unit.pos.y*CELL_SIZE + VIEWER_MARGIN_HOR + CELL_SIZE/2.0);
      int scaledY = round(unit.pos.x*CELL_SIZE + VIEWER_MARGIN_VER + CELL_SIZE/2.0);

      unit.render(scaledX, scaledY, CELL_SIZE);
      unit.renderUI(ui, scaledX, scaledY, CELL_SIZE);
    }
  }
}
