class Obstacle {
  
  //variables
  int x;
  int y;
  int w;
  int h;
  
  //hitbox
  int left;
  int right;
  int top;
  int bottom;
  
  //constructor
  Obstacle(int oX, int oY, int oW, int oH){
    x=oX;
    y=oY;
    w=oW;
    h=oH;
    
    left=x-w/2;
    right=x+w/2;
    top=y-h/2;
    bottom=y+h/2;
  }
  //draws obstacle
  void render(){
    noFill();
    noStroke();
    rect(x,y,w,h);
    
  }
   //this function checks if the player collides with the obstacle
  void playerCollide(Dog aDog){
   //left
   if(aDog.top<= bottom &&
      aDog.bottom>=top&&
      aDog.right>left &&
      aDog.left <= left){
        aDog.isMovingRight = false;
        aDog.x = left - aDog.w/2;
      }
      //right
    if(aDog.top<= bottom &&
      aDog.bottom>=top&&
      aDog.left<right &&
      aDog.right >= right){
        aDog.isMovingLeft =false;
        aDog.x = right + aDog.w/2;
      }
      //top
    if(aDog.left<= right &&
       aDog.right>=left &&
       aDog.bottom>top &&
       aDog.top<= top){
          aDog.isMovingDown =false;
          aDog.y = top - aDog.h/2;
       }
     //bottom
       if(aDog.left<= right &&
       aDog.right>=left &&
       aDog.top<bottom &&
       aDog.bottom>= bottom){
          aDog.isMovingUp =false;
          aDog.y = bottom + aDog.h/2;
       }
  }
//this function checks if the sheep collides with the obstacle   
  void sheepCollide(Sheep aSheep){
   //left
   if(aSheep.top<= bottom &&
      aSheep.bottom>=top&&
      aSheep.right>left &&
      aSheep.left <= left){
        aSheep.xSpeed*=+1;
      }
      //right
    if(aSheep.top<= bottom &&
      aSheep.bottom>=top&&
      aSheep.left<right &&
      aSheep.right >= right){
        aSheep.xSpeed*=-1;
      }
      //top
    if(aSheep.left<= right &&
       aSheep.right>=left &&
       aSheep.bottom>top &&
       aSheep.top<= top){
          aSheep.ySpeed*=1;
       }
     //bottom
       if(aSheep.left<= right &&
       aSheep.right>=left &&
       aSheep.top<bottom &&
       aSheep.bottom>= bottom){
          aSheep.ySpeed*=-1;
       }
  }  
 
  
  
}
