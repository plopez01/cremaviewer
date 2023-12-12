class UnitPopup extends Popup {
  Unit unit;
  
  UnitPopup(Unit unit, int w, int h, color c){
    super(w, h, c);
    this.unit = unit;
  }
  
  
  @Override
  void render(UserInterface ui, int x, int y){
    super.render(ui, x, y);
    if (!open) return;
    
    ui.b.fill(darkenColor(c, 200), 160);
    ui.b.rect(x, y, w, h);
    
    int xOff = x + 20;
    int yOff = y + 20;
    
    ui.b.textSize(20);
    ui.b.fill(255);
    ui.b.text(unit.getClass().getSimpleName(), xOff, yOff + ui.b.textAscent()/2);
  }
}
