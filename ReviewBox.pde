class ReviewBox{
  
  int x,y,width,height;
  Widget businessButton,seeFullReviewButton;
  String reviewer,businessName,review;
  int stars;
  DisplayStars displayStars;
  
  ReviewBox(int x,int y,int width,int height, String reviewer,String businessName,String review, int stars){
    this.x=x;
    this.y=y;
    this.width=width;
    this.height=height;
    this.reviewer=reviewer;
    this.businessName=businessName;
    this.review=review;
    this.stars=stars;
    displayStars = new DisplayStars(stars,20,x+5,y+100,yellowStar,greyStar);
    businessButton = new Widget(x+5,y+5,40,15,this.businessName,color(200),widgetFont,0,2,2,true);
    seeFullReviewButton = new Widget(x+5,y+150,40,15,"..read full review",color(200),widgetFont,0,2,2,true);
    
  }
  
  void draw(){
    fill(0, 127);
    rect(x,y,width,height);
    businessButton.draw();
    seeFullReviewButton.draw();
    fill(DEFAULT_TEXT_COLOUR);
    text(review,x+5,y+30,width-30,height-60);
   // displayStars.draw();
  }  
}