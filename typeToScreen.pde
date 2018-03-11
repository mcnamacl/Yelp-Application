class typeToScreen {
  String myText = "Search...";
  Screen screen1, screen2, currentScreen;
  boolean canType=false;
  Widget widget1;


  typeToScreen(Widget widget) {
    textSize(30);
    this.widget1 = widget;
  }
  void getEvent() {
    if (mousePressed) {
      mousePressed();
    }
    if (canType) {
      keyPressed();
    }
  }


  void keyPressed() {
    println(widget1.myText);
    if (keyCode == BACKSPACE) {
      if (widget1.myText.length() > 0) {
        widget1.myText = widget1.myText.substring(0, widget1.myText.length()-1);
        println(myText.length());
      }
    } else if (keyCode == DELETE) {
      widget1.myText = "";
    } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
      widget1.myText =widget1.myText + key;
    }
  }

  void mousePressed() {
    int event;
    event = widget1.getEvent(mouseX, mouseY);
    if (event != EVENT_NULL) {
      switch(event) {
      case EVENT_BUTTON1:
        widget1.myText="";
        canType=true;
        break;
      }
    }
  }
}