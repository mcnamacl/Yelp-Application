boolean canType=false;
PFont stdFont;
Widget searchbox;
String myText = "Search...";  
Screen screen1, screen2, currentScreen;
ArrayList<DataPoint> dataPoints;
ArrayList<Review> reviews;
ArrayList<Business> businesses;
ArrayList<Screen> screens = new ArrayList<Screen>();
Screen homeScreen;
ArrayList<Widget> homescreenWidgets = new ArrayList<Widget>();
Table table;
PFont font, widgetFont;
Search search;

void setup() {
  size(500, 500);
  textSize(30);
  fill(0);
  widgetFont=loadFont("Arial-ItalicMT-30.vlw");
  searchbox=new Widget(WIDGETX, WIDGETY, 280, 40, myText, color(blue), widgetFont, EVENT_BUTTON1);
  font = loadFont("Cambria-20.vlw");
  dataPoints = new ArrayList<DataPoint>();
  table = loadTable("reviews.csv", "header");
  reviews = new ArrayList<Review>();
  businesses = new ArrayList<Business>();
  loadData();
  loadReviewBusiness();
  search = new Search();
  search.mostRecentReview(reviews);
  //for (Review re : reviews) {
  //  println(re.getDate());
  //}

  // //This should be an event Quiktrip is an example
  //ArrayList<Business> searchedBusinesses = search.searchBusinessList("Quiktrip No 453");
  //for (Business business : searchedBusinesses) {
  //  search.getStars(business);
  //  business.displayStarCategories();
  //  println(business.getBusinessName() + " " + business.getBusinessId());
  //}
}
  
 

void loadData() {
  for (TableRow row : table.rows()) {
    DataPoint dp = new DataPoint(row.getString(0), row.getString(1), row.getString(2), row.getString(3), 
      row.getInt(4), row.getString(5), row.getString(6), row.getInt(7), row.getInt(8), row.getInt(9));
    dataPoints.add(dp);
  }
}


void loadReviewBusiness() {
  for (DataPoint dp : dataPoints) {
    reviews.add(new Review(dp.getUserName(), dp.getBusinessName(), dp.getBusinessId(), dp.getStars(), dp.getText(), dp.getDate(), dp.getUseful(), dp.getFunny(), dp.getCool()));
    businesses.add(new Business(dp.getBusinessName(), dp.getBusinessId()));
  }
}