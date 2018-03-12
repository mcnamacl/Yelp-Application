//String userId, String userName, String businessId, String businessName, int stars, String date, String text, int useful, int funny, int cool

ArrayList<DataPoint> dataPoints;
ArrayList<Review> reviews;
ArrayList<Business> businesses;
//Map<String, Review> 
Table table;
PFont font, widgetFont;
typeToScreen typeToScreen;
Widget widget1;
Search search;
ArrayList<Screen> screens = new ArrayList<Screen>();
Screen homeScreen;
ArrayList<Widget> homescreenWidgets = new ArrayList<Widget>();

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  widgetFont=loadFont("Arial-ItalicMT-30.vlw");
  font = loadFont("Cambria-20.vlw");
  dataPoints = new ArrayList<DataPoint>();
  table = loadTable("reviews.csv", "header");
  reviews = new ArrayList<Review>();
  businesses = new ArrayList<Business>();
  loadData();
  loadReviewBusiness();
  Search search = new Search();
  search.mostRecentReview(reviews);
  for (Review re : reviews) {
    println(re.getDate());
  }
  

  //This should be an event Quiktrip is an example
  ArrayList<Business> searchedBusinesses = search.searchBusinessList("Quiktrip No 453");
  for (Business business : searchedBusinesses) {
    search.getStars(business);
    business.displayStarCategories();
    println(business.getBusinessName() + " " + business.getBusinessId());
  }


  //interface element
  creationOfWidgets();
  creationOfScreens();
}

void draw() {
  //cant stay as for loop needs to change based upon an event
  for (Screen screen : screens) {
    screen.draw();
  }
 typeToScreen.getEvent();
}


void loadData() {
  for (TableRow row : table.rows()) {
    DataPoint dp = new DataPoint(row.getString(0), row.getString(1), row.getString(2), row.getString(3), 
      row.getInt(4), row.getString(5), row.getString(6), row.getInt(7), row.getInt(8), row.getInt(9));
    dataPoints.add(dp);
  }
}

//TODO change name DONEEE!!!
void loadReviewBusiness() {
  for (DataPoint dp : dataPoints) {
    reviews.add(new Review(dp.getUserName(), dp.getBusinessName(), dp.getBusinessId(), dp.getStars(), dp.getText(), dp.getDate(), dp.getUseful(), dp.getFunny(), dp.getCool()));
    businesses.add(new Business(dp.getBusinessName(), dp.getBusinessId()));
  }
}

void creationOfWidgets() {
  int counter = 0;
  for (int i = 0; i < 1; i++) {
    counter++;
    widget1=new Widget(WIDGETX, WIDGETY, 280, 40, "Search...", color(GREEN), widgetFont, counter);
    homescreenWidgets.add(widget1);
  }
  typeToScreen = new typeToScreen(widget1);
}

void creationOfScreens(){
  homeScreen = new Screen(HOMESCREEN_BACKGROUND, homescreenWidgets);
  screens.add(homeScreen);
}