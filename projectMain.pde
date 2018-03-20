 //<>//
import java.util.Set;
import java.util.HashSet;
import java.util.TreeMap;
import java.util.Map;
import java.util.Arrays;

ArrayList<ReviewBox> recentReviews;
boolean canType=false, drawGraph = false, goToGraph = false;
PFont stdFont;
PImage logoImage,yellowStar,greyStar;
Widget searchbox, homeButton, leaderboardsButton,  mostReviewed, topStars, topHundred;
String myText = "Search...";  
String searchText;
Screen currentScreen, homeScreen, leaderboardsScreen;
ArrayList<DataPoint> dataPoints;
ArrayList<Review> reviews;
ArrayList<Business> businesses = new ArrayList<Business>();
ArrayList<Screen> screens = new ArrayList<Screen>();
ArrayList<Widget> homescreenWidgets = new ArrayList<Widget>();
ArrayList<Widget> leaderboardsWidgets = new ArrayList<Widget>();

Table table;
PFont font, widgetFont;
Search search;

//charts
BusinessBarChart barchart;

void settings() {
  size(SCREENX, SCREENY, P3D);
}

void setup() {
  textSize(30);
  fill(0);
  logoImage=loadImage("logo.png");
  yellowStar=loadImage("yellowStar.png");
  greyStar=loadImage("greyStar.png");
  widgetFont=loadFont("Arial-ItalicMT-17.vlw");
  searchbox=new Widget(SEARCHBOXX, SEARHBOXY, 345, 25, myText, color(blue), widgetFont, EVENT_BUTTON1, 5, 5);
  leaderboardsButton=new Widget(LEADERBOARDSX, LEADERBOARDSY, 130, 25, "Leaderboards", color(150), widgetFont, EVENT_BUTTON3, 5, 5);
  homeButton=new Widget(HOMEX, HOMEY, 60, 60, logoImage, EVENT_BUTTON2);
  homeScreen=new Screen(color(HOMESCREEN_BACKGROUND), homescreenWidgets);
  leaderboardsScreen= new Screen(color(HOMESCREEN_BACKGROUND), leaderboardsWidgets);
  mostReviewed= new Widget(RADIOBUTTONX, RADIOBUTTONY, 150, 30, "Top star rating", color(150), widgetFont,EVENT_BUTTON4 ,10, 10 );
  font = loadFont("Cambria-20.vlw");
  dataPoints = new ArrayList<DataPoint>();
  table = loadTable("reviews.csv", "header");
  reviews = new ArrayList<Review>();
  businesses = new ArrayList<Business>();
  businessNames = new HashSet<String>();
  businessReviewMap = new TreeMap<String, ArrayList<Review>>();
  reviewerReviewMap = new TreeMap<String, ArrayList<Review>>();
  reviewerNames = new HashSet<String>();
  loadData();
  loadReviewBusiness();
  search = new Search();
  search.createBusinessAZMap();
   search.createReviewerMap();
  search.mostRecentReview(reviews);
  println(businessReviewMap.keySet());
  homeScreen.addWidget(searchbox);
  //homeScreen.addWidget(homeButton);
  homeScreen.addWidget(leaderboardsButton);
  leaderboardsScreen.addWidget(mostReviewed);
  leaderboardsScreen.addWidget(searchbox);
  currentScreen=homeScreen;
  recentReviews = initRecentReviewBoxes();
  //rb = new ReviewBox(100,100,150,300,"James","green spuds","asd as d s s ss s s s sas  dawd i ams a aso yeroas a sldkjahlw asoidja audkaka asd",4);
}


void draw() {
  background(255);
  currentScreen.draw();
  
  fill(#0004B4);
  noStroke();
  rect(0, 0, SCREENX, 70);
  searchbox.draw();
  homeButton.drawImage();
  //leaderboardsButton.draw();
  

  //tmp bar chart display- EVENT
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
  drawRecentReviewBoxes(recentReviews);
}

void mouseMoved() {
  searchbox.setStroke(mouseX, mouseY);
  leaderboardsButton.setStroke(mouseX, mouseY);
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

        //BUSINESS STAR RATINGS GRAPH- EVENT
        println(searchbox.myText);
        drawGraph = true;
       displayBusinessStarsChart(searchedBusinesses);
        println("Average stars: " + search.getAverageStarsOfBusiness(searchbox.myText));
      }
    }
    }
}
  



void mousePressed() {
  int event;
  event = homeButton.getEvent(mouseX, mouseY);
    switch(event) {
  case EVENT_BUTTON2:
    searchbox.myText="Search...";
    canType=false;
    currentScreen=homeScreen;
    break;
  
  default:
    canType=false;
    if (searchbox.myText=="") {
      searchbox.myText="Search...";
    }
    break;
  }
  
  
  event = currentScreen.getEvent(mouseX, mouseY);
  switch(event) {
  case EVENT_BUTTON1:
    if (searchbox.myText=="Search...") {
      searchbox.myText="";
    } 
    canType=true;
    break;
  
  case EVENT_BUTTON3:
   // println("im working");
    currentScreen=leaderboardsScreen;
    goToGraph = false;
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
    barchart = new BusinessBarChart(150, 650, stars, name);
  }
}

// this method creates an arraylist of reviewBox containing the most recent reviews
ArrayList<ReviewBox> initRecentReviewBoxes(){
  ArrayList<Review> mostRecentReviews = search.mostRecentReview(reviews);
  ArrayList<ReviewBox> list = new ArrayList<ReviewBox>();
  int x=50;
  int y=140;
  for (int i=0; i<=2; i++){
    Review review = mostRecentReviews.get(i);
    ReviewBox rb = new ReviewBox(x,y,380,180,review.getAuthor(),review.getBusiness(),review.getText(),review.getStars());
    y+=186;
    list.add(rb);
  }
  return list;
}

// this method draws the arrayList that was created above
void drawRecentReviewBoxes(ArrayList<ReviewBox> list){
  for (int i=0; i<list.size(); i++){
    list.get(i).draw();
  }
  
}