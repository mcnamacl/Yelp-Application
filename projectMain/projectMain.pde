import controlP5.*;   //<>//
import peasy.PeasyCam;
import java.util.Set;
import java.util.HashSet;
import java.util.TreeMap;
import java.util.Map;
import java.util.Arrays;
import controlP5.*;
import java.util.*;

boolean canType=false, drawGraph = false, goToGraph = false, drawPieChart = false, drawLineChart = false, drawStarChart=false, listReviews=false, showTopStars=false, showMostReviewed=false, showUseful=false, showFunny=false, 
        showCool=false, businessFound=false, drawMap = false, autoCompleteOpen; // <==== to draw map onto home screen change to true ;

int year;

String myText = "Search...";  
String searchText, selected, rating, reviewAmount, totalReviewsForYear, selectedAC, selectedReview, businessName;
        
PImage logoImage, searchImage, yellowStar, greyStar, backgroundPhoto, backgroundPhotoLeaderBoards, backgroundPhotoBusiness, halfStar;

Widget searchbox, searchButton, homeButton, leaderboardsButton, authorPieChart;//, barChartGraph, lineChartGraph;
RadioButton mostReviewed, topStars, topHundred, coolest, funniest, mostUseful, barChartGraph, lineChartGraph;
TitleBox recentReviewsHeader, topBusinessesHeader;
Screen currentScreen, homeScreen, leaderboardsScreen, businessScreen;

ArrayList<DataPoint> dataPoints;
ArrayList<Review> reviews;
ArrayList<Screen> screens = new ArrayList<Screen>();
ArrayList<Widget> homescreenWidgets = new ArrayList<Widget>();
ArrayList<Widget> leaderboardsWidgets = new ArrayList<Widget>();
ArrayList<Widget> businessWidgets = new ArrayList<Widget>();
ArrayList<String> reviewsString, topBusinesses;
ArrayList<String>reviewHeaders;
ArrayList<String>reviewTexts;
ArrayList<LeadersTable> leaderboardRungList;
ArrayList<Business> businesses = new ArrayList<Business>();
ArrayList<Business> searchedBusinesses;
ArrayList<Business> reviewsPerMonth;
ArrayList<ReviewBox> recentReviews;
ArrayList<ReviewBox> listOfRecentReviews;
Table table;
String[] autoCompleteResults;

PFont font, widgetFont, barFont, businessFont, autoCompleteFont;

Search search;
ControlP5 cp5;
ControlP5 cp5AutoComplete;
ControlP5 cp5Reviews;
AutoComplete autoComplete;

WorldMap map;

//charts/3D viewing - Claire
BusinessBarChart barchart;
LineGraph lineGraph;
PieChart pieChart;
PeasyCam cam;

PApplet mainClass = this;

Author author;



void settings() {
  size(SCREENX, SCREENY, P3D);
}

void setup() {  
  textSize(30);
  fill(0);

  cam = new PeasyCam(mainClass, SCREENX/2, SCREENY/2, 0, 780);
  cam.setActive(false);

  halfStar = loadImage("halfStar1small.png");
  backgroundPhoto = loadImage("backgroundblur.jpg");
  backgroundPhotoLeaderBoards = loadImage("buildingblur.png");
  backgroundPhotoBusiness= loadImage("businessscreen.png");
  logoImage=loadImage("logo.png");
  searchImage=loadImage("search.png");
  yellowStar=loadImage("yellowStar1small.png");
  greyStar=loadImage("greyStar1small.png");
  
  widgetFont=loadFont("Arial-ItalicMT-17.vlw");
  autoCompleteFont=loadFont("Candara-15.vlw");
  font = loadFont("Calibri-BoldItalic-48.vlw");
  
  searchbox=new Widget(SEARCHBOXX, SEARCHBOXY, SEARCHBOXWIDTH, SEARCHBOXHEIGHT, myText, color(190), widgetFont, EVENT_BUTTON1, 5, 5);
  searchButton=new Widget(SEARCHBUTTONX, SEARCHBUTTONY, SEARCHBUTTONWIDTH, SEARCHBOXHEIGHT, "", color(0), widgetFont, EVENT_BUTTON10, 0, 0);
  leaderboardsButton=new Widget(LEADERBOARDSX, LEADERBOARDSY, 160, 50, "Leaderboards", color(190), widgetFont, EVENT_BUTTON3, 20, 20);
  homeButton=new Widget(HOMEX, HOMEY, 60, 60, logoImage, EVENT_BUTTON2);
  homeScreen=new Screen(backgroundPhoto, homescreenWidgets);
  leaderboardsScreen= new Screen(backgroundPhotoLeaderBoards, leaderboardsWidgets);
  businessScreen=new Screen(backgroundPhotoBusiness, businessWidgets);
  topStars= new RadioButton(RADIOBUTTONX, TOPSTARSY, LEADERBOARDSBUTTONWIDTH, LEADERBOARDSBUTTONHEIGHT, "Top star rated", color(255), widgetFont, EVENT_BUTTON4, 10, 10 );
  mostReviewed= new RadioButton(RADIOBUTTONX, MOSTREVIEWEDY, LEADERBOARDSBUTTONWIDTH, LEADERBOARDSBUTTONHEIGHT, "Most reviewed", color(255), widgetFont, EVENT_BUTTON5, 10, 10 );
  topHundred= new RadioButton(RADIOBUTTONX, TOPHUNDREDY, LEADERBOARDSBUTTONWIDTH, LEADERBOARDSBUTTONHEIGHT, "Top 20 rated", color(255), widgetFont, EVENT_BUTTON6, 10, 10 );
  mostUseful= new RadioButton(RADIOBUTTONX, MOSTUSEFULY, LEADERBOARDSBUTTONWIDTH, LEADERBOARDSBUTTONHEIGHT, "Most useful", color(255), widgetFont, EVENT_BUTTON7, 10, 10 );
  funniest= new RadioButton(RADIOBUTTONX, FUNNIESTY, LEADERBOARDSBUTTONWIDTH, LEADERBOARDSBUTTONHEIGHT, "Funniest", color(255), widgetFont, EVENT_BUTTON8, 10, 10 );
  coolest= new RadioButton(RADIOBUTTONX, COOLESTY, LEADERBOARDSBUTTONWIDTH, LEADERBOARDSBUTTONHEIGHT, "Coolest", color(255), widgetFont, EVENT_BUTTON9, 10, 10 );
  barChartGraph= new RadioButton(BARCHARTBUTTONX, BARCHARTBUTTONY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT,"Bar Chart", color(255), autoCompleteFont, EVENT_BUTTON13,12,10);
  lineChartGraph = new RadioButton(LINECHARTBUTTONX, LINECHARTBUTTONY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT,"Line Chart", color(255), widgetFont, EVENT_BUTTON14,5,10);
  
  selected=null;
  selectedAC = null;
  selectedReview=null;

  dataPoints = new ArrayList<DataPoint>();
  table = loadTable("reviews.csv", "header");
  reviews = new ArrayList<Review>();
  businesses = new ArrayList<Business>();
  businessNames = new HashSet<String>();
  businessReviewMap = new TreeMap<String, ArrayList<Review>>();
  reviewerReviewMap = new TreeMap<String, ArrayList<Review>>();
  //businessAmountOfReviews = new <String, Integer>();
  //reviewerNames = new HashSet<String>();
  reviewerIds = new HashSet<String>();
  reviewsString = new ArrayList<String>();
  reviewHeaders= new ArrayList<String>();
  reviewTexts= new ArrayList<String>();
  searchedBusinesses  = new ArrayList<Business>();
  reviewsPerMonth = new ArrayList<Business>();

  loadData();
  loadReviewBusiness();
  search = new Search();
  search.createBusinessAZMap();
  search.createReviewerMap();
  println(reviewerReviewMap.keySet());

  autoComplete = new AutoComplete(businessReviewMap.keySet());
  autoCompleteOpen = false;

  search.mostRecentReview(reviews);
  println(businessReviewMap.keySet());

  homeScreen.addWidget(searchbox);
  homeScreen.addWidget(searchButton);
  homeScreen.addWidget(leaderboardsButton);
  leaderboardsScreen.addWidget(searchButton);
  leaderboardsScreen.addWidget(searchbox);
  leaderboardsScreen.addWidget(topStars);
  leaderboardsScreen.addWidget(mostReviewed);
  leaderboardsScreen.addWidget(topHundred);
  leaderboardsScreen.addWidget(mostUseful);
  leaderboardsScreen.addWidget(funniest);
  leaderboardsScreen.addWidget(coolest);
  businessScreen.addWidget(searchbox);
  businessScreen.addWidget(searchButton);
  businessScreen.addWidget(barChartGraph);
  businessScreen.addWidget(lineChartGraph);
  currentScreen=homeScreen;
  recentReviews = initRecentReviewBoxes();
  leaderboardRungList = initTopBusinesses();


  cp5 = new ControlP5(this);
  cp5.addScrollableList("TopTwenty")
    .setPosition(400, 120)
    .setSize(900, 725)             
    .setBarVisible(true)
    .setBarHeight(40)
    .setItemHeight(50)           
    .open()
    .addItems(search.getTop20Businesses())
    .setFont(widgetFont)
    .setScrollSensitivity(200.0)
    .setCaptionLabel("Top 20 rated businesses")
    .setColorForeground(HIGHLIGHT_LIST)
    .setColorBackground(REVIEWLISTCOLOR);
  
    
  cp5Reviews = new ControlP5(this);  
  cp5Reviews.addScrollableList("Reviews")
    .setPosition(BUSINESSREVIEWSX, BUSINESSREVIEWSY)
    .setSize(REVIEWTEXTWIDTH,400)
    .setItemHeight(28)
    .setBarHeight(30)
    .setFont(widgetFont)
    .setScrollSensitivity(200.0)
    .setCaptionLabel("Reviews")
    .setColorForeground(HIGHLIGHT_LIST)
    .setColorBackground(REVIEWLISTCOLOR)
    .hide();

  // controlP5 object for AutoComplete feature - Tom
  cp5AutoComplete = new ControlP5(this);
  cp5AutoComplete.addScrollableList("Autocomplete")
    .setPosition(AUTOCOMPLETE_X, AUTOCOMPLETE_Y)
    .setSize(SEARCHBOXWIDTH, 1000)
    .setBarVisible(false)
    .setItemHeight(AUTOCOMPLETE_QUERY_HEIGHT)
    .open()
    .setFont(autoCompleteFont)
    .setColorForeground(HIGHLIGHT_LIST)
    .setColorBackground(REVIEWLISTCOLOR);

  map = new WorldMap();
}


void draw() {
  background(255);
  fill(#0004B4);
  currentScreen.draw();
  if (currentScreen==leaderboardsScreen) {
    fill(HIGHLIGHT);
    noStroke();
    rect(275, 150, 1, 550);
  }
  fill(100);
  noStroke();
  rect(0, 70, SCREENX, 5);
  fill(0);
  rect(0, 0, SCREENX, 70);
  //below is making the search button image thing, rather than actually importing an image
  fill(255);
  noStroke();
  ellipse((SEARCHBUTTONX+SEARCHBUTTONWIDTH/2)-5, (SEARCHBUTTONY+SEARCHBOXHEIGHT/2), 20, 20);
  stroke(255);
  strokeWeight(3);
  fill(255);
  line(487, 29, 497, 35);
  fill(0);
  noStroke();
  ellipse((SEARCHBUTTONX+SEARCHBUTTONWIDTH/2)-5, (SEARCHBUTTONY+SEARCHBOXHEIGHT/2), 15, 15);

  searchbox.draw();
  homeButton.drawImage();

  autoCompleteOpen = false;

  //draws the pie chart for a user - Claire
  if (drawPieChart) {
    pieChart.pieChart(100, author.type);
  }

  if (currentScreen == homeScreen) {
    noStroke();
    drawRecentReviewBoxes();
    drawTopBusinessTable();
    cam.setActive(false);
    listReviews=false;
    fill(HIGHLIGHT, 180);
    noStroke();
    rect(797,247,456,46);
    rect(97,167,386,66);
    drawRecentReviewBoxes();
    drawTopBusinessTable();
  }

  //draws the relevant bar chart - Claire
  if (drawGraph) {
    noStroke();
    if (goToGraph) {
      barchart.draw();
      if (drawLineChart) {
        lineGraph.drawLineGraph();
      }
      for (int i=0; i<barchart.bars.length && !barchart.bars[i].drawBar(); i++) {
      }
    } 
  }
  
  if (!listReviews) {
    cp5.hide();
  } else if (listReviews) {
    cp5.show();
  }
  if (canType) {
    searchbox.setSearchboxColor(255);
  } else if (!canType) {
    searchbox.setSearchboxColor(190);
  }

  if (selectedAC!=null) {
    searchbox.myText = selectedAC;
  }

  if (selected!= null) {                                                                                              
    displayBusinessScreen();
  }
   
  if (currentScreen==businessScreen) {
    if(businessFound==false){                                                               
      stroke(#C62800);
      strokeWeight(5);
      fill(255);
      rect(320, (SCREENY/2)-80, 720, 200);
      fill(0);
      textFont(font);
      text("Sorry this business doesn't exist.\nPlease try again.", 355, (SCREENY/2)+10);
      return;
    }
    if(drawStarChart){
     // drawGraph=true;
      displayBusinessStarsChart(searchedBusinesses);
    }
    if(drawLineChart){
      //drawGraph=true;
      lineGraph.drawLineGraph();
    }
    drawStarChart=false;
    fill(0,130);  //rectangle behind review text
    noStroke();
    rect(BUSINESSREVIEWSX,BUSINESSREVIEWSY,REVIEWTEXTWIDTH,720); 
  if(selectedReview!=null){
    fill(255);
    textSize(17);
    text(selectedReview,BUSINESSREVIEWSX+10,BUSINESSNAMEY+100,REVIEWTEXTWIDTH-10,725);    
  } 
    if(overReviews()){
      cam.setActive(false);
    }
    else if(!overReviews()){
      cam.setActive(true);
    }
    cp5.get(ScrollableList.class, "TopTwenty").hide();
    //cp5Reviews.get(ScrollableList.class, "Reviews").setCaptionLabel("Reviews");
    fill(HIGHLIGHT);
    rect(BUSINESSREVIEWSX, BUSINESSNAMEY+10,REVIEWTEXTWIDTH, 2);
    cp5Reviews.get(ScrollableList.class, "Reviews").show();
    fill(255);
    textFont(font);
    textSize(40);
    text(businessName+"  "+rating+"*", BUSINESSNAMEX, BUSINESSNAMEY);
    textSize(19);
    //text("Amount of reviews \nof all time" + " = " + reviewAmount, BUSINESSNAMEX, BUSINESSNAMEY+700);                      
    //text("Amount of reviews \nfor " + year + " = " + totalReviewsForYear, BUSINESSNAMEX, BUSINESSNAMEY+725);
  }
  selected = null;
  selectedAC = null;
  if (drawMap) {
    map.drawMap();
  }
}

void TopTwenty(int index) {
  selected = cp5.get(ScrollableList.class, "TopTwenty").getItem(index).get("name").toString();                                           
}

void Reviews(int index){
  //int selectedReviewIndex = cp5Reviews.get(ScrollableList.class, "Reviews").getItem(index);
  //text(reviewTexts.get(index),BUSINESSNAMEX,BUSINESSNAMEY+100,800,800);
  selectedReview=reviewTexts.get(index);
}

void Autocomplete(int index) {
  selectedAC = cp5AutoComplete.get(ScrollableList.class, "Autocomplete").getItem(index).get("name").toString();
  canType = true;
}

void mouseMoved() {
  searchbox.setStroke(mouseX, mouseY);
  leaderboardsButton.setStroke(mouseX, mouseY);

  //gets the piechart for a reviewer if the mouse is hovered over their name - Claire
  if (homeScreen.hover(mouseX, mouseY)) {
    for (int i = 0; i < listOfRecentReviews.size(); i++) {
      if (listOfRecentReviews.get(i).authorPieChart.getEvent(mouseX, mouseY) != EVENT_NULL) {
        author = new Author(listOfRecentReviews.get(i).reviewerId);
        pieChart = new PieChart(int(listOfRecentReviews.get(i).authorPieChart.x+150), int(listOfRecentReviews.get(i).authorPieChart.y+50), author.type());
        drawPieChart = true;
      }
    }
  } else {
    drawPieChart = false;
  }
}

void keyPressed() {
  if (canType) {
    if(searchbox.myText!=null){
      cp5AutoComplete.get(ScrollableList.class, "Autocomplete").show();
    }
    if (key == DELETE) {
      searchbox.myText = "";
      cp5AutoComplete.get(ScrollableList.class, "Autocomplete").hide();
    } else if (key == BACKSPACE) {
      if (searchbox.myText.length()-1 <= 0) {
        searchbox.myText = "";
        cp5AutoComplete.get(ScrollableList.class, "Autocomplete").hide();
      } else if (searchbox.myText.length() > 0) {
        searchbox.myText = searchbox.myText.substring(0, searchbox.myText.length()-1);
        autoCompleteResults = autoComplete.getMatches(searchbox.myText);

        if (searchbox.myText.length() > 0) {
          cp5AutoComplete.get(ScrollableList.class, "Autocomplete").show();
          cp5AutoComplete.get(ScrollableList.class, "Autocomplete").setItems(autoCompleteResults);
          cp5AutoComplete.get(ScrollableList.class, "Autocomplete").open();
        }
      }
    } 
    else if (searchbox.myText.length() <=36) {
      if (key != ENTER && keyCode>=32 && keyCode<=223) {
        searchbox.myText =searchbox.myText + key;
        autoCompleteResults = autoComplete.getMatches(searchbox.myText);

        if (searchbox.myText.length() > 0) {
          cp5AutoComplete.get(ScrollableList.class, "Autocomplete").show();
          cp5AutoComplete.get(ScrollableList.class, "Autocomplete").setItems(autoCompleteResults);
          cp5AutoComplete.get(ScrollableList.class, "Autocomplete").open();
        }
      }
      if (key == ENTER) {
        prepareBusinessReviews(searchbox.myText);                                                                            
        displayBusinessScreen();
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
    listReviews=false;
    selected=null;
    cp5AutoComplete.get(ScrollableList.class, "Autocomplete").hide();
    cp5Reviews.get(ScrollableList.class, "Reviews").hide();
    break; 

  default:
    canType=false;
   // listReviews=false;
    if (searchbox.myText=="") {
      searchbox.myText="Search...";
    }
    cp5AutoComplete.get(ScrollableList.class, "Autocomplete").hide();
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
    currentScreen=leaderboardsScreen;
    listReviews=true;
    cp5.get(ScrollableList.class, "TopTwenty").show();
    cp5.get(ScrollableList.class, "TopTwenty").open();
    cp5.get(ScrollableList.class, "TopTwenty").setCaptionLabel("Top 20 rated businesses");
    break;

  case EVENT_BUTTON4:
    currentScreen=leaderboardsScreen;
    displayTopRatedChart();
    goToGraph = true;
    drawGraph = true;
    drawLineChart = false;
    listReviews=false;
    break;

  case EVENT_BUTTON5:
    println("most reviewed");  
    displayMostReviewed();
    listReviews=false;    
    drawLineChart = false;
    break;

  case EVENT_BUTTON6:
    println("top 20 rated");
    cp5.get(ScrollableList.class, "TopTwenty").open();
    cp5.get(ScrollableList.class, "TopTwenty").setCaptionLabel("Top 20 rated businesses");
    listReviews=true;
    cam.setActive(false);
    drawGraph=false;
    break;

  case EVENT_BUTTON7:
    println("most useful");
    displayUsefulChart();
    for (Review review : search.sortByUseful()) {
      println(review.getAuthor() + review.getUseful());
    }
    listReviews=false;
    drawLineChart = false;

    break;

  case EVENT_BUTTON8:
    println("funniest");
    displayFunniestChart();
    for (Review review : search.sortByFunny()) {
      println(review.getAuthor() + review.getFunny());
    }
    listReviews=false;
    drawLineChart = false;

    break;


  case EVENT_BUTTON9:
    println("coolest");
    displayCoolChart();
    for (Review review : search.sortByCool()) {
      println(review.getAuthor() + review.getCool());
    }
    listReviews=false;
    drawLineChart = false;

    break;

  case EVENT_BUTTON10:
    listReviews=false;
    drawLineChart = false;

    canType=false;
    if (searchbox.myText=="Search..." ) {
      break;
    } else {
      prepareBusinessReviews(searchbox.myText);                                                                                            
      displayBusinessScreen();
      break;
    }

  case EVENT_BUTTON11:
    for (int i = 0; i < listOfRecentReviews.size(); i++) {
      if (listOfRecentReviews.get(i).businessButton.getEvent(mouseX, mouseY) != EVENT_NULL) {
        searchbox.myText = listOfRecentReviews.get(i).getBusinessName();
        displayBusinessScreen();
      }
    }
    break;

  case EVENT_BUTTON12:
    for (int i = 0; i < leaderboardRungList.size(); i++) {
      if (leaderboardRungList.get(i).rowInTable.getEvent(mouseX, mouseY) != EVENT_NULL) {
        searchbox.myText = leaderboardRungList.get(i).getBusinessName();
        displayBusinessScreen();
      }
    }
    break;
  
  case EVENT_BUTTON13:
    drawGraph=false;
    drawStarChart=true;                                                                                               
    drawLineChart = false;

    break;
    
  case EVENT_BUTTON14:
    drawGraph=false;
    drawStarChart=false;
    drawLineChart = true;
    break;
    
 default:
    if (drawGraph) {
      listReviews=false;
    } else {  
      listReviews=true;
    }
    //println(listReviews);
    canType=false;
    if (searchbox.myText=="") {
      searchbox.myText="Search...";
    }
    cp5AutoComplete.get(ScrollableList.class, "Autocomplete").hide();
    break;
  }
}


void loadData() {
  for (TableRow row : table.rows()) {
    DataPoint dp = new DataPoint(row.getString(0), row.getString(1), row.getString(2), row.getString(3),  row.getInt(4), row.getString(5), row.getString(6), row.getInt(7), row.getInt(8), row.getInt(9), row.getFloat(10), row.getFloat(11));
    dataPoints.add(dp);
  }
}


void loadReviewBusiness() {
  for (DataPoint dp : dataPoints) {
    reviews.add(new Review(dp.getUserName(), dp.getUserId(), dp.getBusinessName(), dp.getBusinessId(), dp.getStars(), dp.getText(), dp.getDate(), dp.getUseful(), dp.getFunny(), dp.getCool()));
    businesses.add(new Business(dp.getBusinessName(), dp.getBusinessId(), dp.getLongitude(), dp.getLatitude()));
  }
}


//initialises the 10 top rated businesses bar chart and sets the screen into 3D viewing mode - Claire
void displayTopRatedChart() {
  cam.setActive(true);
  drawGraph = true;
  goToGraph = true;
  Business[] topRatedBusinesses = search.getTopTenBusinesses();
  barchart = new BusinessBarChart(LEADERBOARDSGRAPHX, LEADERBOARDSGRAPHY, topRatedBusinesses, "topBusinesses");
}

//initialises the funniest review bar chart and sets the screen into 3D viewing mode - Claire
void displayFunniestChart() {
  cam.setActive(true);
  drawGraph = true;
  goToGraph = true;
  Review[] funniest = search.sortByFunny();
  barchart = new BusinessBarChart(LEADERBOARDSGRAPHX, LEADERBOARDSGRAPHY, funniest, "funny");
}

//initialises the most useful review bar chart and sets the screen into 3D viewing mode - Claire
void displayUsefulChart() {
  cam.setActive(true);
  drawGraph = true;
  goToGraph = true;
  Review[] useful = search.sortByUseful();
  barchart = new BusinessBarChart(LEADERBOARDSGRAPHX, LEADERBOARDSGRAPHY, useful, "useful");
}

//initialises the coolest review bar chart and sets the screen into 3D viewing mode - Claire
void displayCoolChart() {
  cam.setActive(true);
  drawGraph = true;
  goToGraph = true;
  Review[] cool = search.sortByCool();
  barchart = new BusinessBarChart(LEADERBOARDSGRAPHX, LEADERBOARDSGRAPHY, cool, "cool");
}

//initialises the most reviewed bar chart and sets the screen into 3D viewing mode - Claire
void displayMostReviewed() {
  cam.setActive(true);
  drawGraph = true;
  goToGraph = true;
  Business[] mostReviewed = search.mostReviewed();
  barchart = new BusinessBarChart(LEADERBOARDSGRAPHX, LEADERBOARDSGRAPHY, mostReviewed, "mostReviewed");
}

//initialises the business searched star chart and sets the screen into 3D viewing mode - Claire
void displayBusinessStarsChart(ArrayList<Business> businessStarsList) {
  if (businessStarsList.size() != 0) {
    goToGraph = true;
  }
  if (goToGraph) {
    drawGraph = true;
    drawLineChart = false;                                                                                                                                            
    cam.setActive(true);
    String name = businessStarsList.get(0).getBusinessName();
    int[] stars = search.getStarsForCollectionOfBusinesses(businessStarsList);
    barchart = new BusinessBarChart(BUSINESSSTARSX, BUSINESSSTARSY, stars, name);
  }
}

//draws the line chart for amount of reviews per month per year for a particular business - Claire
String displayBusinessLineGraph(ArrayList<Business> reviewsPerMonth, int year) {
  lineGraph = new LineGraph(LINECHARTX, LINECHARTY, reviewsPerMonth, year);
  return lineGraph.amountOfReviews();
}

// this method creates an arraylist of reviewBox containing the most recent reviews
ArrayList<ReviewBox> initRecentReviewBoxes() {
  ArrayList<Review> mostRecentReviews = search.mostRecentReview(reviews);
  listOfRecentReviews = new ArrayList<ReviewBox>();
  int x=100;
  int y=270;
  recentReviewsHeader = new TitleBox(x, y-100, 380, 60, 25, 25, color(255, 0, 0, 127), DEFAULT_TEXT_COLOUR, DEFAULT_TEXT_COLOUR, font, "Most Recent Reviews", 5);
  recentReviewsHeader = new TitleBox(x, y-100, 380, 60, 25, 25, color(HIGHLIGHT, 127), DEFAULT_TEXT_COLOUR, color(255), font, "Most Recent Reviews", 5);
  for (int i=0; i<=2; i++) {
    //println(mostRecentReviews);
    Review review = mostRecentReviews.get(i);
    ReviewBox rb = new ReviewBox(x, y, 380, 180, review.getAuthor(), review.getAuthorId(), review.getBusiness(), review.getText(), review.getStars());
    y+=186;
    listOfRecentReviews.add(rb);
  }
  return listOfRecentReviews;
}

// this method draws the arrayList that was created above
void drawRecentReviewBoxes() {
  recentReviewsHeader.draw();
  for (int i=0; i<listOfRecentReviews.size(); i++) {
    listOfRecentReviews.get(i).draw();
  }
}


void displayBusinessScreen() {
  currentScreen=businessScreen;
  searchedBusinesses = search.searchBusinessList(searchbox.myText);
  drawGraph = true;
  println(searchbox.myText);
  if (searchedBusinesses==null || selected==null) {
      businessFound=false;
  }
  if (searchedBusinesses.size() != 0||selected!=null) {
    businessFound=true;
    year = 2016;
    listReviews = false;
    if (selected != null) {
      String[] businessDetails = selected.split("  ", -1);
      searchbox.myText=businessDetails[1];
      prepareBusinessReviews(searchbox.myText);
      rating=businessDetails[2];
      searchedBusinesses = search.searchBusinessList(searchbox.myText);

      reviewsPerMonth = search.sortReviewsByMonth(searchedBusinesses.get(0), year);
      totalReviewsForYear = displayBusinessLineGraph(reviewsPerMonth, year);
      reviewAmount = Integer.toString(search.amountOfReviews(searchbox.myText.toLowerCase()));
    } else {
      prepareBusinessReviews(searchbox.myText);
      reviewsPerMonth = search.sortReviewsByMonth(searchedBusinesses.get(0), year);
      totalReviewsForYear = displayBusinessLineGraph(reviewsPerMonth, year);
      reviewAmount = Integer.toString(search.amountOfReviews(searchbox.myText.toLowerCase()));
      rating = Double.toString(search.getAverageStarsOfBusiness(searchedBusinesses.get(0).getBusinessName()));
    }
   businessName=searchbox.myText;  //permanents the business name on business screen
  } 

//draws the amount of the stars the business searched has if business is in data base - Claire
  displayBusinessStarsChart(searchedBusinesses);                                                            
 println(searchbox.myText);                                                                                 
  //draws the amount of the stars the business searched has if business is in data base - Claire
  for (Business business : searchedBusinesses) {
    println(business.searchedFor);
    business.searchedFor = true;
  }
  println(searchbox.myText);
}

// this method creates an arraylist of leaderboard rungs containing the highest rated businesses-Ruairi
ArrayList<LeadersTable> initTopBusinesses() {
  Business[] topBusinesses = search.getTop15Businesses();
  leaderboardRungList = new ArrayList<LeadersTable>();
  int ranking = 1;
  int x=800;
  int y=320;
  topBusinessesHeader = new TitleBox(x, y-70, 450, 40, 20, 20, color(HIGHLIGHT, 127), DEFAULT_TEXT_COLOUR, color(255), font, "Top Rated Businesses", 5);
  for (int i=0; i<topBusinesses.length; i++) {
    String currentBusinessName = topBusinesses[i].getBusinessName();
    //if business name is too long to fit in row, following method will decrease its size
    if (currentBusinessName.length()>=29) {
      currentBusinessName = currentBusinessName.substring(0, Math.min(currentBusinessName.length(), 28));
      currentBusinessName+="..";
    }
    LeadersTable rung = new LeadersTable(x, y, ranking, currentBusinessName, topBusinesses[i].getAverageStarsOfBusiness());
    ranking++;
    y+=30;
    leaderboardRungList.add(rung);
  }
  return leaderboardRungList;
}


// this method draws the arrayList that was created above-Ruairi
void drawTopBusinessTable() {
  topBusinessesHeader.draw();
  for (int i=0; i<leaderboardRungList.size(); i++) {
    leaderboardRungList.get(i).draw();
  }
}


boolean overReviews(){
  boolean canScroll=false;
  if(mouseX>=BUSINESSREVIEWSX && mouseX<= BUSINESSREVIEWSX+900 && mouseY >= BUSINESSREVIEWSY && mouseY<=BUSINESSREVIEWSY+700){
  //cam.setActive(false);
    canScroll=true;
  }
  return canScroll;
}




void prepareBusinessReviews(String businessName){
 drawStarChart=true;
 selectedReview=null;
 reviewTexts.clear();
 reviewHeaders.clear();
 String reviewHeader="";
 String reviewText="";
 for(Review review : search.getReviewsForBusiness(businessName)){
   reviewHeader=(review.getDate()+"  "+review.getAuthor()+"  "+review.getStars()+"*");
   reviewHeaders.add(reviewHeader);
   reviewText=review.getText();
   reviewTexts.add(reviewText);  
 }
 cp5Reviews.get(ScrollableList.class, "Reviews").clear();                                                      
 cp5Reviews.get(ScrollableList.class, "Reviews").addItems(reviewHeaders); 
 cp5Reviews.get(ScrollableList.class, "Reviews").setCaptionLabel("Reviews");
 cp5Reviews.get(ScrollableList.class, "Reviews").open();
}