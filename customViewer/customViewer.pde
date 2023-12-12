import java.io.*;
import java.util.*;

Game game;
boolean isPlaying = false;

void setup() {
  fullScreen(1);
  //size(1760, 940);
  println(sketchPath());  
  background(0);
  File gameFile;
  String argPath = System.getProperty("gameFile");
  if (argPath != null) {
    gameFile = new File(argPath);
  } else {
    gameFile = selectInput();
  }
  try {
    game = new Game(gameFile);
    game.loadGame();
    game.printSummary();
  } catch (IOException e) {
    println("The specified game file hasn't been found.");
    exit();
  }
}

void draw() {
  background(0);
  game.renderLayer(Layer.CAVE);
  //game.renderLayer(Layer.SURFACE);
  
  game.renderInfo();
  
  if (isPlaying){
    game.nextRound();
    if (game.atEnd()) isPlaying = false;
  }
}
