// creates a class
// note these class is a premise for a systemclass and a ArrayList using it
//note will be referring to as particuales tot his class in some cases
class Exhaustion {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float square;
  float opacity;

  //constructor of exhasution
  // note  that with the 3 PVector , will be control each individual Exhaustion object
  // for better graphic effect needed to involve some physics
  Exhaustion(PVector l, color colore) {
    location =  l.get();
    velocity = new PVector(random(-0.5, 0.5), 3);
    acceleration =  new PVector(0, 0);
    square = random(10);
    opacity =random( 255);
  }

  //displays the color and the shape
  void display(color car) {
    fill(car, opacity);
    stroke(2, car);
    rect(location.x, location.y, square, square);
  }  

  // updates the location on the canvas
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    opacity -=10;
  }

  //add force to exhasutionparticulas
  void addForce(PVector force) {
    acceleration.add(force);
  }

  //displays and updates gas
  void run(color colore) {
    update();
    display(colore);
  }

  // boolean telling whether a exhasution is worn out
  boolean isDead() {
    if (opacity < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}


//systemclass, contains an arraylist of the class before
//crucisal for the exhasutinggas and for the exploison
class ExhaustionSystem {
  ArrayList<Exhaustion> ex;
  color colore;
  PVector origin;
  float random;

  //constructor of the class
  ExhaustionSystem(PVector v, color colors) {
    ex =  new  ArrayList<Exhaustion>();
    colore= colors;
    origin = v.get();
  }

  // adds new element to the sytem, runs the sytem
  void exhaust () {
    random = random(1);
    if ( random < 0.8) {
      ex.add(new Exhaustion(origin, colore));
      for ( Exhaustion gas : ex ) {
        gas.run(colore);
      }
    }
  }

  // removes dead gas
  void removes() {
    for ( int i = ex.size()-1; i > 0; i -- ) {
      Exhaustion gas  =  ex.get(i);
      if (gas.isDead()) {
        ex.remove(i);
      }
    }
  }
}

// similar concept  to the class before, differen animation 
class Explosion {
  ArrayList<Exhaustion> ex;
  color colore;
  PVector origin;
  PVector explodes;


  Explosion(PVector v, color colors) {
    ex =  new  ArrayList<Exhaustion>();
    colore= colors;
    origin = v.get();
    explodes = new PVector ( random(-100, 100), random(-100, 100));
  }

  // displays explosion by creating 75 of the first class in an arraylsit and give every individual object a vector and force and runs it
  void explodes() {
    for ( int i=1; i < 75; i++) {
      ex.add(new Exhaustion(origin, colore));
    }
    for ( Exhaustion gas : ex ) {
      explodes = new PVector ( random(-7.5, 7.5), random(-7.5, 7.5));
      gas.run(colore);
      gas.addForce(explodes);
    }
  }

  //sets to the right place the epicenter of the exploison
  void updateY(float something) {
    origin.y = something;
  }

  //removes not used object from the Arraylist
  void removes() {
    for ( int i = ex.size()-1; i > 0; i -- ) {
      Exhaustion gas  =  ex.get(i);
      if (gas.isDead()) {
      }
    }
  }
}
