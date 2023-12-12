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
  
  void render(UserInterface ui, int x, int y, int cellSize) {
    if (!open) return;
  }
}
