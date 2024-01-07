import java.util.Map;

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
  M0,
  M1,
}

class Obj{
  float x, y;
  OnekoState currentState;
  OnekoState lastState;
  RunningDirection directionState;
  RunningMotion motionState;
  float threasholdStopping;
  float speed;
  float waiting;
  float timeWaiting;
  int count, resetCount;

  Obj (){
    x = 0;
    y = 0;
    resetCount = 5;
    count = 0;
    speed = 7.5;
    threasholdStopping = 20;
    timeWaiting = 750;  // ms
    waiting = millis();
    motionState = RunningMotion.M0;
    directionState = RunningDirection.D0;
  }

  void setPosition(float xpos, float ypos){
    x = xpos;
    y = ypos;
  }

  void updateState(float mX, float mY){
    if (count == 0){
      count = resetCount;
    } else {
      count--;
      return;
    }

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
    } else if (millis() - waiting < timeWaiting){
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
    updateMotionState();
    println(directionState, motionState);
  }
  void drawRunning(RunningDirection dS, RunningMotion mS){}
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
    } else {
      directionState = RunningDirection.D4;
    }

  }

  void updateMotionState(){
    if (motionState == RunningMotion.M0){
      motionState = RunningMotion.M1;
    } else {
      motionState = RunningMotion.M0;
    }
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
        drawRunning(directionState, motionState);
        break;
    }

  }
}
