Obj obj;

void setup() {
  size(400, 400);
  obj = new Cat();
}

void draw() {
  background(220);
  
  obj.updateState(mouseX, mouseY);
  obj.draw();
}
