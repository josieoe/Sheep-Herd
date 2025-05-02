class Stick  {
  
  //variables
  float x;
  float y;
  
  float w;
  float h;
  
    //hitbox 
  float left;
  float right;
  float top;
  float bottom;
  
//picked up boolean
  boolean pickedUp;


  
  //constructor
  Stick(){
    x=random(100,width-100);
    y=random(100,height-100);
    
    w=10;
    h=15;
  }
  
  //functions
  //draws stick
  void render(){
    if(pickedUp==false){
    stick0=loadImage("stick0.png");
  stick0.resize(40,60);  
  image(stick0,x,y);
    }
//hitbox
    left=x-w/2;
    right=x+w/2;
    top=y-h/2;
    bottom=y+h/2;

  }
  //checks when player collides with stick
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
