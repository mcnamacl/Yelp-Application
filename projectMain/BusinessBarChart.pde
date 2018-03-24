//Class that deals with all bar charts - Claire
class BusinessBarChart {
  int x, y;
  Business[] businessChart;
  int[] starRatings;
  String type = " ", label = " ";
  ArrayList<Integer> starRatingsList;
  String businessName;
  float interval, lineY1, lineX1, lineY2, lineX2, z;
  Bar[] bars;
  Review[] typeReviews;

  //sets up the bar chart for the star ratings of the top 10 businesses/ most reviewed businesses
  BusinessBarChart(int x, int y, Business[] businessChart, String label) {
    this.x = x;
    this.y = y;
    this.businessChart = businessChart;
    this.label = label;
    z=50;
    type = "average";
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
        tmpX+=60;
      }
    } else if (label.equals("mostReviewed")) {
      lineY1 = y - businessChart[0].returnAmountOfReviews()*interval;
      for (int i = 0; i < businessChart.length; i++) {
        bars[i] = new Bar(businessChart[i].returnAmountOfReviews()*interval, tmpX, tmpY, businessChart[i].getBusinessName(), lineY2, z);
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
    if (label.equals("funny")) {
      max = typeReviews[0].getFunny();
      lineY1 = y-max*interval;
      for (int i = 0; i < typeReviews.length; i++) {
        bars[i] = new Bar(typeReviews[i].getFunny()*interval, tmpX, tmpY, typeReviews[i].getAuthor(), lineY2, z);
        tmpX+=60;
      }
    } else if (label.equals("useful")) {
      max = typeReviews[0].getUseful();
      lineY1 = y-max*interval;
      for (int i = 0; i < typeReviews.length; i++) {
        bars[i] = new Bar(typeReviews[i].getUseful()*interval, tmpX, tmpY, typeReviews[i].getAuthor(), lineY2, z);
        tmpX+=60;
      }
    } else if (label.equals("cool")) {
      max = typeReviews[0].getCool();
      lineY1 = y-max*interval;
      for (int i = 0; i < typeReviews.length; i++) {
        bars[i] = new Bar(typeReviews[i].getCool()*interval, tmpX, tmpY, typeReviews[i].getAuthor(), lineY2, z);
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
      drawScores();
    } else if (label.equals("mostReviewed")) {
      drawMostReviewedBusinesses();
      drawMostReviewedScores();
    } else if (type.equals("ratings")) {
      drawRatings();
      if (label!=null) {
        if (label.equals("funny")) {
          drawFunnyScores();
        } else if (label.equals("useful")) {
          drawUsefulScores();
        } else if (label.equals("cool")) {
          drawCoolScores();
        }
      }
    }
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
    line((float)x-5, (float)y, lineX1, lineY1);
    line((float)x-5, (float)y+2, lineX2, lineY2);
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
    line((float)x-5, (float)y, lineX1, lineY1);
    line((float)x-5, (float)y+2, lineX2, lineY2);
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
    while (i <= max) {
      text(i, float(x-30), tmpY-15);
      tmpY = tmpY - (int)interval;
      i++;
    }
    stroke(255);
    line((float)x-5, (float)y, lineX1, lineY1);
    line((float)x-5, (float)y+2, lineX2, lineY2);
    textSize(20);
    fill(255);
    int tmpX = x+5;
    for (i = 1; i < 6; i++) {
      textSize(20);
      text(i, (float) tmpX, (float)y+20);
      tmpX = tmpX + 60;
    }
    textSize(20);
    if (businessName!=null) {
      textSize(20);
      text("Stars", (float) x + 40, y + 60);
      text(businessName, (float) x + 10, y + 40);
    }
  }

  //prints the average stars of the business underneath the bars in the 10 top rated businesses chart
  void drawScores() {
    fill(255);
    int tmpX = x+2;
    for (int i = 0; i < 10; i++) {
      textSize(18);
      text((float)businessChart[i].getAverageStarsOfBusiness(), (float)tmpX, (float)y+20);
      tmpX = tmpX + 60;
    }
  }

//prints the amount of reviews for the top 10 reviewed businesses
  void drawMostReviewedScores() {
    fill(255);
    int tmpX = x+2;
    for (int i = 0; i < 10; i++) {
      textSize(18);
      text((float)businessChart[i].returnAmountOfReviews(), (float)tmpX, (float)y+20);
      tmpX = tmpX + 60;
    }
  }

//draw the amount of funny ratings
  void drawFunnyScores() {
    fill(255);
    int tmpX = x+2;
    for (int i = 0; i < 10; i++) {
      textSize(18);
      text((float)typeReviews[i].getFunny(), (float)tmpX, (float)y+20);
      tmpX = tmpX + 60;
    }
  }

//draw the amount of useful ratings
  void drawUsefulScores() {
    fill(255);
    int tmpX = x;
    for (int i = 0; i < 10; i++) {
      textSize(18);
      text((float)typeReviews[i].getUseful(), (float)tmpX, (float)y+20);
      tmpX = tmpX + 60;
    }
  }

//draw the amount of cool ratings
  void drawCoolScores() {
    fill(255);
    int tmpX = x;
    for (int i = 0; i < 10; i++) {
      textSize(18);
      text((float)typeReviews[i].getCool(), (float)tmpX, (float)y+20);
      tmpX = tmpX + 60;
    }
  }
}