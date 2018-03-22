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
    placementBox = new TitleBox(x,y,30,30,10,10,color(0,127),color(255),DEFAULT_TEXT_COLOUR ,font,placementAsString);
    rowInTable = new Widget(x+30,y,420,30,businessName,color(0,127),color(255),font,0,10,10);
    displayStars.initContinuousDisplayStars();
  }
  
  void draw(){
    placementBox.draw();
    rowInTable.draw();
    displayStars.draw();
  }
}