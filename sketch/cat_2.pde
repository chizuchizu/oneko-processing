class Cat extends Obj{
  @Override
  void drawRunning(){
    circle(x, y, 20);
  }

  @Override
  void drawWaiting_For_Running(){
    triangle(x, y, x + 10, y + 10, x + 20, y);
  }
  
  @Override
  void drawStopping(){
    square(x, y, 20);
  }
}
