class Widget {
  int x, y, width, height;
  String myText; 
  int event;
  color widgetColor, myTextColor;
  PFont widgetFont;
  color strokeColor;

  Widget(int x,int y, int width, int height, String myText, color widgetColor, PFont widgetFont, int event){
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.myText=myText; 
    this.event=event; 
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    myTextColor= color(0);
   }
   
  void draw(){
    fill(widgetColor);
    stroke(strokeColor);
    rect(x,y,width,height);
    fill(myTextColor);
    text(myText, x+10, y+height-10);
    
  }
  
  int setStroke(int mouseX, int mouseY){
    strokeColor=(0);
    if(mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height){
        strokeColor=(255);
        return strokeColor;
     }
     return strokeColor;
  }
  
  int getEvent(int mouseX, int mouseY){
     if(mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height){
       //println("get event"); 
       return event;
     }
     return EVENT_NULL;
  }
  
}