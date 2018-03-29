import controlP5.*;  //<>// //<>//

import peasy.PeasyCam;

import java.util.Set;
import java.util.HashSet;
import java.util.TreeMap;
import java.util.Map;
import java.util.Arrays;
import controlP5.*;
import java.util.*;

ArrayList<ReviewBox> recentReviews;
boolean canType=false, drawGraph = false, goToGraph = false, drawPieChart = false, drawLineChart = false, listReviews=false, showTopStars=false, showMostReviewed=false, showUseful=false, showFunny=false, showCool=false;

PFont stdFont;
PImage logoImage, searchImage, yellowStar, greyStar, backgroundPhoto, backgroundPhotoLeaderBoards, backgroundPhotoBusiness, halfStar;
Widget searchbox, searchButton, homeButton, leaderboardsButton, mostReviewed, topStars, topHundred, coolest, funniest, mostUseful, authorPieChart;
TitleBox recentReviewsHeader, topBusinessesHeader;
String myText = "Search...";  
String searchText, selected, rating, reviewAmount, totalReviewsForYear, selectedAC;
Screen currentScreen, homeScreen, leaderboardsScreen, businessScreen;
ArrayList<DataPoint> dataPoints;
ArrayList<Review> reviews;
ArrayList<Business> businesses = new ArrayList<Business>();
ArrayList<Screen> screens = new ArrayList<Screen>();
ArrayList<Widget> homescreenWidgets = new ArrayList<Widget>();
ArrayList<Widget> leaderboardsWidgets = new ArrayList<Widget>();
ArrayList<Widget> businessWidgets = new ArrayList<Widget>();
ArrayList<String> reviewsString, topBusinesses;
ArrayList<ReviewBox> listOfRecentReviews;
ArrayList<LeadersTable> leaderboardRungList;
ArrayList<Business> searchedBusinesses;
ArrayList<Business> reviewsPerMonth;

Table table;
PFont font, widgetFont, barFont, businessFont, autoCompleteFont;
Search search;
ControlP5 cp5;
ControlP5 cp5AutoComplete;
AutoComplete autoComplete;
String[] autoCompleteResults;
boolean autoCompleteOpen;

//charts/3D viewing - Claire
BusinessBarChart barchart;
LineGraph lineGraph;
PieChart pieChart;
PeasyCam cam;

int year;

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
  backgroundPhoto = loadImage("background photo.jpg");
  //backgroundPhotoLeaderBoards = loadImage("leaderboards photo.jpg");
  backgroundPhotoLeaderBoards = loadImage("buildingblur.png");
  backgroundPhotoBusiness= loadImage("businessscreen.png");
  logoImage=loadImage("logo.png");
  searchImage=loadImage("search.png");
  yellowStar=loadImage("yellowStar1small.png");
  greyStar=loadImage("greyStar1small.png");
  widgetFont=loadFont("Arial-ItalicMT-17.vlw");
  autoCompleteFont=loadFont("Candara-15.vlw");
  searchbox=new Widget(SEARCHBOXX, SEARCHBOXY, SEARCHBOXWIDTH, SEARCHBOXHEIGHT, myText, color(190), widgetFont, EVENT_BUTTON1, 5, 5);
  searchButton=new Widget(SEARCHBUTTONX, SEARCHBUTTONY, SEARCHBUTTONWIDTH, SEARCHBOXHEIGHT, "", color(0), widgetFont, EVENT_BUTTON10, 0, 0);
  leaderboardsButton=new Widget(LEADERBOARDSX, LEADERBOARDSY, 160, 50, "Leaderboards", color(190), widgetFont, EVENT_BUTTON3, 20, 20);
  homeButton=new Widget(HOMEX, HOMEY, 60, 60, logoImage, EVENT_BUTTON2);
  homeScreen=new Screen(backgroundPhoto, homescreenWidgets);
  leaderboardsScreen= new Screen(backgroundPhotoLeaderBoards, leaderboardsWidgets);
  businessScreen=new Screen(backgroundPhotoBusiness, businessWidgets);
  topStars= new Widget(RADIOBUTTONX, TOPSTARSY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT, "Top star rated", color(255), widgetFont, EVENT_BUTTON4, 10, 10 );
  mostReviewed= new Widget(RADIOBUTTONX, MOSTREVIEWEDY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT, "Most reviewed", color(255), widgetFont, EVENT_BUTTON5, 10, 10 );
  topHundred= new Widget(RADIOBUTTONX, TOPHUNDREDY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT, "Top 20 rated", color(255), widgetFont, EVENT_BUTTON6, 10, 10 );
  mostUseful= new Widget(RADIOBUTTONX, MOSTUSEFULY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT, "Most useful", color(255), widgetFont, EVENT_BUTTON7, 10, 10 );
  funniest= new Widget(RADIOBUTTONX, FUNNIESTY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT, "Funniest", color(255), widgetFont, EVENT_BUTTON8, 10, 10 );
  coolest= new Widget(RADIOBUTTONX, COOLESTY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT, "Coolest", color(255), widgetFont, EVENT_BUTTON9, 10, 10 );   
  selected=null;
  selectedAC = null;
  // font = loadFont("Cambria-20.vlw");
  font = loadFont("Calibri-BoldItalic-48.vlw");
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
  currentScreen=homeScreen;
  recentReviews = initRecentReviewBoxes();
  leaderboardRungList = initTopBusinesses();

  //ControlFont font = new ControlFont(widgetFont, 241);

  cp5 = new ControlP5(this);
  cp5.addScrollableList("TopTwenty")
    .setPosition(400, 80)
    .setSize(900, 750)             //size of full thing
    .setBarVisible(true)
    .setBarHeight(40)
    .setItemHeight(50)            //size of each box
    // .addItems(reviewsString)     add full reviews
    .open()
    .addItems(search.getTop20Businesses())
    //.setFont(widgetFont)
    .setScrollSensitivity(100.0)
    .setCaptionLabel("Top 20 rated businesses")
    .setColorCaptionLabel(HIGHLIGHT)
    .setColorBackground(REVIEWLISTCOLOR);
    
// controlP5 object for AutoComplete feature - Tom
  cp5AutoComplete = new ControlP5(this);
  cp5AutoComplete.addScrollableList("Autocomplete")
    .setPosition(AUTOCOMPLETE_X, AUTOCOMPLETE_Y)
    .setSize(SEARCHBOXWIDTH, 1000)
    .setBarVisible(false)
    .setItemHeight(AUTOCOMPLETE_QUERY_HEIGHT)
    .open()
    //.setFont(autoCompleteFont)
    .setColorCaptionLabel(HIGHLIGHT)
    .setColorBackground(REVIEWLISTCOLOR);
}


void draw() {
  background(255);
  fill(#0004B4);
  currentScreen.draw();
  if (currentScreen==leaderboardsScreen) {
    fill(0);
    noStroke();
    rect(275, 150, 1, 550);
  }
  fill(0);
  /*blendMode(BLEND);
   stroke(30);
   strokeWeight(15);
   stroke(60);
   strokeWeight(10);
   stroke(100);
   strokeWeight(5);*/
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
  line(465, 29, 475, 35);
  fill(0);
  noStroke();
  ellipse((SEARCHBUTTONX+SEARCHBUTTONWIDTH/2)-5, (SEARCHBUTTONY+SEARCHBOXHEIGHT/2), 15, 15);

  searchbox.draw();
  homeButton.drawImage();

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
    rect(797, 247, 456, 46);
    rect(97, 167, 386, 66);
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
    } else {
      stroke(#C62800);
      strokeWeight(5);
      fill(255);
      rect(410, (SCREENY/2)-80, 850, 200);
      fill(0);
      textSize(40);
      text("Sorry there are no ratings for this business.\nPlease try again.", 430, SCREENY/2);
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
    fill(HIGHLIGHT);
    rect(BUSINESSNAMEX-50, BUSINESSNAMEY+10, 900, 1);
    fill(255);
    textFont(font);
    text(searchbox.myText+"  "+rating, BUSINESSNAMEX, BUSINESSNAMEY);
    textSize(22);
    text("Amount of reviews \nof all time" + " = " + reviewAmount, BUSINESSNAMEX, BUSINESSNAMEY+90);
    text("Amount of reviews \nfor " + year + " = " + totalReviewsForYear, BUSINESSNAMEX, BUSINESSNAMEY+150);
  }
  selected = null;
  selectedAC = null;
}

void TopTwenty(int index) {
  selected = cp5.get(ScrollableList.class, "TopTwenty").getItem(index).get("name").toString();
}

// gets selected AutoComplete business name and enters it into search bar
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
    if (searchbox.myText!=null) {
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
    if (searchbox.myText.length() <=36) {
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
    break; 

  default:
    canType=false;
    listReviews=false;
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
    listReviews=false;
    break;

  case EVENT_BUTTON3:
    currentScreen=leaderboardsScreen;
    listReviews=true;
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

  default:
    if (drawGraph) {
      listReviews=false;
    } else {  
      listReviews=true;
    }
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
    DataPoint dp = new DataPoint(row.getString(0), row.getString(1), row.getString(2), row.getString(3), 
      row.getInt(4), row.getString(5), row.getString(6), row.getInt(7), row.getInt(8), row.getInt(9), row.getDouble(10), row.getDouble(11));
    dataPoints.add(dp);
  }
}


void loadReviewBusiness() {
  for (DataPoint dp : dataPoints) {
    String review=(dp.getUserName()+" "+dp.getUserId()+" "+dp.getBusinessName()+" "+dp.getBusinessId()+" "+dp.getStars()+"\n "+dp.getText()+"\n "+dp.getDate()+" "+dp.getUseful()+" "+dp.getFunny()+" "+dp.getCool());
    reviews.add(new Review(dp.getUserName(), dp.getUserId(), dp.getBusinessName(), dp.getBusinessId(), dp.getStars(), dp.getText(), dp.getDate(), dp.getUseful(), dp.getFunny(), dp.getCool()));
    reviewsString.add(review);
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
    drawLineChart = true;
    cam.setActive(true);
    String name = businessStarsList.get(0).getBusinessName();
    int[] stars = search.getStarsForCollectionOfBusinesses(businessStarsList);
    barchart = new BusinessBarChart(LEADERBOARDSGRAPHX-30, LEADERBOARDSGRAPHY+100, stars, name);
  }
}

//draws the line chart for amount of reviews per month per year for a particular business - Claire
String displayBusinessLineGraph(ArrayList<Business> reviewsPerMonth, int year) {
  lineGraph = new LineGraph(LEADERBOARDSGRAPHX+320, LEADERBOARDSGRAPHY+100, reviewsPerMonth, year);
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
  drawGraph = true;
  searchedBusinesses = search.searchBusinessList(searchbox.myText);
  if (searchedBusinesses.size() != 0||selected!=null) {
    year = 2016;
    listReviews = false;
    if (selected != null) {
      String[] businessDetails = selected.split("  ", -1);
      searchbox.myText=businessDetails[1];
      rating=businessDetails[2];
      searchedBusinesses = search.searchBusinessList(searchbox.myText);

      reviewsPerMonth = search.sortReviewsByMonth(searchedBusinesses.get(0), year);
      totalReviewsForYear = displayBusinessLineGraph(reviewsPerMonth, year);
      reviewAmount = Integer.toString(search.amountOfReviews(searchbox.myText.toLowerCase()));
    } else {
      reviewsPerMonth = search.sortReviewsByMonth(searchedBusinesses.get(0), year);
      totalReviewsForYear = displayBusinessLineGraph(reviewsPerMonth, year);
      reviewAmount = Integer.toString(search.amountOfReviews(searchbox.myText.toLowerCase()));
      rating = Double.toString(search.getAverageStarsOfBusiness(searchedBusinesses.get(0).getBusinessName()));
    }
  } 
  //draws the amount of the stars the business searched has if business is in data base - Claire
  displayBusinessStarsChart(searchedBusinesses);
  
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