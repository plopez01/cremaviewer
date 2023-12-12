abstract class Unit {
  int id, player, health, turns;
  PVector pos;

  UnitPopup infoPopup;

  void init(int id, int player, int health, PVector pos) {
    this.id = id;
    this.player = player;
    this.health = health;
    this.pos = pos;

    infoPopup = new UnitPopup(200, 200, getPlayerColor(player));
  }

  void render(UserInterface ui, int scaledX, int scaledY, int cellSize) {
    if (ui.isPinned(id)) {
      infoPopup.setOpen(true);
    } else infoPopup.setOpen(false);
    
    if (squareRaycast(mouseX, mouseY, scaledX, scaledY, cellSize)) {
      infoPopup.setOpen(true);
      if (mouseClick(LEFT)) ui.setPinned(id, !ui.isPinned(id));
    }
    
    infoPopup.render(ui, scaledX, scaledY);
  }
}
