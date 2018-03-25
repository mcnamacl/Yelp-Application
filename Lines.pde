class Line{
  
  float x, y, prevX, prevY, totalX, totalY, destX, destY;
   
  public Line(float x, float y, float prevX, float prevY){
    //destX = x;
    //destY = y;
    this.x = x;
    this.y = y;
    this.prevX = prevX;
    this.prevY = prevY;
    totalX = (x - prevX)/10;
    totalY = (y -prevY)/10;
  }  
  
  void drawLines(){
    stroke(255);
    //if (x!=destX&&y!=destY){
    //  x = x + totalX;
    //  y = y + totalY;
    //}
    line(prevX, prevY, x, y);
    noStroke();
  } 
}