//makes bubbles rise on the screen - Claire
class Bubble{
  
  int bubbleX, bubbleY, diameter, tmpBubbleY, waitTime;
  color bubbleColour;
  String fact;
  
  Bubble(int bubbleX, int bubbleY, int diameter, color bubbleColour, String fact, int waitTime){
    this.bubbleX = bubbleX;
    this.bubbleY = bubbleY;
    this.diameter = diameter;
    this.bubbleColour = bubbleColour;
    this.fact = fact;
    this.waitTime = waitTime;
    tmpBubbleY = SCREENY;
  }
  
  //function that draws bubbles and their facts rising up the screen 
  void drawBubblesRising(){
    if (waitTime < 0){
    if (tmpBubbleY != bubbleY) {
      tmpBubbleY--;
    }
    fill(bubbleColour);
    ellipse(bubbleX, tmpBubbleY, diameter, diameter);
    fill(0);
    textSize(17);
    textAlign(CENTER, CENTER);
    text(fact, bubbleX, tmpBubbleY);
    textAlign(LEFT);
    }
    else{
    waitTime--;
    }
  }
}