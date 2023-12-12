class Necromonger extends Unit {
  int turns;
  
  Necromonger(int turns){
    this.turns = turns;
  }
  
  @Override
  void render(UserInterface ui, int scaledX, int scaledY, int cellSize){
    super.render(ui, scaledX, scaledY, cellSize);
    fill(80);
    noStroke();
    circle(scaledX, scaledY, cellSize/2);
  }
}
