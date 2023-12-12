class Hellhound extends Unit {
  @Override
  void render(UserInterface ui, int scaledX, int scaledY, int cellSize) {
    super.render(ui, scaledX, scaledY, cellSize);
    
    stroke(200, 0, 0);
    strokeWeight(1);

    fill(255, 0, 0, 100);
    circle(scaledX, scaledY, cellSize*3);

    noStroke();

    fill(200, 0, 0);
    circle(scaledX, scaledY, cellSize/2);
  }
}
