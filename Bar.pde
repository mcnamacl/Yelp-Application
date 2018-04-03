//Class that deals with each individual bar of a bar chart - Claire
class Bar {

  float x, y, iY, tmpY;
  double barHeight;
  String businessName, type;
  float startPoint, constantY, z;
  color barColour;

  Bar(double averageStarsOfBusiness, float tmpX, float tmpY, String businessName, float startPoint, float z, String type) {
    barHeight = averageStarsOfBusiness;
    x = tmpX;
    y = tmpY;
    iY = 0;
    this.startPoint = startPoint;
    constantY = startPoint - (float)barHeight/2;
    this.businessName = businessName;
    this.z = z;
    this.type = type;
    int r = (int)random(255);
    int g = (int)random(255);
    int b = (int)random(255);
    barColour = color(r, g, b); 
  }

  Bar(double starRatings, int tmpX, int tmpY, float startPoint, float z) {
    barHeight = starRatings;
    x = tmpX;
    y = tmpY;
    iY = 0;
    this.startPoint = startPoint;
    constantY = startPoint - (float)barHeight/2;
    this.z = z;
    type = "normal";
  }

  //draws the bars in an animated way in 3D 
  boolean drawBar() {
    if (iY < barHeight) {
      y -=8;
      iY +=8;
    }
    if (type.equals("normal")) {
      fill(BARCHART_COLOUR, 170);
      pushMatrix();
      translate(x, constantY, 20);
      box(20, iY, 40);
      popMatrix();
    } else if (type.equals("map")) {
      noStroke();
      fill(barColour, 170);
      pushMatrix();
      translate(x, constantY+30, 20);
      rotateX(PI/2);
      box(8.5, iY, 8.5);
      popMatrix();
    }

    //if there is a string, draw said string rotated clockwise 90 degrees upwards
    if (businessName != null) {
      if (type.equals("normal")) {
        float tmpX=x;
        tmpY=y;
        pushMatrix();
        translate(tmpX+20, tmpY);
        rotate(HALF_PI);
        translate(-tmpX, -tmpY);
        fill(#E5802C);
        textSize(25);
        text(businessName, tmpX+20, tmpY);
        popMatrix();
      } else if (type.equals("map")) {
      }
    }
    return (iY < barHeight);
  }
}