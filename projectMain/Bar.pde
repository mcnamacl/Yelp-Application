class Bar {

  int x, y, iY, tmpY;
  double barHeight;
  String businessName;
  float startPoint, constantY, z;

  Bar(double averageStarsOfBusiness, int tmpX, int tmpY, String businessName, float startPoint, float z) {
    barHeight = averageStarsOfBusiness;
    x = tmpX;
    y = tmpY;
    iY = 0;
    this.startPoint = startPoint;
    constantY = startPoint - (float)barHeight/2;
    this.businessName = businessName;
    this.z = z;
  }

  Bar(double starRatings, int tmpX, int tmpY, float startPoint, float z) {
    barHeight = starRatings;
    x = tmpX;
    y = tmpY;
    iY = 0;
    this.startPoint = startPoint;
    constantY = startPoint - (float)barHeight/2;
    this.z = z;
  }

  //draws the bars so as they are rising upwards 
  boolean drawBar() {
    // TMPY = startPoint;
    if (iY < barHeight) {
      y -=8;
      iY +=8;
    }
    fill(BARCHART_COLOUR, 170);
    pushMatrix();
    translate(x, constantY, 20);
    box(20, iY, 40);
    popMatrix();
    if (businessName != null) {
      int tmpX=x;
      tmpY=y;
      pushMatrix();
      translate(tmpX+20, tmpY);
      rotate(HALF_PI);
      translate(-tmpX, -tmpY);
      fill(#DFFF12);
      textSize(25);
      text(businessName, tmpX+20, tmpY);
      popMatrix();
    }

    return (iY < barHeight);
  }
}