// system class encapsulates the two LineSystemclasses and a car object, basically that provides everything that displys in one color
class SystemForOneColor {
  LineSystemRight right;
  LineSystemLeft  left;
  Car  car;
  float tempCarX;
  boolean beinDead;
  float random;
  float moveBackCars;
  color colCar;
  int score;
  boolean whichOne;


  //constructor for the Systemclass class, takes in two parametes : one for the color, one for the whole the lane dimension either to the lefthalf or to the right half 
  SystemForOneColor(float tempXx, color tempCol) {
    tempCarX=tempXx;
    colCar=tempCol;
    right = new LineSystemRight(tempCarX, colCar);
    left = new LineSystemLeft(tempCarX, colCar);
    car = new Car(tempCarX, colCar);
    beinDead = false;
    random = random(1);
    score=0;
    moveBackCars=0.0000001;
    whichOne = true;
  }

  // displays collusion
  void collusion() {
    left.collusion(car);
    right.collusion(car);
  }

  // the flow of the line
  void flow() {
    left.startPoints();
    right.startPoints();
    left.flow();
    right.flow();
  }

  //creates and move the car object
  void create() {
    car.display();
    car.move();
    right.delete();
    left.delete();
  }

  // if any of the two line has come to an end , ends the game shows the correct display
  void endGame() {
    if ((left.endGame()==true) || (right.endGame()==true)) {
      left.display();
      right.display();
      beinDead=true;
      newgame = false;
    }
  }

  //displays objects in both lanes
  void display() {
    left.display();
    right.display();
    car.display();
  }

  // move Objects if left or right lane is not dead
  // recall a lane is dead in two cases, missing a Circle or hitting a Square
  void moveObject() {
    if ((left.endGame()==false) || (right.endGame()==false)) {
      left.move();
      right.move();
      beinDead=false;
    }
  }

  // adds up the the score from both sides
  int getScore() {
    return left.getScore()+right.getScore();
  }

  // changes the layout of the game, calls a newgame
  void change() {
    left.newGame();
    right.newGame();
    beinDead=false;
    if (smallTimer.getTime() >= periodAfterDeath - moveBackCars) {
      car = new Car(tempCarX, colCar);
    }
  }

  // returns a boolean wheter the game is on or not, seeing the two lines
  boolean beingDead () {
    if (beinDead==true) {
      return true;
    } else {
      return false;
    }
  }
}
