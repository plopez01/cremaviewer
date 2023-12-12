class Furyan extends Unit {
  @Override
  void render(UserInterface ui, int scaledX, int scaledY, int cellSize){
    super.render(ui, scaledX, scaledY, cellSize);
    
    color playerColor = getPlayerColor(player);
    
    fill(darkenColor(playerColor, 50));
    noStroke();

    pushMatrix();
    // Rotation
    translate(scaledX, scaledY);
    rotate(frameCount / 200.0);
    
    polygon(0, 0, cellSize/3, 3);
    popMatrix();
  
  }
}
