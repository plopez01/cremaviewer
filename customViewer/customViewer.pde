import java.io.*;
import java.util.*;
import java.net.*;

Game game;
boolean isPlaying = false;
String titleText = "Choose a file to load";

void loadGame(Reader f) {
  try {
    // Local first because this can run in a different thread and if we publish it too early it explodes
    Game g = new Game(f);
    g.loadGame();
    g.printSummary();
    titleText = "Starting display";
    game = g;
  } catch (IOException | IllegalArgumentException e) {
    titleText = "Error while opening specified game file: \n" + e.getMessage();
  }
}

void handlePathArgument(String path) {
  try {
    if (path.startsWith("https://")) {
      titleText = "Loading game from argument provided URL " + path;
      URL url = new URL(path);
      loadGame(new InputStreamReader(url.openStream()));
    } else {
      titleText = "Loading game from file in argument: " + path;
      loadGame(new FileReader(path));
    }
  } catch (IOException e) {
    titleText = "Failed to open game from file provided in gameFile argument";
  }
}

void setup() {
  fullScreen(1);
  //size(1760, 940);
  println(sketchPath());  
  background(0);
  
  String argPath = System.getProperty("gameFile");
  if (argPath != null) {
    // simple thread given we only need one thing
    // consistency with selectInput also calls back on another thread,
    // allows showing loading message
    new Thread(() -> handlePathArgument(argPath)).start();
  } else {
    selectInput("Select game to view", "fileSelected");
  }
}

void fileSelected(File f) throws IOException {
  if (f == null) {
    f = new File(sketchPath() + "/../example.res");
    println("Loading example file");
    titleText = "Loading example game file...";
  } else {
    titleText = "Loading game from file " + f.getName() + "...";
  }
  loadGame(new FileReader(f));
}

void draw() {
  if (game == null) {
    background(0);
    textAlign(CENTER);
    textSize(60);
    text("CREMAVIEWER", width / 2, height /2);
    textSize(20);
    text(titleText, width / 2, height / 2 + 50);
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
