void skipLines(BufferedReader reader, int lines) throws IOException {
  for (int i = 0; i < lines; i++) {
    reader.readLine();
  }
}

int manhattanDist(PVector from, PVector to){
  return int(max(abs(to.y  - from.y), min(abs(to.x - from.x), min(abs(from.x + (MAP_WIDTH - to.x)), abs(to.x + (MAP_WIDTH - from.x))))));
}

boolean mouseClick(int button){
  if (mouseButton == button && !holdingMouse.getOrDefault(button, false)){
     holdingMouse.put(button, true);
     return true;
  }
  return false;
}

color constrainColor(int r, int g, int b){
  r = constrain(r, 0, 255);
  g = constrain(g, 0, 255);
  b = constrain(b, 0, 255);
  return color(r, g, b);
}

color lightenColor(color c, int amount) {
  return addColor(c, color(amount));
}

color darkenColor(color c, int amount) {
  return subColor(c, color(amount));
}

color addColor(color a, color b){
  int r1 = ((a >> 16) & 0xFF);
  int g1 = ((a >> 8) & 0xFF);
  int b1 = (a & 0xFF);
  
  int r2 = ((b >> 16) & 0xFF);
  int g2 = ((b >> 8) & 0xFF);
  int b2 = (b & 0xFF);
  
  return constrainColor(r1+r2, g1+g2, b1+b2);
}

color subColor(color a, color b){
  int r1 = ((a >> 16) & 0xFF);
  int g1 = ((a >> 8) & 0xFF);
  int b1 = (a & 0xFF);
  
  int r2 = ((b >> 16) & 0xFF);
  int g2 = ((b >> 8) & 0xFF);
  int b2 = (b & 0xFF);
  
  return constrainColor(r1-r2, g1-g2, b1-b2);
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
