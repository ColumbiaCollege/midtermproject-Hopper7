class Player2 {

  //position
  PVector position2;
  //gravity
  PVector gravity;
  //control switches
  int moveSwitch = 0;
  int upDownSwitch = 0;
  //amount of speed
  PVector speedAccel;
  PVector speed;
  //attack
  PVector hitFactor;
  int hitAmount = 3;
  PVector velocity;
  //jump
  PVector jump;
  int setTimer;
  int timer;
  int jumpCounter = 2;
  float jumpFactor = -10;
  //% health
  int health = 0;
  // bonus power
  int bonus = 0;
  //lives
  int lives = 3;
  //booleans for controls
  boolean moveLeft = false;
  boolean moveRight = false;
  boolean up = false;
  boolean crouch = false;
  boolean attack = false;

  Player2() {
    //start position
    position2 = new PVector(width * 1/3, height/2);
    //set gravity
    gravity = new PVector(0, 0.3);
    //set speed
    speed = new PVector(0, 0);
    speedAccel = new PVector(0.3, 0);
    //set jump
    jump = new PVector(0, jumpFactor);
    velocity = new PVector(0,0);
    //set hit
    hitFactor = new PVector(hitAmount,hitAmount);
  }
  //set controls
  void pressed() {
    if (key == 'g' || key == 'G') {
      attack = true;
    }
    if (key == 'a' || key == 'A') {
      moveLeft = true;
    }
    if (key == 'd' || key == 'D') {
      moveRight = true;
    }
    if (key == 'w' || key == 'W') {
      up = true;
    }
    if (key == 's' || key == 'S') {
      crouch = true;
    } 
    // assign switch to left and right booleans
    if (moveLeft == true) {
      moveSwitch = -1;
    }
    if (moveRight == true) {
      moveSwitch = 1;
    }
    if (up == true) {
      upDownSwitch = -1;
    }
    if (crouch == true) {
      upDownSwitch = 1;
    }
  }
  // when released
  void released() {
    if (key == 'g' || key == 'G') {
      attack = false;
    }
    if (key == 'a' || key == 'A') {
      moveLeft = false;
      moveSwitch = 0;
    }
    if (key == 'd' || key == 'D') {
      moveRight = false;
      moveSwitch = 0;
    }
    if (key == 'w' || key == 'W') {
      up = false;
      upDownSwitch = 0;
      jumpCounter--;
    }
    if (key == 's' || key == 'S') {
      crouch = false;
      upDownSwitch = 0;
    }
  }
  //set attack
   void attack2(){
   fill(0);
   if (attack == true && moveLeft == true){
     fill(0,0,255);
     rect(position2.x - 10 ,position2.y + 10, -10,5);
   }
   if (attack == true && moveRight == true){
     fill(0,0,255);
     rect(position2.x + 10,position2.y + 10, 10,5);
   }
 }
  
  //when player 2 gets hit
  void getsHit(){
    hitFactor.x = hitAmount;
    //make hitFactor positive
    if (hitFactor.y < 0){
     hitFactor.y = hitAmount; 
    }
    //set where player 1 must attack from the right and make player 2 fall back
    if(player1.position1.x > position2.x 
       && dist(position2.x,position2.y, player1.position1.x, player1.position1.y) < 20 
       && player1.attack == true 
       && player1.moveLeft == true){
      health += 10;
      hitAmount++;
      velocity.sub(hitFactor);
    }
    //set where player 1 must attack from the left and make player 2 fall back
    if(player1.position1.x < position2.x 
       && dist(position2.x,position2.y, player1.position1.x, player1.position1.y) < 20
       && player1.attack == true 
       && player1.moveRight == true){
      health += 10;
      hitAmount++;
      hitFactor.y = hitAmount * -1;
      velocity.add(hitFactor);
    }
        println(hitFactor.y);

    
  }
  
  //movement
  void move() {
    velocity.add(gravity);
    velocity.mult(0.94);
    position2.add(velocity);
    // assign directions & speed
    switch(moveSwitch) {
      //make player go left
    case -1 :
      speed.add(speedAccel);
      position2.sub(speed);
      break;
      //make player go right
    case 1 :
      speed.add(speedAccel);
      position2.add(speed);
      break;
      //when no buttons are being pressed for left right
    case 0 :
      speed.x = 0;
      break;
    }

    switch(upDownSwitch) {
      //make player jump
    case -1 :
      timer = millis() - setTimer;
      if ( jumpCounter == 2 || jumpCounter == 1){
      if (timer > 0 && timer < 50) {
        velocity.add(jump);
      }
      }
      break;
    case 1 :

      break;
      //when no button is being pressed for up down
    case 0 :
      setTimer= millis();
      timer = 0;
      break;
    }

    //make platform for player to stand on
    if (position2.x > width/8-10 && position2.x < width * 7/8 && 
      position2.y > height * 3/4 - 40 && position2.y < height * 13/16) {
      position2.y = height * 3/4 - 40;
    }
    if (position2.x > width/8-10 && position2.x < width * 7/8 && 
      position2.y == height * 3/4 - 40) {
      speed.limit(3);
      jumpCounter = 2;
    }

    speed.limit(4);

    if (position2.x < -50 || position2.x > 1050 || position2.y < -50 || position2.y > 650) {
      lives--;
      position2.x = width/2;
      position2.y =width/4;
      health = 0;

    }
    //display life counter & game over
    textSize(20);
    text("lives "+lives, 40, 20);
    //display health %
    text(health+ "%", 40, 40);
    if (lives == 0) {
      textSize(30);
      fill (255, 0, 0);
      text("Player 1 Wins!", width/2, height/2);
      //stop player from moving after game over
      speed.limit(0);
      gravity.limit(0);
    }
  }
  
  void drawCharacter() {
    fill(0,0,255);
    // make character
    rect(position2.x - 10, position2.y, 20, 40);
    ellipse(position2.x ,position2.y - 10,20,20);  }
}
