class Screen {
  color backgroundColor;
  ArrayList <Widget> widgetList;
  int event;

  Screen(color backgroundColor, ArrayList widgetList) {
    this.backgroundColor=backgroundColor;
    this.widgetList=widgetList;
  }
  
  void draw() {
    background(backgroundColor);
    for (int i = 0; i<widgetList.size(); i++) {
      Widget aWidget = (Widget)widgetList.get(i);
      aWidget.draw();
    }
  }
  
  void addWidget(Widget w){
    widgetList.add(w);
  }
  
  
  Widget getWidget(int index){
    return widgetList.get(index);
  }
  
   int getEvent(int mouseX, int mouseY){
      for(int i=0; i<widgetList.size();i++){
        //widgetList.get(i).getEvent(mouseX,mouseY);
       if(mouseX>widgetList.get(i).x && mouseX < widgetList.get(i).x+widgetList.get(i).width && mouseY >widgetList.get(i).y && mouseY <widgetList.get(i).y+widgetList.get(i).height){
          //println("forward/backward");
         return widgetList.get(i).event;
     }
      }
     return EVENT_NULL;
  }
}