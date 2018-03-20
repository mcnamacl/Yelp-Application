class BusinessBarChart extends Chart {
  Business[] businessChart;
  int[] starRatings;
  String type;
  ArrayList<Integer> starRatingsList;
  String businessName;
  float interval;
  Bar[] bars;

  BusinessBarChart(int x, int y, Business[] businessChart) {
    super(x, y);
    this.businessChart = businessChart;
    type = "average";
    interval = (float)(y-businessChart[0].getAverageStarsOfBusiness()*50)/(float)businessChart[0].getAverageStarsOfBusiness();
    bars = new Bar[businessChart.length];
    int tmpX = x;
    int tmpY = y;
    for (int i = 0; i < businessChart.length; i++){
      bars[i] = new Bar(businessChart[i].getAverageStarsOfBusiness()*interval, tmpX, tmpY, businessChart[i].getBusinessName());
      tmpX+=30;
    }
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
    bars = new Bar[starRatings.length];
    int tmpX = x;
    int tmpY = y;
    for (int i = 0; i < starRatings.length; i++){
      bars[i] = new Bar(starRatings[i]*interval, tmpX, tmpY);
      tmpX+=30;
    }
  }

  void draw() {
    if (type.equals("average")) {
      drawTopRatedBusiness();
      drawScores();
      noStroke();
    } else if (type.equals("ratings")) {
      drawRatings();
      noStroke();
    }
  }

  void drawTopRatedBusiness() {
    fill(0);
    int tmpY = y;
    for (int i = 0; i < 6; i++) {
      text(i, float(x-20), tmpY+2);
      tmpY = tmpY - (int)interval;
    }
    stroke(0);
    line((float)x-5, (float)y, (float)x-5, (float)(y-interval*5));
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