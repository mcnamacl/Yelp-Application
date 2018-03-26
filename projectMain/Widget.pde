class Widget {
  int x, y, width, height;
  String myText; 
  int event;
  color widgetColor, myTextColor;
  PFont widgetFont;
  PImage logoImage;
  color strokeColor;
  int xTextDistance, yTextDistance;
  boolean isClickableText = false;
  boolean eventHappening = false;
  boolean hover = false;

  Widget(int x, int y, int width, int height, String myText, color widgetColor, PFont widgetFont, int event, int xTextDistance, int yTextDistance) {
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

  Widget(int x, int y, int width, int height, PImage logoImage, int event) {
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.logoImage= logoImage; 
    this.event=event;
  }

  //constuctor for clickable text
  Widget(int x, int y, int width, int height, String myText, color widgetColor, PFont widgetFont, int event, int xTextDistance, int yTextDistance, boolean isClickableText) {
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
  }
  
  //constuctor for a leaderboard rung
   Widget(int x, int y, int width, int height, String myText, color widgetColor,color strokeColor, PFont widgetFont, int event, int xTextDistance, int yTextDistance) {
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
    this.strokeColor=strokeColor;
  }

  void drawLeaderboardRung(){
    fill(widgetColor);
    stroke(strokeColor);
    strokeWeight(1);
    rect(x,y,width,height);
    setTextColor(mouseX,mouseY);
    fill(myTextColor);
    textSize(20);
    text(myText, x+xTextDistance, y+height-yTextDistance);
    
  }

  void draw() {
    setStroke(mouseX, mouseY);
    fill(widgetColor);
    if (isClickableText) {
      myTextColor=strokeColor;
      noStroke();
    } else stroke(strokeColor);
    rect(x, y, width, height);
    fill(myTextColor);
    textFont(widgetFont);
    textSize(20);
    text(myText, x+xTextDistance, y+height-yTextDistance);
  }

  void drawImage() {
    image(logoImage, x, y);
  }

  int setStroke(int mouseX, int mouseY) {
    strokeColor=(200);
    strokeWeight(2);
    if (mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height) {
      strokeColor=(HIGHLIGHT);
      hover = true;
      return strokeColor;
    }
    return strokeColor;
  }
  
  int setTextColor(int mouseX, int mouseY) {
    myTextColor = color(255);
    if (mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height) {
      myTextColor=(HIGHLIGHT);
      hover = true;
      return myTextColor;
    }
    return myTextColor;
  }

  int getEvent(int mouseX, int mouseY) {
    if (mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height) {
      return event;
    }
    return EVENT_NULL;
  }

  String returnString() {
    return searchbox.myText;
  } 
  
  void setSearchboxColor(color x){
    searchbox.widgetColor=x;
  }
}