class Screen {
  color backgroundColor;
  ArrayList <Widget> homescreenWidgets;
  int event;
  PImage backgroundImage;
  String type;

  Screen(color backgroundColor, ArrayList widgetList) {
    type = "colour";
    this.backgroundColor=backgroundColor;
    this.homescreenWidgets=widgetList;
  }
  
   Screen(PImage backgroundImage, ArrayList widgetList) {
    type = "image";
    this.backgroundImage=backgroundImage;
    backgroundImage.resize(SCREENX, SCREENY);
    this.homescreenWidgets=widgetList;
  }
  
  
  void draw() {
    if (type.equals("colour")){
    background(backgroundColor);
    }
    else {
      background(backgroundImage);
    }
    for (int i = 0; i<homescreenWidgets.size(); i++) {
      Widget aWidget = (Widget)homescreenWidgets.get(i);
      aWidget.draw();
    }
  }
  
  void addWidget(Widget w){
    homescreenWidgets.add(w);
  }
  
  
  Widget getWidget(int index){
    return homescreenWidgets.get(index);
  }
  
   int getEvent(int mouseX, int mouseY){
      for(int i=0; i<homescreenWidgets.size();i++){
       if(mouseX>homescreenWidgets.get(i).x && mouseX < homescreenWidgets.get(i).x+homescreenWidgets.get(i).width && mouseY >homescreenWidgets.get(i).y && mouseY <homescreenWidgets.get(i).y+homescreenWidgets.get(i).height){
         return homescreenWidgets.get(i).event;
     }
      }
     return EVENT_NULL;
  }
}