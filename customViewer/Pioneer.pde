class Pioneer extends Unit {
  @Override
  void render(int scaledX, int scaledY, int cellSize){
    super.render(scaledX, scaledY, cellSize);
    
    color playerColor = getPlayerColor(player);
    fill(darkenColor(playerColor, 80));
    noStroke();
    circle(scaledX, scaledY, cellSize/2);
  }
}
