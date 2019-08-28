//Setting global variances
SystemForOneColor right;    // blue color dimension
SystemForOneColor left;     // red color dimension
Timer bigTimer;             // controls the flow of the game , restarts when gamers dies
Timer smallTimer;           // when dead, helps to control animation
Button button;              // controls button and display areas
String[] bestScore;         // saves bestScore to aan Array String then reloads is
boolean showMeBest;         // shows best score
boolean start;              // if true starts game
boolean newgame;            // if true starts new game
boolean paused;             // if true pauses game
boolean disclaimer;         // displays disclaimer
boolean instruction;        // displays instructions
boolean bestScoreChanged;   // displays congrats message if a new best score has set
color colorLeft;            //  sets the color of the left dimension
color colorRight;           // sets the color of the right dimension
color textColor;            // textcolour during grapighc
float xValueLeft;           // sets the lanes inside the dimension, as the lanes takes on an parameter for their x value, left
float xValueRight;          // right
float rate;                 // controls the rate of speed
float periodAfterDeath;     // timeperiod after the gamedied
int score;                  // score during the game
int setMax;                 // sets maxmimum speed for the objects, car
float countPressed;
void setup() {    
  size(800, 800);
  background(0);
  xValueLeft= width/8.0;
  xValueRight= width/8.0*5;
  colorLeft = (#CE466E);
  colorRight= (#03A9C3);
  textColor = (#D6AFBB);
  left = new SystemForOneColor(xValueLeft, colorLeft);
  right = new SystemForOneColor(xValueRight, colorRight);
  bigTimer =  new Timer(0);
  smallTimer = new Timer(0);
  score = 0 ;
  countPressed = 0;
  periodAfterDeath = 4;
  setMax = 25;
  bestScoreChanged = false;
  instruction = false;
  disclaimer = true;
  start = false;
  newgame = false;
  button = new Button();
  bestScore = loadStrings("bestScore.txt");
  rate = floor(bigTimer.getTime()/10)+2;      // sets the speed for the Objects, for the Car and for the helping Point Objects
}

// where everything happens , note 14 lines!!!
void draw() {
  maximumSpeed(setMax);
  if ( disclaimer == true) {
    button.disclaimer();
  } else if ( instruction == true && disclaimer == false ) {
    button.instructions();
  } else if ( start == false && disclaimer == false) {
    firstCase();
  } else if ( paused == true && disclaimer == false ) {
    thirdCase();
  } else if (start == true && paused == false && disclaimer == false) {
    secondCase();
  }
}

// returns the bestCore considering the score during the game and the Bestscore that is saved in a textfile
int bestScore() {
  bestScore = loadStrings("bestScore.txt");
  int tempscore = 0;
  if ( int(bestScore[0])> score ) {
    tempscore=int(bestScore[0]);
    bestScoreChanged = true;
  } else {
    tempscore=score;
  }
  return tempscore;
}

//saves the returned value from the former functino to a textfile
void saves() {
  int tempscore = bestScore();
  String [] saveS = {str(tempscore)};
  saveStrings("bestScore.txt", saveS);
}

// event function, there 3  buttons altogether in a game, in different setup, and these are the cooridnates
void mouseClicked() {
  if ( dist(mouseX, mouseY, button.x, button.y)< (button.startButtonWidth*2) && paused == false) {
    start = true;
  }
  if ((mouseX> button.pauseX-(button.pauseWidth)/2 && mouseX < button.pauseX+(button.pauseWidth)/2 ) && (mouseY>button.pauseY-(button.pauseWidth)/2 && mouseY < button.pauseY+(button.pauseWidth)/2)) {
    paused = true;
  }
  if ( paused == true &&  dist(mouseX, mouseY, button.x, button.y)< (button.startButtonWidth/3.0*2)) {
    paused = false;
    showMeBest = false;
  }
  if ((paused == true || start == false ) &&  dist(mouseX, mouseY, button.highscoreX, button.y)<(button.startButtonWidth/3.0*2)) {
    if ( countPressed % 2== 0) {
      showMeBest = true;
    } else {
      showMeBest = false;
    }
    countPressed++;
  }
}

// after the disclamer and the instruction page this is a starting page, also every new game start with displaying this page
void startingPage() {
  background(#25337A);
  fill(textColor);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("TWO CARS", width/2.0, height/8.0*1);
}

//another eventfunction
// moves the car objects with (left/ right) and (a,d/A,D) 
void keyPressed() {
  if (key == CODED) {
    if ( keyCode == RIGHT) {
      right.car.Pressright = true;
    } else if ( keyCode == LEFT) {
      right.car.Pressleft = true;
    }
  } else {
    if ( key == 'd' || key == 'D') {
      left.car.Pressright = true;
    } else if ( key == 'a'|| key == 'A' ) {
      left.car.Pressleft = true;
    } else if ( key == 's' || key == 'S') {
      if  ( paused == true) {
        paused= false;
        showMeBest = false;
      } else {
        paused = true;
      }
    }
  }
}

// shows on the displays is new bestscore is reached
void whenNewBestScore() {
  bestScore();
  textSize(22);
  if ( bestScoreChanged== false) {
    fill(255);
    text(" New Best Score : " + bestScore(), width/6.0, height/4.0);
  } else if (bestScoreChanged == true) {
    text(" Best Score : " + bestScore(), width/6.0, height/4.0);
  }
}

// there are 3 cases inside the game
// first (which is this) when a starting page is displaying, and a user has to click on a starting button
void  firstCase() {
  startingPage();
  whenNewBestScore();
  button.startButton();
  newgame = true;
  if ( newgame== true) {
    bigTimer.setTime(0);
    bestScoreChanged= false;
  }
}

// is basicallyy the game experience, the games has clicked on a starting button and now objects are coming
// can break out from a second case, by dying, or by entering the thirdcase
void secondCase() {
  if ( paused == false) {
    bigTimer.countUp();
  }
  background(#25337A);
  button.pauseButton();
  button.drawBackgroundinGame();
  left.display();      
  right.display();
  fill(255);
  score = left.getScore()+right.getScore();
  text(score, width/16.0*15, height/20.0*2);
  if (left.beingDead()== false && right.beingDead()== false) {    
    left.create();
    right.create();
    right.flow();
    left.flow();
    left.moveObject();
    right.moveObject();
  } else {
    bigTimer.setTime(0);
    smallTimer.countUp();
    left.change();
    right.change();
    left.beingDead();
    right.beingDead();
    if (smallTimer.getTime() > periodAfterDeath) {
      start= false;
      smallTimer.setTime(0);
      left.change();
      right.change();
      left.beingDead();
      right.beingDead();
      saves();
    }
  }
  left.collusion();
  right.collusion();
  right.endGame();
  left.endGame();
}  

// which leads us to the thirdCase, which is a basically a pauseCase
// can reenter the second case by pressing the resume button , or by pressing 's'
void thirdCase() {
  if ( paused == true) {
    noStroke();
    fill(#25337A, 1);
    rect(0, 0, 10000, 10000);
    button.resume();
    button.highScores();
    float saveTime = bigTimer.pauseTime();
    bigTimer.setTime(saveTime);
    if (showMeBest== true) {
      fill(255, 122);
      text("Best Score : " + bestScore(), width/8.0, height/4.0);
    } else {
      fill(#25337A);
      text("Best Score : " + bestScore(), width/8.0, height/4.0);
    }
  }
}

// sets maximum speed
void maximumSpeed(int tempMax) {
  if ( rate <tempMax) {
    rate = floor(bigTimer.getTime())/10+2;
  } else {
    rate = tempMax;
  }
}
