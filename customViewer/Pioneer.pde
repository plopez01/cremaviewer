class Pioneer extends Unit {
  @Override
  void render(UserInterface ui, int scaledX, int scaledY, int cellSize){
    super.render(ui, scaledX, scaledY, cellSize);
    
    color playerColor = getPlayerColor(player);
    fill(darkenColor(playerColor, 80));
    noStroke();
    circle(scaledX, scaledY, cellSize/2);
  }
}
