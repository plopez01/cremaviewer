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
    ui.b.text(unit.getClass().getSimpleName(), xOff, yOff - ui.b.textAscent()/2 - 2);
    unit.render(x - 30, y, cellSize*3);
  }
}
