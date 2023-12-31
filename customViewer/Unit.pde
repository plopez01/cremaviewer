abstract class Unit {
  int id, player, health, turns;
  PVector pos;

  UnitPopup infoPopup;

  void init(int id, int player, int health, PVector pos) {
    this.id = id;
    this.player = player;
    this.health = health;
    this.pos = pos;

    infoPopup = new UnitPopup(this, 200, 200, getPlayerColor(player));
  }

  void renderUI(UserInterface ui, int scaledX, int scaledY, int cellSize){
    if (ui.isPinned(id)) {
      infoPopup.setOpen(true);
    } else infoPopup.setOpen(false);
    
    // TODO: set to zero as we aren't checking overlapings
    int margin = 0;
    if (squareRaycast(mouseX, mouseY, scaledX, scaledY, cellSize+margin)) {
      infoPopup.setOpen(true);
      if (mouseClick(LEFT)) ui.setPinned(id, !ui.isPinned(id));
    }
    
    infoPopup.render(ui, scaledX, scaledY, cellSize);
  }

  void render(int scaledX, int scaledY, int cellSize) {
    
    
  }
}
