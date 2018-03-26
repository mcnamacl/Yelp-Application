class LeadersTable{
  int x,y,placement;
  String businessName,placementAsString;
  double stars;
  DisplayStars displayStars;
  Widget rowInTable;
  TitleBox placementBox;
  
  LeadersTable(int x, int y, int placement, String businessName, double stars){
    this.x=x;
    this.y=y;
    this.placement=placement;
    this.businessName=businessName;
    this.stars=stars;
 
    placementAsString = placement+"";   
    placementBox = new TitleBox(x,y,30,30,10,10,color(0,127),color(255),DEFAULT_TEXT_COLOUR ,widgetFont,placementAsString,1);
    rowInTable = new Widget(x+30,y,420,30,businessName,color(0,127),color(255),widgetFont,0,15,8);
    displayStars= new DisplayStars(this.stars,STAR_WIDTH,x+340,y+5,yellowStar,greyStar,halfStar);
    displayStars.initContinuousDisplayStars();
  }
  
  void draw(){
    placementBox.draw();
    rowInTable.drawLeaderboardRung();
    displayStars.draw();
  }
}

// this method creates an arraylist of leaderboard rungs containing the highest rated businesses
ArrayList<LeadersTable> initTopBusinesses() {
  String[] topBusinesses = search.getTop20Businesses();
  leaderboardRungList = new ArrayList<LeadersTable>();
  int ranking = 1;
  int x=500;
  int y=270;
  recentReviewsHeader = new TitleBox(x, y-100, 380, 60, 25, 25, color(255, 0, 0, 127), DEFAULT_TEXT_COLOUR, DEFAULT_TEXT_COLOUR, font, "Most Recent Reviews",5);
  recentReviewsHeader = new TitleBox(x, y-100, 380, 60, 25, 25, color(HIGHLIGHT, 127), DEFAULT_TEXT_COLOUR, color(255), font, "Most Recent Reviews",5);
  for (int i=0; i<=14; i++) {
    LeadersTable rung = new LeadersTable(x,y,ranking,topBusinesses[i],5);
    ranking++;
    y+=30;
    leaderboardRungList.add(rung);
  }
  return leaderboardRungList;
}