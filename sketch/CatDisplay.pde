class Cat extends Obj{
  Map<RunningDirection, String> filePathMap = Map.of(
        RunningDirection.D0, "imgs/right%s.gif",
        RunningDirection.D1, "imgs/dwright%s.gif",
        RunningDirection.D2, "imgs/down%s.gif",
        RunningDirection.D3, "imgs/dwleft%s.gif",
        RunningDirection.D4, "imgs/left%s.gif",
        RunningDirection.D5, "imgs/upleft%s.gif",
        RunningDirection.D6, "imgs/up%s.gif",
        RunningDirection.D7, "imgs/upright%s.gif"
    );

  @Override
  void drawRunning(RunningDirection dS, RunningMotion mS){
    String suffix = mS == RunningMotion.M0 ? "1" : "2";
    String filePath = filePathMap.get(dS).formatted(suffix);

    PImage img = loadImage(filePath);
    image(img, x, y);
  }

  @Override
  void drawWaiting_For_Running(){
    PImage img = loadImage("imgs/awake.gif");
    image(img, x, y);
  }
  
  @Override
  void drawStopping(){
    PImage img = loadImage("imgs/mati2.gif");
    image(img, x, y);
  }
}
