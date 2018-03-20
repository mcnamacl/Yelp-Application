class Widget {
  int x, y, width, height;
  String myText; 
  int event;
  color widgetColor, myTextColor;
  PFont widgetFont;
  PImage logoImage;
  color strokeColor;
  int xTextDistance,yTextDistance;
  boolean isClickableText = false;

  Widget(int x,int y, int width, int height, String myText, color widgetColor, PFont widgetFont, int event,int xTextDistance,int yTextDistance){
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.myText=myText; 
    this.event=event; 
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    this.xTextDistance=xTextDistance;
    this.yTextDistance=yTextDistance;
    myTextColor= color(0);
   }
   
   Widget(int x, int y, int width, int height, PImage logoImage, int event){
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.logoImage= logoImage; 
    this.event=event; 
   }
   
   //constuctor for clickable text
   Widget(int x,int y, int width, int height, String myText, color widgetColor, PFont widgetFont, int event,int xTextDistance,int yTextDistance,boolean isClickableText){
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.myText=myText; 
    this.event=event; 
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    this.xTextDistance=xTextDistance;
    this.yTextDistance=yTextDistance;
    this.isClickableText=isClickableText;
    myTextColor= color(0);
   }
   
  void draw(){
    setStroke(mouseX,mouseY);
    fill(widgetColor);
    if (isClickableText){
      myTextColor=strokeColor;
      noStroke();
    }
    else stroke(strokeColor);
    rect(x,y,width,height);
    fill(myTextColor);
    textFont(widgetFont);
    textSize(20);
    text(myText, x+xTextDistance, y+height-yTextDistance);
  }
  
  void drawImage(){
    image(logoImage,x,y);
  }
  
  int setStroke(int mouseX, int mouseY){
    strokeColor=(200);
    strokeWeight(2);
    if(mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height){
        strokeColor=(HIGHLIGHT);
        return strokeColor;
     }
     return strokeColor;
  }
  
  int getEvent(int mouseX, int mouseY){
     if(mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height){
       return event;
     }
     return EVENT_NULL;
  }
  
  String returnString(){
    return searchbox.myText;
  } 
}