void skipLines(BufferedReader reader, int lines) throws IOException {
  for (int i = 0; i < lines; i++) {
    reader.readLine();
  }
}

boolean mouseClick(int button){
  if (mouseButton == button && !holdingMouse.getOrDefault(button, false)){
     holdingMouse.put(button, true);
     return true;
  }
  return false;
}

color darkenColor(color c, int amount) {
  int r = ((c >> 16) & 0xFF) - amount;
  int g = ((c >> 8) & 0xFF) - amount;
  int b = (c & 0xFF) - amount;
  
  if (r < 0) r = 0;
  if (g < 0) g = 0;
  if (b < 0) b = 0;
  
  return color(r, g, b);
}

// https://processing.org/examples/regularpolygon.html
void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

boolean squareRaycast(int testX, int testY, int x, int y, int size){
  return (testX > x-size/2 && testX < x+size/2) && (testY > y-size/2 && testY < y+size/2);
}
