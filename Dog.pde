class Dog  {
  
  //variables
  int x;
  int y;
  
  int w;
  int h;
  
  int speed;
  //booleans
    
  boolean isMovingLeft;
  boolean isMovingRight;
  
  boolean isMovingUp;
  boolean isMovingDown;
  
  boolean isFacingLeft;
  boolean isFacingRight;
  
  boolean isFacingUp;
  boolean isFacingDown;
  
    //hitbox 
  int left;
  int right;
  int top;
  int bottom;
  
  //constructor
  Dog(int startingX, int startingY, int startingW, int startingH){
    x=startingX;
    y=startingY;
    w=startingW;
    h=startingH;
    
    isMovingLeft = false;
    isMovingRight = false;
    isMovingUp = false;
    isMovingDown = false;
    
    isFacingLeft = false;
    isFacingRight = false;
    isFacingUp = false;
    isFacingDown = false;
    
    speed =10;
  }
  
  //functions
  //draws dog
  void render(){ 
  if(isMovingRight==true){
  dogRAnimation.display(x,y);
  }
  else{
     dogLAnimation.display(x,y);
  }
  }
  //moves dog
void move(){
if(isMovingRight == true){
      dogRAnimation.isAnimating=true; 
}
if(isMovingLeft == true){
      dogLAnimation.isAnimating=true; 
}
  
  //hitbox
    left=x-w/2;
    right=x+w/2;
    top=y-h/2;
    bottom=y+h/2;
    
  if(isMovingLeft == true){
    isFacingLeft=true;
    isFacingRight=false;
    x-=speed; 
  }
    if(isMovingRight == true){
      isFacingRight=true;
      isFacingLeft=false;
    x+=speed;   
  } 
    if(isMovingUp == true){
      isFacingUp=true;
      isFacingDown=false;
    y-=speed;  
  } 
    if(isMovingDown == true){
    isFacingDown=true;
    isFacingUp=false;
    y+=speed;  
  } 
}

void wallCollide(){
   //left side hits
   if(left<0){
     isMovingLeft=false;
     x=w/2;
      }
      //right side hits
    if(right>width){
        x = width - w/2;
        isMovingRight=false;
      }
      //top side hits
    if(top<0){
          isMovingUp =false;
          y = h/2;
       }
     //bottom side hits
       if(bottom>height){
          isMovingDown =false;
          y = height - h/2;
       }

}
}
