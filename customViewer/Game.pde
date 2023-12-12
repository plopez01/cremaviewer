int PLAYER_COUNT = 4;
int MAP_WIDTH = 80;
int MAP_HEIGHT = 40;
int LAYERS = 2;
int ROUNDS = 121;
int GEM_VALUE = 30;

int FURYANS = 20;
int PIONEERS = 60;
int NECROMONGERS = 10;
int HELLHOUNDS = 3;
int TOTAL_UNITS = FURYANS + PIONEERS + NECROMONGERS + HELLHOUNDS;

enum Layer {
  CAVE,
  SURFACE
}

class Game {
  UserInterface ui = new UserInterface(createGraphics(width, height));
  Renderer caveRenderer;
  Renderer surfaceRenderer;
  
  BufferedReader gameData;

  String seed;
  String[] names = new String[PLAYER_COUNT];
  int[][] cells = new int[ROUNDS][PLAYER_COUNT];
  int[][] gems = new int[ROUNDS][PLAYER_COUNT];
  
  int round = 0;

  Game(Reader file) throws FileNotFoundException {
    gameData = new BufferedReader(file);
  }


  void printSummary() {
    println("Game summary:");
    println(seed);
    println(Arrays.toString(names));
  }

  void loadGame() throws IOException, IllegalArgumentException {
    int round = 0;
    
    skipLines(gameData, 2);

    seed = gameData.readLine();

    skipLines(gameData, 1);

    if (!gameData.readLine().equals("Crematoria 1.2")) {
      throw new IllegalArgumentException("Invalid game data, wrong file maybe?");
    }

    skipLines(gameData, 11);

    names = gameData.readLine().split("names")[1].trim().split(" ");
    
    int[][][][] map = new int[LAYERS][ROUNDS][MAP_WIDTH][MAP_HEIGHT];
    Unit[][][] units = new Unit[LAYERS][ROUNDS][TOTAL_UNITS];
    int[][] moves = new int[ROUNDS][TOTAL_UNITS];
    
    while (true){
      skipLines(gameData, 2);
      
      for (int layer = 0; layer < LAYERS; layer++){
        for (int x = 0; x < MAP_HEIGHT; x++) {
          for (int y = 0; y < MAP_WIDTH; y++) {
            int data = gameData.read();
            map[layer][round][y][x] = data;
          }
          gameData.readLine();
        }
      }
      
      skipLines(gameData, 2);
      
      cells[round] = int(gameData.readLine().split("nb_cells ")[1].split(" "));
      gems[round] = int(gameData.readLine().split("nb_gems ")[1].split(" "));
      
      skipLines(gameData, 1);
      
      
      // Read units
      String line = gameData.readLine();
      int unitId = 0;
      while (!line.trim().equals("")){
        String[] unitData = line.split(" ");
        int layer = abs(int(unitData[6])); // abs for necromongers
        
        switch(unitData[0]){
          case "f":
            Furyan furyan = new Furyan();
            furyan.init(unitId, int(unitData[1]), int(unitData[2]), new PVector(int(unitData[4]), int(unitData[5]), layer));
            units[layer][round][unitId] = furyan;
          break;
          
          case "p":
            Pioneer pioneer = new Pioneer();
            pioneer.init(unitId, int(unitData[1]), int(unitData[2]), new PVector(int(unitData[4]), int(unitData[5]), layer));
            units[layer][round][unitId] = pioneer;
          break;
          
          case "n":
            Necromonger necromonger = new Necromonger(int(unitData[3]));
            necromonger.init(unitId, int(unitData[1]), int(unitData[2]), new PVector(int(unitData[4]), int(unitData[5]), layer));
            units[layer][round][unitId] = necromonger;
          break;
          
          case "h":
            Hellhound hellhound = new Hellhound();
            hellhound.init(unitId, int(unitData[1]), int(unitData[2]), new PVector(int(unitData[4]), int(unitData[5]), layer));
            units[layer][round][unitId] = hellhound;
          break;
        }
  
        line = gameData.readLine();
        unitId++;
      }
      
      skipLines(gameData, 2);
      
      // Last round has no movements so end here
      if (round == ROUNDS-1){
        round = 0;
        break;
      }
      
      String move = gameData.readLine();
      while (!move.equals("-1")) {
        int[] data = int(move.split(" "));
        moves[round][data[0]] = data[1];
        
        move = gameData.readLine();
      }
      round++;
    }
    
    gameData.close();
    
    caveRenderer = new Renderer(ui, map[0], units[0]);
    surfaceRenderer = new Renderer(ui, map[1], units[1]);
  }
  
  void nextRound(){
    round++;
    if (round > ROUNDS-1) round = ROUNDS-1;
  }
  
  void previousRound(){
    round--;
    if (round < 0) round = 0;
  }
  
  void goToStart(){
    round = 0;
  }
  
  void goToEnd(){
    round = ROUNDS - 1;
  }
  
  boolean atEnd(){
    return round == ROUNDS - 1;
  }
  
  void renderLayer(Layer layer) {
    ui.b.beginDraw();
    switch(layer){
      case CAVE:
        caveRenderer.render(round);
      break;
      
      case SURFACE:
        surfaceRenderer.render(round);
      break;
    }
    ui.b.endDraw();
    image(ui.b, 0, 0, width, height);
    ui.b.clear();
  }
  
  void renderInfo(){
    int CELL_SIZE = surfaceRenderer.CELL_SIZE; // fix this
    
    int xOff = VIEWER_MARGIN_HOR;
    int yOff = VIEWER_MARGIN_VER + CELL_SIZE * MAP_HEIGHT + 30;
    
    textAlign(LEFT);
    fill(255);
    text("Round: " + round, xOff, yOff);
    
    for (int playerId = 0; playerId < PLAYER_COUNT; playerId++) {
      int score = cells[round][playerId] + GEM_VALUE * gems[round][playerId];
      int pOff = width - xOff - 150*playerId;
      
      fill(playerColors[playerId]);
      square(pOff, yOff - 15/2 - textAscent()/2, 15);
      
      textAlign(LEFT);
      text(score, pOff - textWidth(str(score)) - 10, yOff);
      
      textAlign(RIGHT);
      text(names[playerId], pOff + 15, yOff + 25);
    }
  }
}
