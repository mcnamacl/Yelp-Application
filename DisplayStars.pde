class DisplayStars{
  int stars,x,y,starWidth;
  PImage yellowStar;
  PImage greyStar;
  PImage[] starPictures = new PImage[5];
  
  DisplayStars(int stars, int starWidth, int x, int y,PImage yellowStar,PImage greyStar){
    this.stars=stars;
    this.starWidth=starWidth;
    this.x=x;
    this.y=y;
    this.yellowStar=yellowStar;
    this.greyStar=greyStar;
  }
  
  void initDisplayStars(){ //<>//
    int starsCopy = stars;
    for (int i = 0; i<starPictures.length; i++){
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
      image(starPictures[i],x,y);
      x+=starWidth;
    }
  }
}