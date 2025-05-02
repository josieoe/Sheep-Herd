////////////////////////////////////////////////////////////////////////////////////sounds
  import processing.sound.*;
//dog bark when space pressed
  SoundFile bark2;
//Background music
  SoundFile background;
/////////////////////////////////////////////////////////////////////////////////global variables
//background changes with state
  color backgroundColor;
//animations
  Animation startScreenAnimation;
  Animation dogRAnimation;
  Animation dogLAnimation;
  Animation sheepRAnimation;
  Animation sheepLAnimation;
  
//images
//background
PImage stickBack;
PImage ballBack;
PImage stick0;
PImage stick1;
PImage finalScreen;
PImage [] startScreenImages= new PImage [3];
PImage sheepHearding;
//dog sheep and stick
PImage [] dogRImages= new PImage [3];
PImage [] dogLImages= new PImage [3];

PImage [] sheepRImages= new PImage [2];
PImage [] sheepLImages= new PImage [2];

//Class variables
  Dog d1;
  
  Sheep s1;
 // Sheep s2;
 // Sheep s3;
  
  
  Stick st1;
  Stick st2;
  Stick st3;
  Stick st4;
  Stick st5;
  Stick st6;
  Stick st7;
  Stick st8;
  //enemy lists
  ArrayList<Sheep> sheepList;
  ArrayList<Stick> stickList;
  ArrayList<Ball> ballList;
  Ball b1;
  Ball b2;
  Ball b3;
//state variable
  int state;


//Obstacles
  //pasture
    Obstacle o1;
    Obstacle o2;

/////////////////////////////////////////////////////////////////////////////////millis timer var
  int startTime;
  int currentTime;
  int interval=2000;
  //sheep direction change boolean
  boolean scared;
  
  //game score
  int gameStartTime;
  int gameEndTime;
  int gameCurrentTime;
  boolean timerRunning;

void setup(){
  size(1600,1000);
  //initial background color and state
  backgroundColor=color(#41901A);
  state=0;
  rectMode(CENTER);
   startTime=millis();
  
///////////////////////////////////////////////////////////////////////////////////////////initialize all variables
  d1 = new Dog(width/2,height/2,100,100);
  //enemy list
 sheepList =new ArrayList<Sheep>();
 stickList = new ArrayList<Stick>();
 ballList = new ArrayList<Ball>();
 
  s1 = new Sheep(width/2,2*height/3);
 // s2 = new Sheep(width/3,2*height/5);
 // s3 = new Sheep(width/4,height/3);
  sheepList.add(s1);
 // sheepList.add(s2);
 // sheepList.add(s3);
  
  st1 =new Stick();
  st2 =new Stick();
  st3 =new Stick();
  st4 =new Stick();
  st5 =new Stick();
  st6 =new Stick();
  st7 =new Stick();
  st8 =new Stick();
  
  stickList.add(st1);
  stickList.add(st2);
  stickList.add(st3);
  stickList.add(st4);
  stickList.add(st5);
  stickList.add(st6);
  stickList.add(st7);
  stickList.add(st8);
  
  b1 = new Ball(width/3);
  b2 = new Ball(width/4);
  b3 = new Ball(3*width/5);
  ballList.add(b1);
  ballList.add(b2);
  ballList.add(b3);
  
  o1 = new Obstacle(width/5-20,height/5-40,width/40,2*height/6);
  o2 = new Obstacle(width/5-20,4*height/5,width/40,2*height/4);
  
  
  //barking and background music noises
  bark2 = new SoundFile(this, "bark2.wav");
  background = new SoundFile(this, "background.wav");
  
  //background images
    for (int i=0; i<startScreenImages.length;i++){
   startScreenImages[i]= loadImage("start"+i+".png"); 
  }
  //dog animation
      for (int i=0; i<dogLImages.length;i++){
   dogLImages[i]= loadImage("dogL"+i+".png"); 
  }
      for (int i=0; i<dogRImages.length;i++){
   dogRImages[i]= loadImage("dogR"+i+".png"); 
  }
  //sheep animation
        for (int i=0; i<sheepLImages.length;i++){
   sheepLImages[i]= loadImage("sheepL"+i+".png"); 
  }
      for (int i=0; i<sheepRImages.length;i++){
   sheepRImages[i]= loadImage("sheepR"+i+".png"); 
  }
   

  //animation
  startScreenAnimation =new Animation(startScreenImages, 0.3,2.0);
  dogRAnimation =new Animation(dogRImages, 0.4,1.0);
  dogLAnimation =new Animation(dogLImages, 0.4,1.0);
  sheepRAnimation =new Animation(sheepRImages, 0.3,0.6);
  sheepLAnimation =new Animation(sheepLImages, 0.3,0.6);
  
}

//////////////////////////////////////////////////////////////////////////////////////////////////////draw
void draw(){
  background(backgroundColor);
  //change states
  levelHandler();
  fill(0);

}
void levelHandler(){
//////////////////////////////////////////////////////////////////////////////////////////////////my finite state machine
switch (state){
  //first level (sheep herding grass background)
  case 0 :
  backgroundColor =color(#15A21B);
  startScreenAnimation.display(width/2,height/2);
  startScreenAnimation.isAnimating=true;
  break;
  case 1 :
    backgroundColor= color(#5ECE3C);
  //originally had if timer running is false do this, i copied the if statement into chat gpt and asked why game end time was always zero. It suggested the exclaimation point
  //we never learned the exclaimation point from what i remember beside it meaning not
  if(timerRunning==false){
    gameStartTime=millis();
    timerRunning=true;
  }
  //I copied and pasted the if statement, asking how to display a changing timer and chat gpt helped me add the "seconds" into the text.
  if(timerRunning){
    int seconds=(millis()-gameStartTime)/1000;
    fill(255);
    textSize(30);
    text("Time:"+seconds+"s",50,50);
  }

   //sheep hearding level
sheepHearding=loadImage("sheepHeard0.png");
  sheepHearding.resize(1600,1000);
  background(sheepHearding);
  fill(255);
    //draw and move dog
  d1.render();
  d1.move(); 
  d1.wallCollide();
  //draw sheep, detect window collisions and figure out what direction the sheep is going
  for(Sheep aSheep : sheepList){
  aSheep.move();
  aSheep.render();
  aSheep.inPen();
  aSheep.countSheep();
  if(aSheep.count == 3){
     state=1;
   }
  println(aSheep.count);
  }
  
 //fence
 //this will change in shape later as a pen to herd sheep into
 fill(#BC8F4C);
  o1.render();
  o1.playerCollide(d1);
  o1.sheepCollide(s1);
 // o1.sheepCollide(s2);
  //o1.sheepCollide(s3);
  o2.render();
  o2.playerCollide(d1);
  o2.sheepCollide(s1);
 // o2.sheepCollide(s2);
  //o2.sheepCollide(s3);
    break;
      
 //level 2( stick picking dirt ground)
  case 2:
//draw color move and collide with ball, also detect when ball hits walls
  backgroundColor =color(#1FB42A);
  stickBack=loadImage("stickBack.png");
  stickBack.resize(1600,1000);
  background(stickBack);
  
  //draw color and collide with stick
    for(Stick aStick : stickList){
     aStick.render(); 
     aStick.playerCollide(d1); 
   }
    if(timerRunning){
    int seconds=(millis()-gameStartTime)/1000;
    fill(255);
    textSize(30);
    text("Time:"+seconds+"s",50,50);
  }
//draw and move dog
  d1.render();
  d1.move(); 
  d1.wallCollide();

 boolean allSticksCollected=true;
 for(Stick aStick: stickList){
   if(aStick.pickedUp == false){
     allSticksCollected=false;
   }
 }
 
 if(allSticksCollected == true){
   println("picked up");
   state=3;
 }
 
    break;
//level 3(ball catching grass background)
  case 3:
    ballBack=loadImage("ballBack.png");
  ballBack.resize(1600,1000);
  background(ballBack);
  //draw and move dog
  d1.render();
  d1.move(); 
  d1.wallCollide();
  if(timerRunning){
    int seconds=(millis()-gameStartTime)/1000;
    fill(255);
    textSize(30);
    text("Time:"+seconds+"s",50,50);
  }
  
for(Ball aBall : ballList){
  aBall.render();
  aBall.move();
  aBall.wallDetect();
  aBall.playerCollide(d1);
}
 boolean allBallsCollected=true;
 for(Ball aBall: ballList){
   if(aBall.pickedUp == false){
     allBallsCollected=false;
   }
 }
 
 if(allBallsCollected == true){
   println("picked up");
   state=4;
 }
  break;
  
  case 4:
  //winscreen
  backgroundColor =color(#21B44E);
  finalScreen=loadImage("finalScreen.png");
  finalScreen.resize(1600,1000);
  background(finalScreen);
  if(timerRunning){
    gameEndTime =millis();
    gameCurrentTime=gameEndTime-gameStartTime;
    timerRunning =false;
  }
  fill(255);
  textSize(40);
  text("Time:"+(gameCurrentTime/1000)+"s", width/2-100,height/2+60);
  break;
  }
    //background music repeat
    if (background.isPlaying() == false){
  background.play();        
}
  
  
  
}

void keyPressed(){
 ///////////////////////////change levels
  //lvl 1
if(key=='r' && state == 4){
    state=0;
  }
  //lvl 2
if(key==' '&& state == 0){
    state=1;
  }

/////////////////////////////////////////////////////////////wasd
if(key == 'a'){
    d1.isMovingLeft =true;
  }
if(key == 'd'){
    d1.isMovingRight =true;
  }
if(key == 'w'){
    d1.isMovingUp =true;
  }
if(key == 's'){
    d1.isMovingDown =true;
} 
if(keyCode == LEFT){
    d1.isMovingLeft =true;
  }
if(keyCode == RIGHT){
    d1.isMovingRight =true;
  }
if(keyCode == UP){
    d1.isMovingUp =true;
  }
if(keyCode == DOWN){
    d1.isMovingDown =true;
} 
//sheep redirect
  if(key ==' '){
   scared=true;
  }
  
  //bark when spacebar is pressed
  if(key == ' '){
    bark2.play();
  }
}

void keyReleased(){
  //wasd
    if(key == 'a'){
    d1.isMovingLeft =false;
  }
    if(key == 'd'){
    d1.isMovingRight =false;
  } 
      if(key == 'w'){
    d1.isMovingUp =false;
  }
    if(key == 's'){
    d1.isMovingDown =false;
  } 
  if(keyCode == LEFT){
    d1.isMovingLeft =false;
  }
if(keyCode == RIGHT){
    d1.isMovingRight =false;
  }
if(keyCode == UP){
    d1.isMovingUp =false;
  }
if(keyCode == DOWN){
    d1.isMovingDown =false;
} 
//sheep redirect release
  if(key ==' '){
   scared=false;
  }
}
