class LeadersTable {
  int x, y, placement;
  String businessName, placementAsString;
  double stars;
  DisplayStars displayStars;
  Widget rowInTable;
  TitleBox placementBox;

  LeadersTable(int x, int y, int placement, String businessName, double stars) {
    this.x=x;
    this.y=y;
    this.placement=placement;
    this.businessName=businessName;
    this.stars=stars;

    placementAsString = placement+"";   
    placementBox = new TitleBox(x, y, 30, 30, 2, 8, color(0, 127), color(255), DEFAULT_TEXT_COLOUR, widgetFont, placementAsString, 1);
    rowInTable = new Widget(x+30, y, 420, 30, businessName, color(0, 127), color(255), widgetFont, EVENT_BUTTON12, 15, 8);
    homeScreen.addWidget(rowInTable);
    displayStars= new DisplayStars(this.stars, STAR_WIDTH, x+340, y+5, yellowStar, greyStar, halfStar);
    displayStars.initContinuousDisplayStars();
    //println(this.stars);
  }

  void draw() {
    placementBox.draw();
    rowInTable.drawLeaderboardRung();
    displayStars.draw();
  }

  public String getBusinessName() {
    return businessName;
  }
}