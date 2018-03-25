class Chart{
  
  float topX, topY, x, y, leftX, leftY;
  
  Chart(float topX, float topY, float x, float y, float leftX, float leftY) {
    this.topX = topX;
    this.topY = topY;
    this.x = x;
    this.y = y;
    this.leftX = leftX;
    this.leftY = leftY;
  }
  
  void drawChart(){
    line(topX, topY, x, y);
    line(leftX, leftY, x, y);   
  } 
}