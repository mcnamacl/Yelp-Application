class Screen {
  color backgroundColor;
  ArrayList <Widget> homescreenWidgets;
  int event;

  Screen(color backgroundColor, ArrayList widgetList) {
    this.backgroundColor=backgroundColor;
    this.homescreenWidgets=widgetList;
  }
  
  void draw() {
    background(backgroundColor);
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