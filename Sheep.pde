class Sheep  {
  
  //variables
  int x;
  int y;
  
  int w;
  int h;
  
  int xSpeed;
  int ySpeed;
  
    //hitbox 
  int left;
  int right;
  int top;
  int bottom;
  
  //directions
  boolean isMovingLeft;
  boolean isMovingRight;
  
  boolean isMovingUp;
  boolean isMovingDown;
  
//count variable
int count;
  
//direction booleans
int d;
int scary;
//wall collision
boolean hitWall;
//disapear when in pen
boolean isRendered=true;
  
  //constructor
  Sheep(int startingX, int startingY){
    x=startingX;
    y=startingY;
    
    xSpeed=3;
    ySpeed=3;
    
    w=40;
    h=30;
  }
  
  //functions
  //draws sheep
  void render(){  
    rectMode(CENTER);
if(isRendered==true){
  if(isMovingRight==true){
  sheepRAnimation.display(x,y);
  }
  else{
  sheepLAnimation.display(x,y);
  }    
}
  }
  //moves sheep
void move(){
   //change sheep direction
changeDirection();
 //changes position
 x+=xSpeed;
 y+=ySpeed;
 //animation direction
 if(isMovingRight == true){
      sheepRAnimation.isAnimating=true; 
}
if(isMovingLeft == true){
      sheepLAnimation.isAnimating=true; 
}
 //if scared 
 if(scared==true){ 
   runAway();
 }

  //hitbox
    left=x-w/2;
    right=x+w/2;
    top=y-h/2;
    bottom=y+h/2;
    sheepWindowCollision();
}
//state machine for directions
void changeDirection(){
 
if(currentTime-startTime>=interval && scared == false){ 
  d=int(random(4));
  switch(d){
    case 0://right
    xSpeed =3;
    ySpeed =0;
    isMovingRight=true;
    isMovingLeft=false;
    break;
    case 1://left
    xSpeed =-3;
    ySpeed =0;
    isMovingRight=false;
    isMovingLeft=true;
    break;
    case 2://down
    xSpeed =0;
    ySpeed =2;
    isMovingDown=true;
    isMovingUp=false;
    break;
    case 3://up
    xSpeed =0;
    ySpeed =-3; 
    isMovingDown=false;
    isMovingUp=true;
    break;
}
startTime=millis();
}
}
//state machine for running away, mostly done, dont know why up and down dont work
void runAway(){

//asked chat gpt what was wrong with the run away and scary functions. Determined that using "else if" was the issue.
  //check direction to move
  if(abs(d1.x-x)>abs(d1.y-y)){
  if(d1.x<x){
    scary=0;//right
  }
  else{
    scary=1;//left
  }
  }
  else{
    if(d1.y<y){
    scary=2;//down
  }
  else{
    scary=3;//up
  }
}
  switch(scary){
    case 0://right
    xSpeed =3;
    ySpeed =0;
    break;
    case 1://left
    xSpeed =-3;
    ySpeed =0;
    break;
    case 2://down
    xSpeed =0;
    ySpeed =3;
    break;
    case 3://up
    xSpeed =0;
    ySpeed =-3;  
    break;
}
}
//checks if sheep collides with window
void sheepWindowCollision() {
  //left side hits
   if(left<0){
     x=w/2;
     hitWall=true;
      }
      //right side hits
    if(right>width){
        x = width - w/2;
        hitWall=true;
      }
      //top side hits
    if(top<0){
          y = h/2;
          hitWall=true;
       }
     //bottom side hits
       if(bottom>height){     
          y = height - h/2;
          hitWall=true;
       }
if (hitWall && scared == false){
  changeDirection();
}

}

void inPen(){
  if(x<width/5-width/50){
   isRendered=false;
   
  }
}
void countSheep(){
  count =0;
  if (isRendered==false){
    count++;
    state=2;
  }
}
}
