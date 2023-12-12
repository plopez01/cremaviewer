boolean holdingSpace = false;
boolean holdingControl = false;

int INICIO = 36;
int FIN = 35;

void keyPressed(){
  if (keyCode == CONTROL) holdingControl = true;
  
  if (keyCode == INICIO) game.goToStart();
  if (keyCode == FIN) game.goToEnd();
  
  if (keyCode == LEFT) {
    if (holdingControl) game.goToStart();
    else game.previousRound();
  }
  
  if (keyCode == RIGHT) {
    if (holdingControl) game.goToEnd();
    else game.nextRound();
  }
  
  if (key == ' ' && !holdingSpace) {
    isPlaying = !isPlaying;
    holdingSpace = true;
  }
}

void keyReleased(){
  if (keyCode == CONTROL) holdingControl = false;
  
  if (key == ' ') holdingSpace = false;
}
