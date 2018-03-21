class ReviewBox{
  
  int x,y,width,height;
  Widget businessButton,seeFullReviewButton, authorPieChart;
  String reviewer,businessName,review, reviewerId;
  int stars;
  DisplayStars displayStars;
  
  ReviewBox(int x,int y,int width,int height, String reviewer, String reviewerId, String businessName,String review, int stars){
    this.x=x;
    this.y=y;
    this.width=width;
    this.height=height;
    this.reviewer=reviewer;
    this.businessName=businessName;
    this.review=review;
    this.stars=stars;
    this.reviewerId = reviewerId;

    displayStars = new DisplayStars(stars,20,x+5,y+100,yellowStar,greyStar);
    businessButton = new Widget(x+5,y+5,40,15,this.businessName,color(200),widgetFont,0,2,2,true);
    seeFullReviewButton = new Widget(x+5,y+150,40,15,"..read full review",color(200),widgetFont,0,2,2,true);
    
    authorPieChart = new Widget(width-20, y+5, 40,15, reviewer, color(200), widgetFont, EVENT_BUTTON10,2,2,true); 
    homeScreen.addWidget(authorPieChart);
  }
  
  void draw(){
    fill(0, 127);
    rect(x,y,width,height);
    businessButton.draw();
    seeFullReviewButton.draw();
    
    authorPieChart.draw();
    
    fill(DEFAULT_TEXT_COLOUR);
    text(review,x+5,y+30,width-30,height-60);
   // displayStars.draw();
  }  
}