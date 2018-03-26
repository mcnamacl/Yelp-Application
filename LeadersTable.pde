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
    placementBox = new TitleBox(x,y,30,30,2,8,color(0,127),color(255),DEFAULT_TEXT_COLOUR ,widgetFont,placementAsString,1);
    rowInTable = new Widget(x+30,y,420,30,businessName,color(0,127),color(255),widgetFont,0,15,8);
    displayStars= new DisplayStars(this.stars,STAR_WIDTH,x+340,y+5,yellowStar,greyStar,halfStar);
    displayStars.initContinuousDisplayStars();
    //println(this.stars);
  }
  
  void draw(){
    placementBox.draw();
    rowInTable.drawLeaderboardRung();
    displayStars.draw();
  }
}

// this method creates an arraylist of leaderboard rungs containing the highest rated businesses-Ruairi
ArrayList<LeadersTable> initTopBusinesses() {
  Business[] topBusinesses = search.getTop15Businesses();
  leaderboardRungList = new ArrayList<LeadersTable>();
  int ranking = 1;
  int x=800;
  int y=320;
  topBusinessesHeader = new TitleBox(x, y-70, 450, 40, 20, 20, color(HIGHLIGHT, 127), DEFAULT_TEXT_COLOUR, color(255), font, "Top Rated Businesses",5);
  for (int i=0; i<topBusinesses.length; i++) {
    String currentBusinessName = topBusinesses[i].getBusinessName();
    //if business name is too long to fit in row, following method will decrease its size
    if (currentBusinessName.length()>=29){
      currentBusinessName = currentBusinessName.substring(0, Math.min(currentBusinessName.length(), 28));
      currentBusinessName+="..";
    }
    LeadersTable rung = new LeadersTable(x,y,ranking,currentBusinessName,topBusinesses[i].getAverageStarsOfBusiness());
    ranking++;
    y+=30;
    leaderboardRungList.add(rung);
  }
  return leaderboardRungList;
}


// this method draws the arrayList that was created above-Ruairi
void drawTopBusinessTable(){
  topBusinessesHeader.draw();
  for (int i=0; i<leaderboardRungList.size(); i++) {
    leaderboardRungList.get(i).draw();
  }
}
