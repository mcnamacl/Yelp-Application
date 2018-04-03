// A base class for the screen - Kamil
class Screen {
  color backgroundColor;
  ArrayList <Widget> screenWidgets;
  int event;
  PImage backgroundImage;
  String type;

  Screen(color backgroundColor, ArrayList widgetList) {
    type = "colour";
    this.backgroundColor=backgroundColor;
    this.screenWidgets=widgetList;
  }
  
   Screen(PImage backgroundImage, ArrayList widgetList) {
    type = "image";
    this.backgroundImage=backgroundImage;
    backgroundImage.resize(SCREENX, SCREENY);
    this.screenWidgets=widgetList;
  }
  
  
  void draw() {
    if (type.equals("colour")){
    background(backgroundColor);
    }
    else {
      background(backgroundImage);
    }
  }
  
  void drawWidgets(){
    for (int i = 0; i<screenWidgets.size(); i++) {
      Widget aWidget = (Widget)screenWidgets.get(i);
      aWidget.draw();
    }
  }
  
  void addWidget(Widget w){
    screenWidgets.add(w);
  }
  
  
  Widget getWidget(int index){
    return screenWidgets.get(index);
  }
  
  int getEvent(int mouseX, int mouseY){
      for(int i=0; i<screenWidgets.size();i++){
       if(mouseX>screenWidgets.get(i).x && mouseX < screenWidgets.get(i).x+screenWidgets.get(i).width && mouseY >screenWidgets.get(i).y && mouseY <screenWidgets.get(i).y+screenWidgets.get(i).height){
         return screenWidgets.get(i).event;
     }
      }
     return EVENT_NULL;
  }
  
  // checks if mouse hovers over a widget
  boolean hover(int mouseX, int mouseY){
      for(int i=0; i<screenWidgets.size();i++){
       if(mouseX>screenWidgets.get(i).x && mouseX < screenWidgets.get(i).x+screenWidgets.get(i).width && mouseY >screenWidgets.get(i).y && mouseY <screenWidgets.get(i).y+screenWidgets.get(i).height){
         return screenWidgets.get(i).hover;
     }
      }
     return false;
  }
}