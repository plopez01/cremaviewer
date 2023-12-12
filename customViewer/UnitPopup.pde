class UnitPopup extends Popup {
  Unit unit;
  
  UnitPopup(Unit unit, int w, int h, color c){
    super(w, h, c);
    this.unit = unit;
  }
  
  
  @Override
  void render(UserInterface ui, int x, int y, int cellSize){
    super.render(ui, x, y, cellSize);
    if (!open) return;
    
    ui.b.fill(darkenColor(c, 180), 160);
    ui.b.rect(x, y, w, h);
    
    ui.b.fill(darkenColor(c, 150), 200);
    ui.b.rect(x, y, w, h/6);
    
    int xOff = x + 10;
    int yOff = y + h/6;
    
    ui.b.textSize(20);
    ui.b.fill(255);
    textAlign(LEFT);
    ui.b.text(unit.getClass().getSimpleName(), xOff, yOff - ui.b.textAscent()/2 - 2);
    
    textAlign(RIGHT);
    ui.b.text("ID: " + unit.id, x + w - textWidth("ID: " + unit.id) - 6, yOff - ui.b.textAscent()/2 - 2);
    
    // Unit data
    ui.b.text(
      "Health: " + unit.health + 
      "\nPosition: (Y=" + int(unit.pos.x) + ", X=" + int(unit.pos.y) + ")", 
      xOff, yOff + 25);
    
    if (unit instanceof Hellhound) unit.render(x - 30, y, cellSize);
    else unit.render(x - 30, y, cellSize*3);
    
  }
}
