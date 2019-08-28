// creates a car object with certain attributes , such as color, x,y coordinate etc..., and a function which moves the car for pressing certain keys
class Car {
  ExhaustionSystem gas;
  Object object;
  PVector car; 
  boolean Pressright; 
  boolean Pressleft;
  float widthCar ;
  float heightCar;
  float cornerRadius;
  color col;
  PVector exhaust;
  float rotates;
  float x;

  //constructor for the car class, takes in two parametes : one for the color, one for spacing the car to the rigth line dimension
  Car(float tempCarX, color colCar) {
    object = new Object(tempCarX, colCar);
    car = new PVector(tempCarX, 4.*height/6.0 );
    exhaust = new PVector (0, 60);
    gas = new ExhaustionSystem(exhaust, colCar);
    Pressright = false;
    Pressleft =  false;
    widthCar = width/15.0;
    heightCar = height/7.2;
    cornerRadius=18;
    rotates = 0;
    col =colCar;
    x = tempCarX;
  }

  //displays car
  void display () {
    pushMatrix();
    translate(car.x, car.y);
    rotate(rotates);
    gas.exhaust();    // exhaust is attach to the back of the car
    gas.removes();
    noStroke();
    rectMode(CENTER);
    fill(col);
    rect(0, 0, widthCar, heightCar, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
    fill(255);
    rect(0, 0, widthCar/4.0*3, heightCar/4.0*3.3, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
    fill(col);
    rect(0, 0, widthCar/2.5, heightCar/4.2);
    fill(#25337A);
    beginShape();
    vertex(0-( widthCar/3.2), 0 - heightCar/4.0);
    bezierVertex(-widthCar/3., -heightCar/3.15, widthCar/3, -heightCar/3.2, widthCar/3.15, -heightCar/4.0);
    vertex(widthCar/5.0, -heightCar/8.4);
    vertex(-widthCar/5.0, -heightCar/8.4);
    endShape(CLOSE);
    beginShape();
    vertex(0-( widthCar/3.2), heightCar/4.0);
    bezierVertex(-widthCar/3., heightCar/3.15, widthCar/3, heightCar/3.2, widthCar/3.15, heightCar/4.0);
    vertex(widthCar/5.0, heightCar/8.4);
    vertex(-widthCar/5.0, heightCar/8.4);
    endShape(CLOSE);
    popMatrix();
    //  createShape(car.x+ widthCar/2.2/2,car.yheightCar/3.75/2);
  }

  //move the Car object by pressing  keys
  void move () {
    if ( Pressright == true) {
      if (  car.x < object.x + 2*width/8.0) {
        rotates = (PI/3);
        car.x += (5+object.speed());
      }
      if ( car.x >= object.x + 2*width/8.0) {
        car.x = object.x + 2*width/8.0;
        rotates = 0 ;
        Pressright = false;
      }
    } else if ( Pressleft == true) {
      if (  car.x > object.x) {
        rotates = (-PI/3);
        car.x -= (5+object.speed());
      }
      if ( car.x <= object.x) {
        car.x = object.x;
        rotates = 0 ;
        Pressleft = false;
      }
    }
  }
}
