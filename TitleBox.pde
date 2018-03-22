//very similar to widget class but allows more customisation of colours and exclusion of event variable
class TitleBox {
  int x, y, width, height;
  String myText; 
  color widgetColor, textColor;
  PFont widgetFont;
  color strokeColor;
  int xTextDistance, yTextDistance;
  
  TitleBox(int x,int y, int width, int height, int xTextDistance, int yTextDistance, color widgetColor, color strokeColor, color textColor, PFont widgetFont, String myText){
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.myText=myText;
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    this.xTextDistance=xTextDistance;
    this.yTextDistance=yTextDistance;
    this.strokeColor=strokeColor;
    this.textColor=textColor;
  }
  
  void draw(){
    stroke(strokeColor);
    fill(widgetColor);
    rect(x, y, width, height);
    fill(textColor);
    textFont(widgetFont);
    textSize(20);
    text(myText, x+xTextDistance, y+height-yTextDistance);
  }
}