class Bar {

  int x, y, iY;
  double barHeight;
  String businessName;

  Bar(double averageStarsOfBusiness, int tmpX, int tmpY, String businessName) {
    barHeight = averageStarsOfBusiness;
    x = tmpX;
    y = tmpY;
    iY = 0;
    this.businessName = businessName;
  }

  Bar(double starRatings, int tmpX, int tmpY) {
    barHeight = starRatings;
    x = tmpX;
    y = tmpY;
    iY = 0;
  }

  //draws the bars so as they are rising upwards 
  boolean drawBar() {
    if (iY < barHeight) {
      y -=8;
      iY +=8;
    }
    fill(BARCHART_COLOUR, 170);
    rect(x, y, 40, iY);
    if (businessName != null) {
      int tmpX=x;
      int tmpY=y;
      pushMatrix();
      translate(tmpX+5, tmpY);
      rotate(HALF_PI);
      translate(-tmpX, -tmpY);
      fill(#DFFF12);
      textSize(25);
      text(businessName, tmpX+5, tmpY);
      popMatrix();
    }
    return (iY < barHeight);
  }
}