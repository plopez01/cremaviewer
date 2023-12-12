abstract class Popup {
  int w, h;
  boolean open = false;
  color c;
  
  Popup(int w, int h, color c){
    this.w = w;
    this.h = h;
    this.c = c;
  }
  
  void setOpen(boolean visible){
    open = visible; 
  }
  
  void render(UserInterface ui, int x, int y) {
    if (!open) return;
    ui.b.fill(darkenColor(c, 20));
    ui.b.rect(x, y, w, h);
  }
}
