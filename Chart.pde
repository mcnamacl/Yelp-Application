//class that deals with drawing the axis for a graph - Claire
class Chart {
  
  float topX, topY, x, y, rightX, rightY;
  
  Chart(float topX, float topY, float x, float y, float rightX, float rightY) {
    this.topX = topX;
    this.topY = topY;
    this.x = x;
    this.y = y;
    this.rightX = rightX;
    this.rightY = rightY;
  }
  
  void drawChart(){
    line(topX, topY, x, y);
    line(rightX, rightY, x, y);   
  } 
}