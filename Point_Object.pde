/* Regulates the flow of the production of new Objects, creates a point which goes from the top to the bottom periodically
 its speed is corresponding to the objects speed */
class Point {
  float x; 
  float y; 
  float accelerate ;

  // constructor to the Point Object, parameter as a starting y coordinate
  Point(float tempY) {
    x = 0 ; 
    y = tempY; 
    accelerate = 0 ;
  }

  // corresponding to the cars and the objects speed
  float speed () {
    accelerate=rate;
    return accelerate ;
  }

  // reaches the bottom of the canvas, start from the top
  void update() {
    //stroke(255);
    // point(x,y);  // for the presentation
    if (y > height) {
      y = 0;
    }
  }

  //moves the object with the accurate level of speed
  void move() { 
    y+=speed();
  }
}
