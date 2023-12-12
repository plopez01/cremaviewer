class UserInterface {
  PGraphics b;
  boolean[] unitUIPinned = new boolean[TOTAL_UNITS];
  
  UserInterface(PGraphics b){
    this.b = b;
  }
  
  void setPinned(int unitId, boolean pin){
    unitUIPinned[unitId] = pin;
  }
  
  boolean isPinned(int unitId){
     return unitUIPinned[unitId];
  }
}
