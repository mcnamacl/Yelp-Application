//Class that deals with all bar charts - Claire
class BusinessBarChart {
  int x, y;
  Business[] businessChart;
  float[] amountOfType;
  int[] starRatings;
  String type = " ", label = " ";
  ArrayList<Integer> starRatingsList;
  String businessName;
  float interval, lineY1, lineX1, lineY2, lineX2, z;
  Bar[] bars;
  Review[] typeReviews;
  Chart chart;
  Scores scores;

  //sets up the bar chart for the star ratings of the top 10 businesses/ most reviewed businesses
  BusinessBarChart(int x, int y, Business[] businessChart, String label) {
    this.x = x;
    this.y = y;
    this.businessChart = businessChart;
    this.label = label;
    z=50;
    type = "average";
    amountOfType = new float[businessChart.length];
    lineY2 = y+2;
    if (label.equals("topBusinesses")) {
      interval = (float)(y-businessChart[0].getAverageStarsOfBusiness()*80)/(float)businessChart[0].getAverageStarsOfBusiness();
    } else if (label.equals("mostReviewed")) {
      interval = (float)(y-businessChart[0].returnAmountOfReviews()/2)/(float)businessChart[0].returnAmountOfReviews();
    }
    bars = new Bar[businessChart.length];
    int tmpX = x+25;
    int tmpY = y;
    if (label.equals("topBusinesses")) {
      lineY1 = y-interval*5;
      for (int i = 0; i < businessChart.length; i++) {
        bars[i] = new Bar(businessChart[i].getAverageStarsOfBusiness()*interval, tmpX, tmpY, businessChart[i].getBusinessName(), lineY2, z);
        amountOfType[i] = (float)businessChart[i].getAverageStarsOfBusiness();
        tmpX+=60;
      }
    } else if (label.equals("mostReviewed")) {
      lineY1 = y - businessChart[0].returnAmountOfReviews()*interval;
      for (int i = 0; i < businessChart.length; i++) {
        bars[i] = new Bar(businessChart[i].returnAmountOfReviews()*interval, tmpX, tmpY, businessChart[i].getBusinessName(), lineY2, z);
        amountOfType[i] = businessChart[i].returnAmountOfReviews();
        tmpX+=60;
      }
    }
    lineX1 = x-5;
    lineX2 = x+5+businessChart.length*60;
  }

  //sets up the bar chart for the star ratings of a particular business
  BusinessBarChart(int x, int y, int[] starRatings, String businessName) {
    this.x = x;
    this.y = y;
    this.starRatings = starRatings;
    this.businessName = businessName;
    z = 50;
    lineY2 = y+2;
    type = "ratings";
    amountOfType = new float[starRatings.length];
    starRatingsList = new ArrayList<Integer>();
    for (int i : starRatings) {
      starRatingsList.add(i);
    }
    Collections.sort(starRatingsList);
    interval = (float)(SCREENY-300)/starRatingsList.get(4);
    bars = new Bar[starRatings.length];
    int tmpX = x+25;
    int tmpY = y;
    for (int i = 0; i < starRatings.length; i++) {
      bars[i] = new Bar(starRatings[i]*interval, tmpX, tmpY, lineY2, z);
      amountOfType[i] = i+1;
      tmpX+=60;
    }
    lineX1 = x-5;
    lineY1 = y-starRatingsList.get(4)*interval;
    lineX2 = x+5+5*60;
  }

  //sets up bar chart for funny/useful/cool
  BusinessBarChart(int x, int y, Review[] typeReviews, String label) {
    this.x = x;
    this.y = y;
    this.typeReviews = typeReviews;
    this.label = label;
    type = "ratings";
    z=50;
    if (label.equals("funny")) {
      interval = (float)(y-typeReviews[0].getFunny()*10)/(float)typeReviews[0].getFunny();
    } else if (label.equals("useful")) {
      interval = (float)(y-typeReviews[0].getUseful()*10)/(float)typeReviews[0].getUseful();
    } else if (label.equals("cool")) {
      interval = (float)(y-typeReviews[0].getCool()*10)/(float)typeReviews[0].getCool();
    }
    bars = new Bar[typeReviews.length];
    int tmpX = x+25;
    int tmpY = y;
    int max = 0;
    lineY2 = y+2;
    z = 50;
    amountOfType = new float[typeReviews.length];
    if (label.equals("funny")) {
      max = typeReviews[0].getFunny();
      lineY1 = y-max*interval;
      for (int i = 0; i < typeReviews.length; i++) {
        bars[i] = new Bar(typeReviews[i].getFunny()*interval, tmpX, tmpY, typeReviews[i].getAuthor(), lineY2, z);
        amountOfType[i] = typeReviews[i].getFunny();
        tmpX+=60;
      }
    } else if (label.equals("useful")) {
      max = typeReviews[0].getUseful();
      lineY1 = y-max*interval;
      for (int i = 0; i < typeReviews.length; i++) {
        bars[i] = new Bar(typeReviews[i].getUseful()*interval, tmpX, tmpY, typeReviews[i].getAuthor(), lineY2, z);
        amountOfType[i] = typeReviews[i].getUseful();
        tmpX+=60;
      }
    } else if (label.equals("cool")) {
      max = typeReviews[0].getCool();
      lineY1 = y-max*interval;
      for (int i = 0; i < typeReviews.length; i++) {
        bars[i] = new Bar(typeReviews[i].getCool()*interval, tmpX, tmpY, typeReviews[i].getAuthor(), lineY2, z);
        amountOfType[i] = typeReviews[i].getCool();
        tmpX+=60;
      }
    }
    lineX1 = x-5;
    lineX2 = x+5+typeReviews.length*60;
  }


  //draws the relevent barchart
  void draw() {
    fill(HIGHLIGHT, 90);
    rect(x-30, y, (lineX2 - lineX1)+30, (lineY1 - lineY2) - 10);
    if (type.equals("average") && !label.equals("mostReviewed")) {
      drawTopRatedBusiness();
    } else if (label.equals("mostReviewed")) {
      drawMostReviewedBusinesses();
    } else if (type.equals("ratings")) {
      drawRatings();
    }
    scores.drawScores();
    chart.drawChart();
    noStroke();
  }


  //sets up the graph for the top rated businesses
  void drawTopRatedBusiness() {
    fill(255);
    int tmpY = y;
    textSize(20);
    for (int i = 0; i < 6; i++) {
      text(i, float(x-20), tmpY+2);
      tmpY = tmpY - (int)interval;
    }
    stroke(255);
    chart = new Chart(lineX1, lineY1, (float)x-5, (float)y, lineX2, lineY2);
    scores = new Scores(x+5, y+20, amountOfType);
  }

  //sets up graph for the most reviewed businesses
  void drawMostReviewedBusinesses() {
    fill(255);
    float tmpY = y;
    float distance = businessChart[0].returnAmountOfReviews()/(10+interval);
    textSize(20);
    for (int i = 0; i <= businessChart[0].returnAmountOfReviews(); i=i+10) {    
      text(i, float(x-40), tmpY+2);
      tmpY = tmpY - distance;
    }
    stroke(255);
    chart = new Chart(lineX1, lineY1, (float)x-5, (float)y, lineX2, lineY2);
    scores = new Scores(x+5, y+20, amountOfType);
  }


  //sets up the graph for the business ratings
  void drawRatings() {
    fill(255);
    int tmpY = y;
    int max = 0;
    if (label !=" ") {
      if (label.equals("funny")) {
        max = typeReviews[0].getFunny();
      } else if (label.equals("useful")) {
        max = typeReviews[0].getUseful();
      } else if (label.equals("cool")) {
        max = typeReviews[0].getCool();
      }
    } else {
      max = starRatingsList.get(4);
    }    
    int i = 0;
    if (max > 100){
      interval = max/7.5;
    }
    while (i <= max) {
      if (max > 100) {
        i+=10;
      } else {
        i++;
      }
      text(i, float(x-30), tmpY-15);
      tmpY = tmpY - (int)interval;
    }
    stroke(255);
    textSize(20);
    fill(255);
    textSize(20);
    if (businessName!=null) {
      textSize(20);
      text("Stars", (float) x + 40, y + 80);
      text(businessName, (float) x + 10, y + 60);
    }
    chart = new Chart(lineX1, lineY1, (float)x-5, (float)y, lineX2, lineY2);
    scores = new Scores(x+5, y+20, amountOfType);
  }
}