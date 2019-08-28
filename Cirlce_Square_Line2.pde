// Create a Circle childclass, Object Parentclass
class Circle extends Object {

  //constructor for the Circle class, takes in two parametes : one for the color, one for spacing the car to the rigth line dimension
  Circle (float tempObjectX, color tempcol) {
    super( tempObjectX, tempcol);
    isSquare = false;
    isCircle = true;
  }
}

// Create a Square childclass, Object Parentclass
class Square extends Object {

  //constructor for the Square class, takes in two parametes : one for the color, one for spacing the car to the rigth line dimension
  Square (float tempObjectX, color tempcol) {
    super( tempObjectX, tempcol);
    isSquare = true;
    isCircle = false;
  }
}

//Create a Linesystem subclass, lineSystemleft Parentclass
class LineSystemRight extends LineSystemLeft {
  float yPosition;

  //constructor for the LineSystem class, takes in two parametes : one for the color, one for spacing the lane to the rigth space in the canvas
  //note x coordinate is shifted to the correct dimension
  LineSystemRight (float tempCarX, color colCar ) {
    super(tempCarX, colCar);
    tempObjectX=tempCarX+2*width/8.0;
  }

  // boolean , takes point as an input and returns true if object inside the interval (giveNewObject function) and randomness generated function is also true( whichSide)
  // note in Parentclass, different  arguments, makes it random
  boolean createObject(float point) {
    if (endGame== false && giveNewObject(point)==true && whichSide() == false ) {
      return true;
    } else {
      return false;
    }
  }
}
