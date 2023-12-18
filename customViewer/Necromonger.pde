class Necromonger extends Unit {
  int turns;
  
  Necromonger(int turns){
    this.turns = turns;
  }
  
  @Override
  void render(int scaledX, int scaledY, int cellSize){
    super.render(scaledX, scaledY, cellSize);
    if (pos.z > 0) fill(80+50);
    else fill(80);
    noStroke();
    circle(scaledX, scaledY, cellSize/2);
  }
}
