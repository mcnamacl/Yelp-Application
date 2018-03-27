class DisplayStars{
  int x,y,starWidth;
  double stars;
  PImage yellowStar;
  PImage greyStar;
  PImage halfStar;
  Star[] starPictures = new Star[5];
  
  DisplayStars(double stars, int starWidth, int x, int y,PImage yellowStar,PImage greyStar,PImage halfStar){
    this.stars=stars;
    this.starWidth=starWidth;
    this.x=x;
    this.y=y;
    this.yellowStar=yellowStar;
    this.greyStar=greyStar;
    this.halfStar=halfStar;
  }
  
  //used to create an array of star images given a discrete number of stars
  void initDisplayStars(){ //<>// //<>// //<>//
    double starsCopy = stars;
    for (int i = 0; i<starPictures.length; i++){
      if (starsCopy>=1){
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
  
 
  //used to create array of star images given a continous number of stars
  void initContinuousDisplayStars(){
     double starsCopy = stars;
    for (int i = 0; i<starPictures.length; i++){
      if (starsCopy>=1){
        Star ystar = new Star(x,y,yellowStar);
        starPictures[i] = ystar;
        starsCopy--;
      }
      else if (starsCopy>=0.66 && starsCopy<1){
        Star ystar = new Star(x,y,yellowStar);
        starPictures[i] = ystar;
        starsCopy--;
      }
     else if (starsCopy>=0.33 && starsCopy<0.66){
        Star hstar = new Star(x,y,halfStar);
        starPictures[i] = hstar;
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