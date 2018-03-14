class TopRatedBusinessBarChart extends Chart {
  Business[]topBusinesses;

  TopRatedBusinessBarChart(int x, int y, Business[] topBusinesses) {
    super(x, y);
    this.topBusinesses = topBusinesses;
  }

  void draw() {
    drawGrid();
    drawIntervals();
    drawScores();
    noStroke();
    int tmpX = x;
    int tmpY = y;
    for (int i = 0; i < topBusinesses.length; i++) {
      drawBar(topBusinesses[i].getAverageStarsOfBusiness(), tmpX, tmpY, topBusinesses[i].getBusinessName());
      tmpX+=30;
    }
  }

  void drawBar(double bar, int x, int y, String businessName) {
    int iY = 0;
    while (iY <= bar*50) {
      fill(BARCHART_COLOUR);
      rect(x, y, 25, iY);
      y --;
      iY ++;
    }
    pushMatrix();
    translate(x+5, y);
    rotate(HALF_PI);
    translate(-x, -y);
    textSize(15);
    fill(#DFFF12);
    text(businessName, x+5, y);
    popMatrix();
  }

  void drawGrid() {
    stroke(0);
    line((float)x-5, (float)y, (float)x-5, (float)(y-topBusinesses[0].getAverageStarsOfBusiness()*50));
    line((float)x-5, (float)y+2, (float)x+5+topBusinesses.length*30, (float)y+2);
  }

  void drawIntervals() {
    fill(0);
    int tmpY = y;
    float interval = (float)(y-topBusinesses[0].getAverageStarsOfBusiness()*50)/5;
    for (int i = 0; i < 6; i++) {
      text(i, float(x-20), tmpY+2);
      tmpY = tmpY - (int)interval;
    }
  }
  
  void drawScores(){
    fill(0);
    int tmpX = x;
    for (int i = 0; i < 10; i++){
      textSize(10);
      text((float)topBusinesses[i].getAverageStarsOfBusiness(), float(tmpX), (float)y+20);
      tmpX = tmpX + 30;
    }
  }
}