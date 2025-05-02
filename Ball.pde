//this code is mostly from the array lists class

class Ball { 
  //variables 
  int x;
  int y;
  int d;
  color fillColor;

  int xSpeed;
  int ySpeed;
  
     //hitbox 
  int left;
  int right;
  int top;
  int bottom;

//picked up boolean
boolean pickedUp;

//count variable
int count=0;


  //constructor
  Ball(int startingX) {
    int speed = 4;
//might adjust speeds
    xSpeed = 4;
    ySpeed = 3;

    if (xSpeed == 0) {
      xSpeed = speed;
    }
    if (ySpeed == 0) {
      ySpeed = speed;
    }

//start location
    x=startingX;
    y = height/2;
    d = 20;
    fillColor = color(255,0,0);
  }

  void render() {
    if(pickedUp==false){
    fill(fillColor);
    circle(x, y, d);
    }
  }

  /*
This function updates the position the ball according to its speed.
   */
  void move() {
    x += xSpeed;
    y += ySpeed;

        //hitbox
    left=x-d/2;
    right=x+d/2;
    top=y-d/2;
    bottom=y+d/2;
  }

  /*
This function checks if the ball is touching an edge. If it is, the speed flips
   */
  void wallDetect() {
    // wall detection for the right wall
    if (x+d/2 >= width) {
      xSpeed = -abs(xSpeed);
    }
    // wall detection for left wall
    if (x-d/2 <= 0) {
      xSpeed = abs(xSpeed);
    }

    // wall detection for the bottom wall
    if (y+d/2 >= height) {
      ySpeed = -abs(ySpeed);
    }
    // wall detection for top wall
    if (y-d/2 <= 0) {
      ySpeed = abs(ySpeed);
    }
  }
  //this function checks if the player collides with the ball
void playerCollide(Dog aDog){
   //left
   if(aDog.top<= bottom &&
      aDog.bottom>=top&&
      aDog.right>left &&
      aDog.left <= left){
        pickedUp=true;
      }
      //right
    if(aDog.top<= bottom &&
      aDog.bottom>=top&&
      aDog.left<right &&
      aDog.right >= right){
         pickedUp=true;
      }
      //top
    if(aDog.left<= right &&
       aDog.right>=left &&
       aDog.bottom>top &&
       aDog.top<= top){
         pickedUp=true;
       }
     //bottom
       if(aDog.left<= right &&
       aDog.right>=left &&
       aDog.top<bottom &&
       aDog.bottom>= bottom){
         pickedUp=true;
       }
  }

  
}
