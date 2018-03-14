class BarChart extends Chart {
  Business[]topBusinesses;

  BarChart(int x, int y, Business[] topBusinesses) {
    super(x, y);
    this.topBusinesses = topBusinesses;
  }

  void draw() {
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
}