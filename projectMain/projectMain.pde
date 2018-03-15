import java.util.Set; //<>//
import java.util.HashSet;
import java.util.TreeMap;
import java.util.Map;
import java.util.Arrays;


boolean canType=false, drawGraph = false, goToGraph = false;
PFont stdFont;
PImage logoImage;
Widget searchbox, homeButton;
String myText = "Search...";  
String searchText;
Screen screen1, screen2, currentScreen, homeScreen;
ArrayList<DataPoint> dataPoints;
ArrayList<Review> reviews;
ArrayList<Business> businesses = new ArrayList<Business>();
ArrayList<Screen> screens = new ArrayList<Screen>();
ArrayList<Widget> homescreenWidgets = new ArrayList<Widget>();

Set<String> businessNames;
Map<String, ArrayList<Review>> businessReviewMap; 

Table table;
PFont font, widgetFont;
Search search;

//charts
BusinessBarChart barchart;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  textSize(30);
  fill(0);
  logoImage=loadImage("logo.png");
  widgetFont=loadFont("Arial-ItalicMT-17.vlw");
  searchbox=new Widget(SEARCHBOXX, SEARHBOXY, 345, 25, myText, color(blue), widgetFont, EVENT_BUTTON1, 5, 5);
  homeButton=new Widget(HOMEX, HOMEY, 60, 60, logoImage, EVENT_BUTTON2);
  homeScreen=new Screen(color(HOMESCREEN_BACKGROUND), homescreenWidgets);
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
  homescreenWidgets.add(searchbox);
  homescreenWidgets.add(homeButton);
  currentScreen=homeScreen;
}




void draw() {
  background(255);
  fill(#0004B4);
  rect(0, 0, SCREENX, 70);
  searchbox.draw();
  homeButton.drawImage();
  
  //tmp bar chart display
  //displayTopRatedChart();
  if (drawGraph) {
    noStroke();
    if (goToGraph) {
      barchart.draw();
    } else {
      fill(0);
      textSize(20);
      text("Sorry there are no ratings for this business.", 60, SCREENY/2);
    }
  }
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
    } 
    if (searchbox.myText.length() <=36) {
      if (keyCode == DELETE) {
        searchbox.myText = "";
      } else if (keyCode == SHIFT || keyCode==ALT ||keyCode==UP ||keyCode==DOWN ||keyCode==LEFT||keyCode==RIGHT||keyCode==CONTROL) {
      } else if (key != ENTER && keyCode>=32 && keyCode<=223) {
        searchbox.myText =searchbox.myText + key;
      } else if (key == ENTER) {
        searchbox.returnString();
        canType=false;

        ArrayList<Business> searchedBusinesses = search.searchBusinessList(searchbox.returnString());

        //BUSINESS STAR RATINGS GRAPH
        println(searchbox.myText);
        drawGraph = true;
        displayBusinessStarsChart(searchedBusinesses);
        println("Average stars: " + search.getAverageStarsOfBusiness(searchbox.myText));


        //  println(searchedBusinesses.get(0).getBusinessName());
        for (Business business : searchedBusinesses) {
          // println("The branch: " + business.getBusinessId());
          search.getStarsForOneBusiness(business, null);
          // business.displayStarCategories();
        }
      }
    } else if (keyCode == DELETE) {
      searchbox.myText = "";
    } else if (keyCode == SHIFT || keyCode==ALT ||keyCode==UP ||keyCode==DOWN ||keyCode==LEFT||keyCode==RIGHT||keyCode==CONTROL) {
    } else if (key != ENTER && keyCode>=32 && keyCode<=223) {
      searchbox.myText =searchbox.myText + key;
    } else if (key == ENTER) {
      searchbox.returnString();
      canType=false;

      ArrayList<Business> searchedBusinesses = search.searchBusinessList(searchbox.returnString());
      //BUSINESS STAR RATINGS GRAPH
      //println(searchbox.myText);
      //displayBusinessStarsChart(searchedBusinesses);

      //  println(searchedBusinesses.get(0).getBusinessName());
      for (Business business : searchedBusinesses) {
        // println("The branch: " + business.getBusinessId());
        search.getStarsForOneBusiness(business, null);
        // business.displayStarCategories();
      }
    }
  }
}


void mousePressed() {
  int event;
  //event = searchbox.getEvent(mouseX, mouseY);
  event = currentScreen.getEvent(mouseX, mouseY);
  switch(event) {
  case EVENT_BUTTON1:
    if (searchbox.myText=="Search...") {
      searchbox.myText="";
    } 
    canType=true;
    break;

  case EVENT_BUTTON2:
    searchbox.myText="Search...";
    canType=false;
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

void displayTopRatedChart() {
  drawGraph = true;
  goToGraph = true;
  Business[] topRatedBusinesses = search.getTopTenBusinesses();
  barchart = new BusinessBarChart(150, 400, topRatedBusinesses);
}

void displayBusinessStarsChart(ArrayList<Business> businessStarsList) {
  if (!businessStarsList.isEmpty()) {
    goToGraph = true;
  }
  if (goToGraph) {
    String name = businessStarsList.get(0).getBusinessName();
    int[] stars = search.getStarsForCollectionOfBusinesses(businessStarsList);
    barchart = new BusinessBarChart(150, 400, stars, name);
  }
}