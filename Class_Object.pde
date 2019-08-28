//Creates the object the gamer facing against, a parentclass for the two 'opposite'  classes Square and Circle. Note those two will only be initialise in the "Subclass.." tab
class Object {
  Timer timer;
  Explosion squareExplodes;
  PVector object;
  PVector explodes;
  float exploisonTime;
  float x;
  float y;
  float xwidth;
  float yPosition;
  float accelerate;
  color col;
  color white;
  color col2;
  float random;
  boolean isSquare;
  boolean isCircle;
  boolean beingAlive;

  //constructor for the Object class, takes in two parametes : one for the color, one for spacing the car to the rigth line dimension
  Object (float tempObjectX, color tempcol) {
    object = new PVector(tempObjectX, 512);
    explodes = new PVector ( random(-10, 10), random(-10, 10));
    squareExplodes = new Explosion(object, tempcol);
    x=tempObjectX;
    yPosition= 0;
    xwidth=width/14.0;
    accelerate = 0;
    exploisonTime= 0.15;
    col = tempcol;
    col2 = tempcol;
    white= #FFFFFF;
    random=random(50);
    isSquare = false;
    isCircle = false;
    beingAlive = true;
  }

  /*Creates the graphical image of the object, note : that both for Circle and Square!
   Important to  function , makes it clear later on what will happen when an Object and A car collides*/
  void display () {
    if ( beingAlive== true) {
      if ( isSquare== false && isCircle== true) {
        fill(col);
        noStroke();
        ellipseMode(CENTER);
        ellipse(x, yPosition, xwidth, xwidth);
        fill(white);
        ellipse(x, yPosition, xwidth/4.0*3, xwidth/4.0*3);
        fill(col);
        ellipse(x, yPosition, xwidth/4.0*2, xwidth/4.0*2);
      } else if ( isSquare== true && isCircle== false) {
        fill(col);
        noStroke();
        rectMode(CENTER);
        rect(x, yPosition, xwidth, xwidth);
        fill(white);
        rect(x, yPosition, xwidth/4.0*3, xwidth/4.0*3);
        fill(col);
        rect(x, yPosition, xwidth/4.0*2, xwidth/4.0*2);
      }
    }
  }

  // Checks if object reaches the end of the canvas
  boolean removeIt () {
    if ( yPosition+xwidth+5+100 == height) {
      return true;
    } else {
      return false;
    }
  }

  // displays an animation when dead, important here, so its callable in the arraylist
  void showWhenjustDied() {
    if ( isSquare== false && isCircle== true) {
      missCircle();
    } else {
      hitSquare();
    }
  }

  // displays bipping effect when a Cicrle object has been missed
  void missCircle() {
    if ((smallTimer.getTime()> 0.5 &&  smallTimer.getTime()< 1) || (smallTimer.getTime()> 1.5 &&  smallTimer.getTime()< 2 )|| (smallTimer.getTime()> 2.5 &&  smallTimer.getTime()< 3) || (smallTimer.getTime()> 3.5 &&  smallTimer.getTime()< 4) ) {
      white = #25337A;
      col = #25337A;
    } else {
      white =  #FFFFFF;
      col = col2;
    }
  }

  // displays explosion when a square object being hit
  void hitSquare() {
    if (smallTimer.getTime() < exploisonTime ) {
      squareExplodes.updateY(yPosition);
      squareExplodes.explodes();
      squareExplodes.removes();
    }
  }

  //changes speed as teh game progresses
  float speed () {
    accelerate=rate;
    return accelerate ;
  }

  //moves the object
  void move() { 
    yPosition+=speed();
  }
}
