class ReviewBox {

  int x, y, width, height;
  Widget businessButton, seeFullReviewButton, authorPieChart;
  String reviewer, businessName, review, reviewerId;
  int stars;
  DisplayStars displayStars;

  ReviewBox(int x, int y, int width, int height, String reviewer, String reviewerId, String businessName, String review, int stars) {
    this.x=x;
    this.y=y;
    this.width=width;
    this.height=height;
    this.reviewer=reviewer;
    this.businessName=businessName;
    this.review=review;
    this.stars=stars;
    this.reviewerId = reviewerId;

    displayStars = new DisplayStars(stars, 20, x+10, y+22, yellowStar, greyStar, halfStar);                                                      
    displayStars.initDisplayStars();                                                                                                        
    businessButton = new Widget(x+5, y+5, 210, 15, businessName, color(255, 0), widgetFont, EVENT_BUTTON11, 2, 2, true);
    homeScreen.addWidget(businessButton);
    seeFullReviewButton = new Widget(x+5, y+162, 165, 15, "..read full review", color(255, 0), widgetFont, EVENT_BUTTON16, 2, 2, true);
    homeScreen.addWidget(seeFullReviewButton);
    authorPieChart = new Widget(width+32, y+5, 60, 15, reviewer, color(255, 0), widgetFont, EVENT_BUTTON10, 2, 2, true); 
    homeScreen.addWidget(authorPieChart);
  }

  void draw() {
    noStroke();
    fill(0, 200);
    rect(x, y, width, height);
    businessButton.draw();
    seeFullReviewButton.draw();

    authorPieChart.draw();

    fill(DEFAULT_TEXT_COLOUR);
    text(review, x+5, y+50, width-30, height-65);
    text("by.", x+289, y+17);

    displayStars.draw();
  }
  
  String getReviewer(){
    return reviewer;
  }
  
  String getBusinessName(){
    return businessName;
  }
  
  String getReviewText(){
    return review;
  }
}