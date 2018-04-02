// A radio button class which is an extension of the main widget class - Kamil
class RadioButton extends Widget {
  int x, y, width, height;
  String label; 
  int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  color strokeColor;
  int xTextDistance,yTextDistance;

   RadioButton(int x,int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event,int xTextDistance,int yTextDistance){
    super(x,y,width,height,label,widgetColor,widgetFont,event, xTextDistance, yTextDistance);
      this.x=x; 
      this.y=y; 
      this.width = width; 
      this.height= height;
      this.label=label; 
      this.event=event; 
      this.widgetColor=widgetColor; 
      this.widgetFont=widgetFont;
      labelColor= color(0);
      this.xTextDistance=xTextDistance;
      this.yTextDistance=yTextDistance;
   }
   
   int getY(){
     return this.y;
   }
   
  int getEvent(int mouseX, int mouseY){
     if(mouseX>x && mouseX < x+width && mouseY >y && mouseY <y+height){
       println("radiobox ticked");
       return event;       
     }
     return EVENT_NULL;
  }
}