/* creates a LineSystem object, which represent a lane in the game , with certain attributes , such as color, x,y coordinate etc...,
 and functions which navigates the flow of the game, such as , producing new object , the rate of the new object being produced, kind of object being produced etc.
 note: the use of  an Arraylist to make everything simple
 note: it is a parentclass
 */
class LineSystemLeft {
  Car car;
  Timer timer;
  Point point1;
  Point point2;
  Point point3;
  Point point4;
  Point point5;
  Point point6;
  ArrayList<Object> line;
  float random;
  float tempObjectX;
  float countPress;
  float originalCarX;
  boolean endGame;
  boolean timeToChange;
  int score;
  color tempcol ;
  float BirthPoint1;
  float BirthPoint2;



  //constructor for the LineSystem class, takes in two parametes : one for the color, one for spacing the lane to the rigth space in the canvas
  LineSystemLeft (float tempCarX, color colCar) {
    line = new ArrayList<Object>();
    BirthPoint1 =height/3.0+1;
    BirthPoint2 =2*height/3.0;
    point1 = new Point(0);
    point2 =  new Point(BirthPoint1);
    point3 = new Point(BirthPoint2);
    point4 =  new Point(0);
    point5 = new Point(BirthPoint1);
    point6 =  new Point(BirthPoint2);
    timer= new Timer(0);
    random = random(1);
    car = new Car ( tempCarX, colCar);
    random = random(1);
    endGame =false;
    timeToChange = false;
    score= 0;
    tempcol = colCar;
    countPress = 0 ;
    originalCarX =tempCarX;
    tempObjectX=tempCarX;
  }

  // Clears up everythin excluding the Car object by initialising again the key variables
  void newGame() {
    if (start== false) {
      rate = floor(bigTimer.getTime()/10)+2;
      car = new Car(originalCarX, tempcol);
      line = new ArrayList<Object>();
      point1 = new Point(0);
      point2 =  new Point(301);
      point3 = new Point(600);
      point4 =  new Point(0);
      point5 = new Point(301);
      point6 =  new Point(600);
      timer= new Timer(0);
      timer= new Timer(0);
      random = random(1);
      endGame =false;
      timeToChange = false;
      score= 0;
      countPress = 0 ;
    }
  }

  //As in an other class , two LineSystem classes used to create on dimesion for the game, this function helps to regulate the random pattern of producing new objects
  // PoinClass regulates the rate of which new Object are being produced
  void flow() {
    countPress();
    if ( tempObjectX < width/2) {
      if ( createObject(point1.y) || createObject(point2.y)|| createObject(point3.y) ) {
        create();
      }
    } else {
      if ( createObject(point4.y) || createObject(point5.y)|| createObject(point6.y) ) {
        create();
      }
    }
  }

  // boolean , takes point as an input and returns true if object inside the interval (giveNewObject function) and randomness generated function is also true( whichSide)
  // note in childclass, different  arguments, makes it random
  boolean createObject(float point) {
    if (endGame== false && giveNewObject(point)==true && whichSide() == true ) {
      return true;
    } else {
      return false;
    }
  }


  //checks if a car and any objects has collided or not for both to Square cases and Circle cases
  //if collided and Square, ends game 
  //if collided and Circle adds point to the scores
  //if not collided and Circle y is more than ciritcal point, ends game

  void collusion (Car car) {
    for ( int i = 0; i < line.size(); i ++ ) {
      Object object = line.get(i);
      if ( object.isCircle== true && object.isSquare == false ) {
        if (object.yPosition+object.xwidth/2 > 4.5*height/6.0) {
          object.showWhenjustDied();
          endGame=true;
        }
        if ( dist(car.car.x, car.car.y, object.x, object.yPosition) < (car.heightCar+object.xwidth)/2 ) {
          line.remove(i);
          score++;
        }
      } else if ( object.isCircle== false && object.isSquare == true  && dist(car.car.x, car.car.y, object.x, object.yPosition) < (car.heightCar+object.xwidth)/2 ) {
        endGame=true;
        object.showWhenjustDied();
        object.beingAlive=false;
      }
    }
  }

  //removes the object from the ArrayList if hit the end of the canvas
  void delete () {
    for (int i = line.size()-1; i>=0; i--) {
      Object p = line.get(i);
      if ( p.removeIt()) {
        line.remove(i);
      }
    }
  }

  //Adds a new object to the ArraList randomly choosen wheter it is square or circle type
  void create() {
    random = random(1);
    if ( random < 0.5 ) {
      line.add(new Square(tempObjectX, tempcol));
    } else if ( random >= 0.5 ) {
      line.add(new Circle(tempObjectX, tempcol));
    }
  }

  // Displays each object that has been created in the Arraylist
  void display() {
    for (int i = line.size()-1; i>=0; i--) {
      Object object = line.get(i);
      object.display();
    }
  }

  //moves the objects inside the Arraylist
  void move() {
    for (int i = line.size()-1; i>=0; i--) {
      Object object = line.get(i);
      object.move();
    }
  }

  // return a boolean value, wheter the game is on or not 
  boolean endGame() {
    if (endGame==true) {
      return true;
    } else {
      return false;
    }
  }

  // creates two points, which will be the refference guide ,when to create objects, object one is for system1, object two is for system two
  void startPoints ( ) {
    timer.countUp();
    point1.update();
    point1.move();
    point2.update();
    point2.move();
    point3.update();
    point3.move();
    if ( timer.getTime() >1.2 && start == true ) {
      point4.update();
      point4.move();
      point5.update();
      point5.move();
      point6.update();
      point6.move();
    }
  }

  // returns score from the set of line
  int getScore() {
    return score;
  }

  //dicedes which line to call using the two other functions below to help to generate randomness
  boolean whichSide() {
    if (  (frameCount+countPress+sysmteRandom()) % 3 == 0 ||  (frameCount+countPress+sysmteRandom()) % 8 == 0 ||  (frameCount+countPress+sysmteRandom()) % 5 == 0 ) {
      return true;
    } else {
      return false;
    }
  }

  // returns a value according to the line x value, will create randomnness between systems
  float sysmteRandom() {
    if (tempObjectX < width /2.0 ) {
      return 1;
    } else {
      return 0;
    }
  }

  //counts keypressed, excellent source for randomness
  void countPress() {
    if (keyPressed) {
      countPress += 1;
    }
  }

  // if poin is beinh the rate/2 interval, returns true
  boolean giveNewObject(float pY) {
    if (abs(BirthPoint1-pY-1.1) <= rate/2) {
      return true;
    } else {
      return false;
    }
  }
}
