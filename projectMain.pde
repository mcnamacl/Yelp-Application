import java.util.Set; //<>//
import java.util.HashSet;
import java.util.TreeMap;
import java.util.Map;
import java.util.Arrays;


boolean canType=false;
PFont stdFont;
Widget searchbox;
String myText = "Search...";  
Screen screen1, screen2, currentScreen, homeScreen;
ArrayList<DataPoint> dataPoints;
ArrayList<Review> reviews;
ArrayList<Business> businesses;
ArrayList<Screen> screens = new ArrayList<Screen>();
ArrayList<Widget> homescreenWidgets = new ArrayList<Widget>();

Set<String> businessNames;
Map<String, ArrayList<Review>> businessReviewMap; 

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
  businessNames = new HashSet<String>();
  businessReviewMap = new TreeMap<String, ArrayList<Review>>();
  loadData();
  loadReviewBusiness();
  search = new Search();
  search.createBusinessAZMap();
  search.mostRecentReview(reviews);
  println(businessReviewMap.keySet());


  // //This should be an event Quiktrip is an example
  //ArrayList<Business> searchedBusinesses = search.searchBusinessList("Quiktrip No 453");
  //for (Business business : searchedBusinesses) {
  //  search.getStars(business);
  //  business.displayStarCategories();
  //  println(business.getBusinessName() + " " + business.getBusinessId());
  //}
}



void draw() {
  background(255);
  searchbox.draw();
}


void mouseMoved() {
  searchbox.setStroke(mouseX, mouseY);
}


void keyPressed() {
  if (canType) {
    if (key == BACKSPACE) {
      if (searchbox.myText.length()-1 <= 0) {
        searchbox.myText = "";
      } else if (myText.length() > 0) {
        searchbox.myText = searchbox.myText.substring(0, searchbox.myText.length()-1);
      }
    } else if (keyCode == DELETE) {
      searchbox.myText = "";
    } else if (keyCode == SHIFT || keyCode==ALT ||keyCode==UP ||keyCode==DOWN ||keyCode==LEFT||keyCode==RIGHT||keyCode==CONTROL) {
    } else if (key != ENTER && keyCode>=32 && keyCode<=127) {
      searchbox.myText =searchbox.myText + key;
    } else if (key == ENTER) {
      searchbox.returnString();
      canType=false;
      ArrayList<Business> searchedBusinesses = search.searchBusinessList(searchbox.returnString());
      println(searchbox.myText);
      
      println("Average stars: " + search.getAverageStarsOfBusiness(searchbox.myText));
      /*for (Business business : searchedBusinesses) {
        search.getStars(business);
        business.displayStarCategories();
        println(business.getBusinessName() + " " + business.getBusinessId());
      }*/
    }
  }
}

void mousePressed() {
  int event;
  event = searchbox.getEvent(mouseX, mouseY);
  switch(event) {
  case EVENT_BUTTON1:
    if (searchbox.myText=="Search...") {
      searchbox.myText="";
    } 
    canType=true;
    break;
  default:
    canType=false;
    if (searchbox.myText=="") {
      searchbox.myText="Search...";
    }
    break;
  }
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