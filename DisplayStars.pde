class DisplayStars{
  int stars,x,y,starWidth;
  PImage yellowStar;
  PImage greyStar;
  Star[] starPictures = new Star[5];
  
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
        Star ystar = new Star(x,y,yellowStar);
        starPictures[i] = ystar;
        starsCopy--;
      }
      else{
        Star gstar = new Star(x,y,greyStar);
        starPictures[i] = gstar;
      }
      x+=starWidth;
    }
  }
  
  void draw(){
    for (int i=0; i<starPictures.length; i++){
      starPictures[i].draw();
    }
  }
}

class Star{
  int x,y;
  PImage star;
  
  Star(int x, int y,PImage star){
    this.x=x;
    this.y=y;
    this.star=star;
  }
  
  void draw(){
    image(star,x,y);
  }
}