class Player1 {

  //position
  PVector position1;
  //gravity
  PVector accel;
  PVector gravity;
  //speed switch
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

  Player1() {
    position1 = new PVector(width * 2/3, height/2);
    accel = new PVector(0, 0.1);
    gravity = new PVector(0, 0.3);
    speed = new PVector(0, 0);
    speedAccel = new PVector(0.3, 0);
    jump = new PVector(0, jumpFactor);
    velocity = new PVector(0,0);
    //set hit
    hitFactor = new PVector(hitAmount,hitAmount);
  }
  
  void pressed() {
    if (key == 'm' || key == 'M') {
      attack = true;
    }
    if (key == CODED) {
    }
    if (keyCode == LEFT) {
      moveLeft = true;
    }
    if (keyCode == RIGHT) {
      moveRight = true;
    }
    if (keyCode == UP) {
      up = true;
    }
    if (keyCode == DOWN) {
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

  void released() {
    if (key == 'm' || key == 'M') {
      attack = false;
    }
    if (key == CODED) {
    }
    if (keyCode == LEFT) {
      moveLeft = false;
      moveSwitch = 0;
    }
    if (keyCode == RIGHT) {
      moveRight = false;
      moveSwitch = 0;
    }
    if (keyCode == UP) {
      up = false;
      upDownSwitch = 0;
      jumpCounter--;
    }
    if (keyCode == DOWN) {
      crouch = false;
      upDownSwitch = 0;
    }
  }

 void attack1(){
   fill(0);
   if (attack == true && moveLeft == true){
     fill(0,255,0);
     rect(position1.x - 10 ,position1.y + 10, -10,5);
   }
   if (attack == true && moveRight == true){
     fill(0,255,0);
     rect(position1.x + 10,position1.y + 10, 10,5);
   }
 }
 
 void getsHit(){
    hitFactor.x = hitAmount;
    //make hitFactor positive
    if (hitFactor.y < 0){
     hitFactor.y = hitAmount; 
    }
    //set where player 2 must attack from the right and make player 1 fall back
    if(player2.position2.x > position1.x 
       && dist(position1.x,position1.y, player2.position2.x, player2.position2.y) < 20 
       && player2.attack == true 
       && player2.moveLeft == true){
      health += 10;
      hitAmount++;
      velocity.sub(hitFactor);
    }
    //set where player 2 must attack from the left and make player 1 fall back
    if(player2.position2.x < position1.x 
       && dist(position1.x,position1.y, player2.position2.x, player2.position2.y) < 20 
       && player2.attack == true 
       && player2.moveRight == true){
      health += 5;
      hitAmount++;
      hitFactor.y = hitAmount * -1;
      velocity.add(hitFactor);
    }  
  }

  //movement
  void move() {   
    velocity.add(gravity);
    velocity.mult(0.94);
    position1.add(velocity);
    // assign directions & speed
    switch(moveSwitch) {
    case -1 :
      speed.add(speedAccel);
      position1.sub(speed);
      break;
    case 1 :
      speed.add(speedAccel);
      position1.add(speed);
      break;
    case 0 :
      speed.x = 0;
      break;
    }

    switch(upDownSwitch) {
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
    case 0 :
      setTimer= millis();
      timer = 0;
      break;
    }
    println(timer);

    //make platform for player to stand on
    if (position1.x > width/8-10 && position1.x < width * 7/8 && 
      position1.y > height * 3/4 - 40 && position1.y < height * 13/16) {
      //gravity.limit(0);
      position1.y = height * 3/4 - 40;
    }
    if (position1.x > width/8-10 && position1.x < width * 7/8 && 
      position1.y == height * 3/4 - 40) {
      speed.limit(3);
      jumpCounter = 2;
    }

    speed.limit(4);

    if (position1.x < -50 || position1.x > 1050 || position1.y < -50 || position1.y > 650) {
      lives--;
      position1.x = width/2;
      position1.y =width/4;
      health = 0;

    }
    //display life counter & game over
    textSize(20);
    text("lives "+lives, 960, 20);
    //display health %
    text(health+ "%", 960, 40);
    if (lives == 0) {
      textSize(30);
      fill (255, 0, 0);
      text("Player 2 Wins!", width/2, height/2);
      //stop player from moving after game over
      speed.limit(0);
      gravity.limit(0);
    }
  }
  
  void drawCharacter() {
    fill(0,255,0);
    // make character
    rect(position1.x - 10, position1.y, 20, 40);
    ellipse(position1.x ,position1.y - 10,20,20);
  }
}
