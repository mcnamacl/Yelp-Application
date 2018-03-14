class Widget {
  int x, y, width, height;
  String myText; 
  int event;
  color widgetColor, myTextColor;
  PFont widgetFont;
  PImage logoImage;
  color strokeColor;
  int xTextDistance,yTextDistance;

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
   
  void draw(){
    fill(widgetColor);
    stroke(strokeColor);
    rect(x,y,width,height);
    fill(myTextColor);
    textFont(widgetFont);
    text(myText, x+xTextDistance, y+height-yTextDistance);
  }
  
  void drawImage(){
    image(logoImage,x,y);
  }
  
  int setStroke(int mouseX, int mouseY){
    strokeColor=(150);
    strokeWeight(2);
    if(mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height){
        strokeColor=(0);
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