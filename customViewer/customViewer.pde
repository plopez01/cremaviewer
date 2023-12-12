import java.io.*;
import java.util.*;

Game game;
boolean isPlaying = false;

void loadGame(File f) {
  try {
    // Local first because this can run in a different thread and if we publish it too early it explodes
    Game g = new Game(f);
    g.loadGame();
    g.printSummary();
    game = g;
  } catch (IOException e) {
    println("The specified game file hasn't been found.");
    exit();
  }
}

void setup() {
  fullScreen(1);
  //size(1760, 940);
  println(sketchPath());  
  background(0);
  
  String argPath = System.getProperty("gameFile");
  if (argPath != null) {
    loadGame(new File(argPath));
  } else {
    selectInput("Select game to view", "fileSelected");
  }
}

void fileSelected(File f) {
  if (f == null) {
    f = new File(sketchPath() + "/../example.res");
    println("Loading example file");
  }
  loadGame(f);
}

void draw() {
  if (game == null) {
    background(0);
    textAlign(CENTER);
    textSize(60);
    text("CREMATVIEWER", width / 2, height /2);
    textSize(20);
    text("Choose a file to load", width / 2, height / 2 + 50);
    redraw();
    // Not started yet
    return;
  }
  
  background(0);
  game.renderLayer(Layer.CAVE);
  //game.renderLayer(Layer.SURFACE);
  
  game.renderInfo();
  
  if (isPlaying){
    game.nextRound();
    if (game.atEnd()) isPlaying = false;
  }
}
