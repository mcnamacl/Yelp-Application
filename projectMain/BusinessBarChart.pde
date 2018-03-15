class BusinessBarChart extends Chart {
  Business[] businessChart;
  int[] starRatings;
  String type;
  ArrayList<Integer> starRatingsList;

  BusinessBarChart(int x, int y, Business[] businessChart) {
    super(x, y);
    this.businessChart = businessChart;
    type = "average";
  }

  BusinessBarChart(int x, int y, int[] starRatings) {
    super(x, y);
    this.starRatings = starRatings;
    type = "ratings";
    starRatingsList = new ArrayList<Integer>();
    for (int i : starRatings) {
      starRatingsList.add(i);
    }
    Collections.sort(starRatingsList);
  }

  void draw() {
    int tmpX = x;
    int tmpY = y;
    if (type.equals("average")) {
      drawTopRatedBusinessGrid();
      drawTopRatedBusinessIntervals();
      drawScores();
      noStroke();
      for (int i = 0; i < businessChart.length; i++) {
        drawBar(businessChart[i].getAverageStarsOfBusiness(), tmpX, tmpY, businessChart[i].getBusinessName());
        tmpX+=30;
      }
    } else if (type.equals("ratings")) {
      drawRatingsGrid();
      drawRatingsIntervals();
      for (int i = 0; i < starRatings.length; i++) {
        drawBar(starRatings[i], tmpX, tmpY, null);
        tmpX+=30;
      }
    }
  }

  void drawBar(double bar, int x, int y, String businessName) {
    noTint();
    int iY = 0;
    while (iY <= bar*50) {
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

  void drawTopRatedBusinessGrid() {
    stroke(0);
    line((float)x-5, (float)y, (float)x-5, (float)(y-businessChart[0].getAverageStarsOfBusiness()*50));
    line((float)x-5, (float)y+2, (float)x+5+businessChart.length*30, (float)y+2);
  }

  void drawRatingsGrid() {
    stroke(0);
    line((float)x-5, (float)y, (float)x-5, (float)(y-starRatingsList.get(4)*50));
    line((float)x-5, (float)y+2, (float)x+5+5*30, (float)y+2);
  }

  void drawTopRatedBusinessIntervals() {
    fill(0);
    int tmpY = y;
    float interval = (float)(y-businessChart[0].getAverageStarsOfBusiness()*50)/5;
    for (int i = 0; i < 6; i++) {
      text(i, float(x-20), tmpY+2);
      tmpY = tmpY - (int)interval;
    }
  }

  void drawRatingsIntervals() {
    fill(0);
    int tmpY = y;
    float interval = (float)(y-starRatingsList.get(4)*50);
    for (int i = 0; i <= starRatingsList.get(4); i++) {
      text(i, float(x-20), tmpY+2);
      tmpY = tmpY - (int)interval;
      println(i);
    }
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