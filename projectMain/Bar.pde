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

  boolean drawBar() {
    println(iY);
    if (iY < barHeight) {
      y -=2;
      iY +=2;
    }
    fill(BARCHART_COLOUR);
    rect(x, y, 25, iY);
    if (businessName != null) {
      int tmpX=x;
      int tmpY=y;
      pushMatrix();
      translate(tmpX+5, tmpY);
      rotate(HALF_PI);
      translate(-tmpX, -tmpY);
      textSize(15);
      fill(#DFFF12);
      text(businessName, tmpX+5, tmpY);
      popMatrix();
    }
    return (iY < barHeight);
  }
}