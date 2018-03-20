class DisplayStars{
  int stars,x,y,starWidth;
  PImage yellowStar;
  PImage greyStar;
  PImage[] starPictures = new PImage[5];
  
  DisplayStars(int stars, int starWidth, int x, int y){
    this.stars=stars;
    this.starWidth=starWidth;
    this.x=x;
    this.y=y;
  }
  
  void initDisplayStars(){
    int starsCopy = stars;
    for (int i = 0; i<5; i++){
      if (starsCopy>=0){
        starPictures[i] = yellowStar;
        starsCopy--;
      }
      else
        starPictures[i] = greyStar;
    }
  }
  
  void draw(){
    for (int i=0; i<starPictures.length; i++){
      PImage drawStar = starPictures[i];
      image(drawStar,x,y);
      x+=starWidth;
    }
  }
}