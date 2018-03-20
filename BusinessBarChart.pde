class BusinessBarChart extends Chart {
  Business[] businessChart;
  int[] starRatings;
  String type;
  ArrayList<Integer> starRatingsList;
  String businessName;
  float interval;

  BusinessBarChart(int x, int y, Business[] businessChart) {
    super(x, y);
    this.businessChart = businessChart;
    type = "average";
  }

  BusinessBarChart(int x, int y, int[] starRatings, String businessName) {
    super(x, y);
    this.starRatings = starRatings;
    this.businessName = businessName;
    type = "ratings";
    starRatingsList = new ArrayList<Integer>();
    for (int i : starRatings) {
      starRatingsList.add(i);
    }
    Collections.sort(starRatingsList);
    interval = (float)(SCREENY-200)/starRatingsList.get(4);
  }

  void draw() {
    int tmpX = x;
    int tmpY = y;
    if (type.equals("average")) {
      drawTopRatedBusiness();
      drawScores();
      noStroke();
      for (int i = 0; i < businessChart.length; i++) {
        drawBar(businessChart[i].getAverageStarsOfBusiness(), tmpX, tmpY, businessChart[i].getBusinessName());
        tmpX+=30;
      }
    } else if (type.equals("ratings")) {
      drawRatings();
      for (int i = 0; i < starRatings.length; i++) {
        drawBar(starRatings[i], tmpX, tmpY, null);
        tmpX+=30;
      }
    }
  }

  void drawBar(double bar, int x, int y, String businessName) {
    int iY = 0;
    while (iY <= bar*interval) {
      fill(BARCHART_COLOUR);
      rect(x, y, 25, iY);
      y --;
      iY ++;
    }
    if (businessName != null) {
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

  void drawTopRatedBusiness() {
    fill(0);
    int tmpY = y;
    float bInterval = (float)(y-businessChart[0].getAverageStarsOfBusiness()*50)/(float)businessChart[0].getAverageStarsOfBusiness();
    for (int i = 0; i < 6; i++) {
      text(i, float(x-20), tmpY+2);
      tmpY = tmpY - (int)bInterval;
    }
    stroke(0);
    line((float)x-5, (float)y, (float)x-5, (float)(y-bInterval*5));
    line((float)x-5, (float)y+2, (float)x+5+businessChart.length*30, (float)y+2);
  }

  void drawRatings() {
    fill(0);
    int tmpY = y;
    for (int i = 0; i <= starRatingsList.get(4); i++) {
      text(i, float(x-30), tmpY);
      tmpY = tmpY - (int)interval;
    }
    stroke(0);
    line((float)x-5, (float)y, (float)x-5, (float)(y-starRatingsList.get(4)*interval));
    line((float)x-5, (float)y+2, (float)x+5+5*30, (float)y+2);
    textSize(20);
    fill(0);
    int tmpX = x+5;
    for (int i = 1; i < 6; i++) {
      textSize(20);
      text(i, (float) tmpX, (float)y+20);
      tmpX = tmpX + 30;
    }
    textSize(15);
    text("Stars", (float) x + 40, y + 60);
    textSize(20);
    text(businessName, (float) x + 10, y + 40);
  }

  void drawScores() {
    fill(0);
    int tmpX = x;
    for (int i = 0; i < 10; i++) {
      textSize(10);
      text((float)businessChart[i].getAverageStarsOfBusiness(), (float)tmpX, (float)y+20);
      tmpX = tmpX + 30;
    }
  }
}