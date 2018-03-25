class LineGraph {

  int x, y, year;
  float max, interval;
  ArrayList<Business> reviewsPerM;
  Chart chart;
  String[] month = new String[12];
  Scores scores;
  Line line;

  public LineGraph(int x, int y, ArrayList<Business> reviewsPerM,int year) {
    this.x = x;
    this.y = y;
    this.reviewsPerM = reviewsPerM;
    this.year = year;
    Collections.sort(reviewsPerM, new SortByAmountOfReviews());
    max = reviewsPerM.get(11).returnAmountOfReviews();
    for (Business business : reviewsPerM) {
      switch(business.getMonth()) {
        case(1):
        month[0] = "January";
        break;
        case(2):
        month[1] = "February";
        break;
        case(3):
        month[2] = "March";
        break;
        case(4):
        month[3] = "April";
        break;
        case(5):
        month[4] = "May";
        break;
        case(6):
        month[5] = "June";
        break;
        case(7):
        month[6] = "July";
        break;
        case(8):
        month[7] = "August";
        break;
        case(9):
        month[8] = "September";
        break;
        case(10):
        month[9] = "October";
        break;
        case(11):
        month[10] = "November";
        break;
        case(12):
        month[11] = "December";
        break;
      }
    }
    interval = (float)(SCREENY-300)/max;
  }

  void drawLineGraph() {
    stroke(255);
    chart = new Chart((float)x-5, y-max*interval, (float)x-5, (float)y, (float)x+5+12*60, y+2);
    chart.drawChart();
    noStroke();
    fill(HIGHLIGHT, 90);
    rect(x-30, y, ((x+5+12*60) - (x-5))+30, ((y-max*interval) - (y+2)) - 10);
    scores = new Scores(x, y, month);
    scores.drawScores();
    drawPoints();
    drawSide();
  }

  void drawPoints() {
    float tmpX = (float) x;
    float tmpY = (float) y;
    float prevX = x;
    float prevY = y;
    fill(255);
    for (Business business : reviewsPerM) {
      tmpY = y-(float)business.returnAmountOfReviews()*interval;
      line = new Line(tmpX, tmpY, prevX, prevY);
      line.drawLines();
      pushMatrix();
      lights();
      translate(tmpX, tmpY);
      sphere(5);
      popMatrix();
      noLights();
      prevX = tmpX;
      prevY = tmpY;
      tmpX+=60;
    }
  }
  
  void drawSide(){
    int tmpY = y;
    fill(PURPLE);
    for (int i =0; i<= max; i++) {
      text(i, float(x-30), tmpY);
      tmpY = tmpY - (int)interval;
    }
  }
}