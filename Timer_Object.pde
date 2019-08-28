// timer object 
class Timer {
  float time;

  // takes an initiual value for set a timer
  Timer(float set) {
    time= set;
  }

  // returns a float data for the time
  float getTime() {
    return time;
  }

  // pauses time 
  float pauseTime() {
    float timePaused = time;
    return timePaused ;
  }


  //sets time
  void setTime(float set) {
    time = set;
  }

  //start counting up when calling a function
  void countUp () {
    time +=1/frameRate;
  }

  //starts counting down when calling the function
  void countDown () {
    time -=1/frameRate;
  }
}

// new class button, sets the buttons and the displaying background to the desirable state
class Button {
  Circle circle;
  Square square;
  Car carLeft;
  Car carRight;
  float howLong;
  float parameterX;
  float x;
  float y;
  float highscoreX;
  float pauseX;
  float pauseY;
  float pauseWidth;
  float startButtonWidth;
  color lineColor;


  // constructor to the button
  Button() { 
    parameterX=width/8.0*6;
    carLeft = new Car(parameterX, colorLeft);
    carRight = new Car(parameterX, colorRight);
    circle = new Circle (parameterX, colorLeft);
    square = new Square (parameterX, colorRight);
    x =width/2.0;
    y= height/2.0;
    howLong= 600;
    pauseX=x-4.5*width/10.0;
    pauseY =y-4*height/10.0;
    pauseWidth=width/25.0;
    highscoreX = x + width/16.0*7;
    startButtonWidth=x/1.5;
    lineColor =#6471A6;
  }

  // main starting page
  void startButton() {
    stroke(#DADEF5);
    textSize(24);
    textAlign(CENTER, CENTER);
    text(" Click ", x, y );
    noFill();
    ellipseMode(CENTER);
    ellipse(x, y, startButtonWidth, startButtonWidth);
  }

  // creates a button, clicling on which resutls pausing the game
  void pauseButton() {
    textSize(24);
    textAlign(CENTER, CENTER);
    fill(255);
    text(" || ", x-4.5*width/10.0, y-4*height/10.0);
    noFill();
    stroke(#DADEF5);
    rectMode(CENTER);
    rect(pauseX, pauseY, pauseWidth, pauseWidth);
  }

  // resumes the game
  void resume() {
    stroke(#DADEF5);
    textSize(24);
    textAlign(CENTER, CENTER);
    fill(textColor);
    text(" RESUME ", x, y );
    noFill();
    ellipseMode(CENTER);
    ellipse(x, y, startButtonWidth, startButtonWidth);
  }

  // button for high score, clicking on which results displaying the best score on the canvas
  void highScores() {
    stroke(#DADEF5);
    textSize(24);
    textAlign(CENTER, CENTER);
    fill(textColor);
    text(" SCORES ", x+350, y );
    noFill();
    ellipseMode(CENTER);
    ellipse(highscoreX, y, x/4.5, x/4.5);
  }

  //displays background while gaming
  void drawBackgroundinGame() {
    stroke(lineColor);
    strokeWeight(2);
    line(width/4.0, 0, width/4.0, height);
    line(width/4.0*3, 0, width/4.0*3, height);
    strokeWeight(4);
    line(width/2.0, 0, width/2.0, height);
  }

  //disclamer that nonprofit project and all use is for educational
  void disclaimer() {
    background(0);
    textAlign(CENTER);
    text("All copyrights reserved to the originial' 2 Cars' creators.", width/2.0, height/2.0-20);
    text("This duplicate is only for educational purposes for Adelaide University,", width/2.0, height/2.0);
    text(" introduction for programming group Wr01-07", width/2.0, height/2.0+20);
    if ( frameCount > howLong) {
      disclaimer = false;
      instruction = true;
    }
  }

  // basic instruction for the game , as humasn are highly visual animals, provided visual help to understand what to catch, what to avoid
  void instructions() {
    background(#25337A);
    if (instruction == true && frameCount < howLong*2) {
      circle.yPosition =  1.3*height/6.0;
      circle.display();
      square.yPosition =  2* height/6.0;
      square.display();
      carLeft.car.y =3*height/6.0;
      carLeft.display();
      carRight.car.y = 4*height/6.0;
      carRight.display();
      textSize(56);
      fill(textColor);
      textAlign(CENTER);
      text(" INSTRUCTIONS", width/2.0, height/12.0);
      textSize(24);
      text(" Get as many points as you can!", width/2.0, height/9.0);
      fill(255);
      textAlign(LEFT);
      text(" Catch all Circles", xValueLeft/2.0, 1.3*height/6.0);
      text(" Avoid all Squares", xValueLeft/2.0, 2*height/6.0);
      text(" Red car moves  with 'a' and'd'", xValueLeft/2.0, 3*height/6.0);
      text(" Blue car moves with left arrow, right arrow", xValueLeft/2.0, 4*height/6.0);
      text(" press 's' for pause", xValueLeft/2.0, 5*height/6.5);
    } else {
      instruction = false;
    }
  }
}
