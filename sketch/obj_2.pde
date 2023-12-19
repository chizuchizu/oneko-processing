enum OnekoState {
  SLEEPING,
  WAITING_FOR_RUNNING,
  RUNNING,
}

enum RunningDirection {
  D0,
  D1,
  D2,
  D3,
  D4,
  D5,
  D6,
  D7,
  D8,
}

enum RunningMotion {
  M1,
  M2,
}

class Obj{
  float x, y;
  OnekoState currentState;
  OnekoState lastState;
  RunningDirection directionState;
  float threasholdStopping;
  float speed;
  float waiting;

  Obj (){
    x = 0;
    y = 0;
    speed = 1.3;
    threasholdStopping = 20;
    waiting = millis();
  }

  void setPosition(float xpos, float ypos){
    x = xpos;
    y = ypos;
  }

  void updateState(float mX, float mY){
    // The difference between mouse position and center of the circle 
    float dx = mX - x;
    float dy = mY - y;

    // Calc the angle for the direction
    float angle = atan2(dy, dx);
    float vx = cos(angle) * speed;
    float vy = sin(angle) * speed;

    // If the cursor was moved
    boolean isFar = sqrt(pow(dx, 2) + pow(dy, 2)) > threasholdStopping;

    if (!isFar){
      currentState = OnekoState.SLEEPING;
      waiting = millis();
    } else if (isFar && millis() - waiting < 1000){
      currentState = OnekoState.WAITING_FOR_RUNNING;
    } else {
      currentState = OnekoState.RUNNING;
    }

    println(currentState, angle);

    lastState = currentState;

    if (currentState == OnekoState.RUNNING){
      setPosition(x + vx, y + vy);
    }
    updateDirectionState(angle);
  }
  void drawRunning(){}
  void drawWaiting_For_Running(){}
  void drawStopping(){}

  void updateDirectionState(float angle){

    if (angle < - QUARTER_PI * 7 / 2){
      directionState = RunningDirection.D4;
    } else if (angle < - QUARTER_PI * 5 / 2){
      directionState = RunningDirection.D5;
    } else if (angle < - QUARTER_PI * 3 / 2){
      directionState = RunningDirection.D6;
    } else if (angle < - QUARTER_PI * 1 / 2){
      directionState = RunningDirection.D7;
    } else if (angle < QUARTER_PI * 1 / 2){
      directionState = RunningDirection.D0;
    } else if (angle < QUARTER_PI * 3 / 2){
      directionState = RunningDirection.D1;
    } else if (angle < QUARTER_PI * 5 / 2){
      directionState = RunningDirection.D2;
    } else if (angle < QUARTER_PI * 7 / 2){
      directionState = RunningDirection.D3;
    }

    println(directionState);
  }

  void draw(){

    switch (currentState){
      case SLEEPING:
        drawStopping();
        break;
      case WAITING_FOR_RUNNING:
        drawWaiting_For_Running();
        break;
      case RUNNING:
        drawRunning();
        break;
    }

  }
}
