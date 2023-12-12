Map<Integer, Boolean> holdingMouse = new HashMap<>();

void mousePressed() {
  
}

void mouseReleased() {
  // Reset mouse event
  holdingMouse.put(mouseButton, false);
}
