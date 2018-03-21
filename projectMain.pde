import java.util.Set; //<>//
import java.util.HashSet;
import java.util.TreeMap;
import java.util.Map;
import java.util.Arrays;

ArrayList<ReviewBox> recentReviews;
boolean canType=false, drawGraph = false, goToGraph = false, drawPieChart = false;;
PFont stdFont;
PImage logoImage, yellowStar, greyStar, backgroundPhoto, backgroundPhotoLeaderBoards;
Widget searchbox, homeButton, leaderboardsButton, mostReviewed, topStars, topHundred, coolest, funniest, mostUseful, authorPieChart;
String myText = "Search...";  
String searchText;
Screen currentScreen, homeScreen, leaderboardsScreen;
ArrayList<DataPoint> dataPoints;
ArrayList<Review> reviews;
ArrayList<Business> businesses = new ArrayList<Business>();
ArrayList<Screen> screens = new ArrayList<Screen>();
ArrayList<Widget> homescreenWidgets = new ArrayList<Widget>();
ArrayList<Widget> leaderboardsWidgets = new ArrayList<Widget>();

ArrayList<ReviewBox> list;

Table table;
PFont font, widgetFont, barFont, businessFont;
Search search;

//charts
BusinessBarChart barchart;
PieChart pieChart;


Author author;

void settings() {
  size(SCREENX, SCREENY, P3D);
}

void setup() {
  textSize(30);
  fill(0);
  backgroundPhoto = loadImage("background photo.jpg");
  backgroundPhotoLeaderBoards = loadImage("leaderboards photo.jpg");
  logoImage=loadImage("logo.png");
  yellowStar=loadImage("yellowStar.png");
  greyStar=loadImage("greyStar.png");
  widgetFont=loadFont("Arial-ItalicMT-17.vlw");
  searchbox=new Widget(SEARCHBOXX, SEARHBOXY, 345, 25, myText, color(255), widgetFont, EVENT_BUTTON1, 5, 5);
  leaderboardsButton=new Widget(LEADERBOARDSX, LEADERBOARDSY, 160, 50, "Leaderboards", color(150), widgetFont, EVENT_BUTTON3, 20, 20);
  homeButton=new Widget(HOMEX, HOMEY, 60, 60, logoImage, EVENT_BUTTON2);
  homeScreen=new Screen(backgroundPhoto, homescreenWidgets);
  leaderboardsScreen= new Screen(backgroundPhotoLeaderBoards, leaderboardsWidgets);
  topStars= new Widget(RADIOBUTTONX, TOPSTARSY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT, "Top star rating", color(255), widgetFont, EVENT_BUTTON4, 10, 10 );
  mostReviewed= new Widget(RADIOBUTTONX, MOSTREVIEWEDY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT, "Most reviewed", color(255), widgetFont, EVENT_BUTTON5, 10, 10 );
  topHundred= new Widget(RADIOBUTTONX, TOPHUNDREDY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT, "Top 100 rated", color(255), widgetFont, EVENT_BUTTON6, 10, 10 );
  mostUseful= new Widget(RADIOBUTTONX, MOSTUSEFULY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT, "Most useful", color(255), widgetFont, EVENT_BUTTON7, 10, 10 );
  funniest= new Widget(RADIOBUTTONX, FUNNIESTY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT, "Funniest", color(255), widgetFont, EVENT_BUTTON8, 10, 10 );
  coolest= new Widget(RADIOBUTTONX, COOLESTY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT, "Coolest", color(255), widgetFont, EVENT_BUTTON9, 10, 10 );   


  // font = loadFont("Cambria-20.vlw");
  font = loadFont("Calibri-BoldItalic-48.vlw");
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
  println(reviewerReviewMap.keySet());

  search.mostRecentReview(reviews);
  println(businessReviewMap.keySet());

  homeScreen.addWidget(searchbox);
  //homeScreen.addWidget(homeButton);
  homeScreen.addWidget(leaderboardsButton);
  leaderboardsScreen.addWidget(topStars);
  leaderboardsScreen.addWidget(mostReviewed);
  leaderboardsScreen.addWidget(searchbox);
  leaderboardsScreen.addWidget(topHundred);
  leaderboardsScreen.addWidget(mostUseful);
  leaderboardsScreen.addWidget(funniest);
  leaderboardsScreen.addWidget(coolest);
  currentScreen=homeScreen;
  recentReviews = initRecentReviewBoxes();
  //rb = new ReviewBox(100,100,150,300,"James","green spuds","asd as d s s ss s s s sas  dawd i ams a aso yeroas a sldkjahlw asoidja audkaka asd",4);
}


void draw() {
  background(255);

  currentScreen.draw();
  if (currentScreen==leaderboardsScreen) {
    fill(0);
    noStroke();
    rect(275, 150, 1, 550);
  }
  fill(0);
  blendMode(BLEND);
  stroke(30);
  strokeWeight(15);
  stroke(60);
  strokeWeight(10);
  stroke(100);
  strokeWeight(5);
  rect(0, 0, SCREENX, 70);


  searchbox.draw();
  homeButton.drawImage();
  //leaderboardsButton.draw();
  
  if (drawPieChart){
    pieChart.pieChart(100, author.type);
  }

  if (currentScreen == homeScreen) {
    noStroke();
    drawRecentReviewBoxes();
  }

  //draws the relevant bar chart
  if (drawGraph) {
    noStroke();
    if (goToGraph) {
      barchart.draw();
      for (int i=0; i<barchart.bars.length && !barchart.bars[i].drawBar(); i++) {
      }
    } else {
      fill(0);
      textSize(20);
      text("Sorry there are no ratings for this business.", 60, SCREENY/2);
    }
  }
}

void mouseMoved() {
  searchbox.setStroke(mouseX, mouseY);
  leaderboardsButton.setStroke(mouseX, mouseY);
    if (homeScreen.hover(mouseX, mouseY)){
    for (int i = 0; i < list.size(); i++) {
      if (list.get(i).authorPieChart.getEvent(mouseX, mouseY) != EVENT_NULL) {
        author = new Author(list.get(i).authorPieChart.myText);
        pieChart = new PieChart(int(list.get(i).authorPieChart.x+150), int(list.get(i).authorPieChart.y+50), author.type);
        drawPieChart = true;
      }
    }
  }
  else {
    drawPieChart = false;
  }
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

        currentScreen=leaderboardsScreen;

        ArrayList<Business> searchedBusinesses = search.searchBusinessList(searchbox.returnString());
        println(searchbox.myText);

        drawGraph = true;
        //draws the amount of the stars the business searched has if business is in data base
        displayBusinessStarsChart(searchedBusinesses);
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
    goToGraph=false;
    drawGraph = false;
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
    break;

  case EVENT_BUTTON4:
    currentScreen=leaderboardsScreen;
    displayTopRatedChart();
    goToGraph = true;
    drawGraph = true;
    break;

  case EVENT_BUTTON5:
    println("button 5");

    break;

  case EVENT_BUTTON6:
    println("button 6");

    break;

  case EVENT_BUTTON7:
    println("ibutton 7");

    break;

  case EVENT_BUTTON8:
    println("button 8");

    break;


  case EVENT_BUTTON9:
    println("button 9");

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


//initialises the 10 top rated businesses bar chart
void displayTopRatedChart() {
  drawGraph = true;
  goToGraph = true;
  Business[] topRatedBusinesses = search.getTopTenBusinesses();
  barchart = new BusinessBarChart(900, 700, topRatedBusinesses);
}

//initialises the business searched star chart
void displayBusinessStarsChart(ArrayList<Business> businessStarsList) {
  if (!businessStarsList.isEmpty()) {
    goToGraph = true;
  }
  if (goToGraph) {
    drawGraph = true;
    String name = businessStarsList.get(0).getBusinessName();
    int[] stars = search.getStarsForCollectionOfBusinesses(businessStarsList);
    barchart = new BusinessBarChart(900, 700, stars, name);
  }
}

// this method creates an arraylist of reviewBox containing the most recent reviews
ArrayList<ReviewBox> initRecentReviewBoxes() {
  ArrayList<Review> mostRecentReviews = search.mostRecentReview(reviews);
  list = new ArrayList<ReviewBox>();
  int x=50;
  int y=140;
  for (int i=0; i<=2; i++) {
    Review review = mostRecentReviews.get(i);
    ReviewBox rb = new ReviewBox(x, y, 380, 180, review.getAuthor(), review.getBusiness(), review.getText(), review.getStars());
    y+=186;
    list.add(rb);
  }
  return list;
}

// this method draws the arrayList that was created above
void drawRecentReviewBoxes() {
  for (int i=0; i<list.size(); i++) {
    list.get(i).draw();
  }
}