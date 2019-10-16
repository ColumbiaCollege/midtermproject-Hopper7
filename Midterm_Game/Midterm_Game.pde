//Shane Hopper

// call class
Player1 player1;
Player2 player2;
Platform platform;
//Physics physics;

void setup() {
  size(1000, 600);
  background(255);
  textAlign(CENTER, CENTER);
  //initialize class
  player1 = new Player1();
  player2 = new Player2();
  platform  = new Platform();
  //physics = new Physics();
  
}
void draw() { 
  background(255);
  // call my draw character object
  player1.drawCharacter();
  player1.move();
  player1.attack1();
  player1.getsHit();
  player2.drawCharacter();
  player2.move();
  player2.attack2();
  player2.getsHit();
  platform.drawPlatform();
  //physics.gravity();
  println();
}

void keyPressed() {
  //assign control booleans to true when keys pressed
  player1.move();
  player1.pressed();
  player2.move();
  player2.pressed();
}

void keyReleased() {
  //assign control booleans back to false when keys released
  player1.move();
  player1.released();
  player2.move();
  player2.released();
}
