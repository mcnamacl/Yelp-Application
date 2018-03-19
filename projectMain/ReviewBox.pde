class ReviewBox{
  
  int x,y,width,height;
  Widget businessButton,seeFullReviewButton;
  String reviewer,businessName,review;
  int stars;
  color defaultTextColour = color(255);
  
  ReviewBox(int x,int y,int width,int height, String reviewer,String businessName,String review, int stars){
    this.x=x;
    this.y=y;
    this.width=width;
    this.height=height;
    this.reviewer=reviewer;
    this.businessName=businessName;
    this.review=review;
    this.stars=stars;
    businessButton = new Widget(x+5,y+5,40,15,this.businessName,color(200),widgetFont,0,2,2,true);
    seeFullReviewButton = new Widget(x+5,y+150,40,15,"..read full review",color(200),widgetFont,0,2,2,true);
  }
  
  void draw(){
    fill(255,0,0);
    rect(x,y,width,height);
    businessButton.draw();
    seeFullReviewButton.draw();
    fill(defaultTextColour);
    text(review,x+5,y+30,100,100);
  }
  
  
}
