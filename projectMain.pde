import controlP5.*;   //<>// //<>// //<>//
import peasy.PeasyCam;
import java.util.Set;
import java.util.HashSet;
import java.util.TreeMap;
import java.util.Map;
import java.util.Arrays;
import controlP5.*;
import java.util.*;

boolean canType=false, drawGraph = false, goToGraph = false, drawPieChart = false, drawLineChart = false, drawStarChart=false, listTopTwenty=false, showTopStars=false, showMostReviewed=false, showUseful=false, showFunny=false, 
  showCool=false, businessFound=false, drawScreen=true, drawMap = false; 

int year;

String myText = "Search...";  
String searchText, selectedBusiness, rating, reviewAmount, totalReviewsForYear, selectedAC, selectedReview, businessName, selectedAuthor, selectedAuthorId, header;

PImage logoImage, searchImage, yellowStar, greyStar, backgroundPhoto, backgroundPhotoLeaderBoards, backgroundPhotoBusiness, halfStar;

Widget searchbox, searchButton, homeButton, leaderboardsButton, authorPieChart, previousYear, nextYear;
RadioButton mostReviewed, topStars, topTwenty, coolest, funniest, mostUseful, mapButton, barChartGraph, lineChartGraph;
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
ArrayList<String> reviewerIdsForPieChart = new ArrayList<String>();
ArrayList<String> reviewerNamesForProfile = new ArrayList<String>();
ArrayList<LeadersTable> leaderboardRungList;
ArrayList<Business> businesses = new ArrayList<Business>();
ArrayList<Business> searchedBusinesses;
ArrayList<Business> reviewsPerMonth;
ArrayList<ReviewBox> recentReviews;
ArrayList<ReviewBox> listOfRecentReviews;
Table table;
String[] autoCompleteResults;

PFont font, widgetFont, barFont, businessFont, autoCompleteFont, reviewerProfileFont, reviewerProfileHeaderFont, reviewFont;

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

Bubble[] bubbles = new Bubble[5];
;


void settings() {
  size(SCREENX, SCREENY, P3D);
}

void setup() {  
  textSize(30);
  fill(0);

  cam = new PeasyCam(mainClass, SCREENX/2, SCREENY/2, 0, 780);
  // sets rotation axis
  cam.setYawRotationMode();   // like spinning a globe 3d
  // cam.setRollRotationMode();  // rotate sideways ( not 3d )
  // cam.setSuppressRollRotationMode();  // any direction 3d.
  cam.setActive(false);

  halfStar = loadImage("halfStar1small.png");
  backgroundPhoto = loadImage("backgroundblur.jpg");
  backgroundPhotoLeaderBoards = loadImage("buildingblur.png");
  backgroundPhotoBusiness= loadImage("businessscreen.png");
  logoImage=loadImage("logo.png");
  searchImage=loadImage("search.png");
  yellowStar=loadImage("yellowStar1small.png");
  greyStar=loadImage("greyStar1small.png");

  widgetFont=loadFont("Sylfaen-16.vlw");
  autoCompleteFont=loadFont("Candara-15.vlw");
  font = loadFont("Calibri-BoldItalic-48.vlw");
  reviewerProfileFont = loadFont("Arial-BoldMT-25.vlw");
  reviewerProfileHeaderFont = loadFont("Arial-ItalicMT-25.vlw");
  reviewFont = loadFont("Cambria-BoldItalic-16.vlw");

  //set-up of all the widgets used  - Kamil
  searchbox=new Widget(SEARCHBOXX, SEARCHBOXY, SEARCHBOXWIDTH, SEARCHBOXHEIGHT, myText, color(190), widgetFont, EVENT_BUTTON1, 5, 5);
  searchButton=new Widget(SEARCHBUTTONX, SEARCHBUTTONY, SEARCHBUTTONWIDTH, SEARCHBOXHEIGHT, "", color(0), widgetFont, EVENT_BUTTON10, 0, 0);
  leaderboardsButton=new Widget(LEADERBOARDSX, LEADERBOARDSY, 160, 50, "Leaderboards", color(255, 127), widgetFont, EVENT_BUTTON3, 20, 20);
  homeButton=new Widget(HOMEX, HOMEY, 60, 60, logoImage, EVENT_BUTTON2);
  homeScreen=new Screen(backgroundPhoto, homescreenWidgets);
  leaderboardsScreen= new Screen(backgroundPhotoLeaderBoards, leaderboardsWidgets);
  businessScreen=new Screen(backgroundPhotoBusiness, businessWidgets);
  topStars= new RadioButton(RADIOBUTTONX, TOPSTARSY, LEADERBOARDSBUTTONWIDTH, LEADERBOARDSBUTTONHEIGHT, "Top star rated", color(255), widgetFont, EVENT_BUTTON4, 10, 10 );
  mostReviewed= new RadioButton(RADIOBUTTONX, MOSTREVIEWEDY, LEADERBOARDSBUTTONWIDTH, LEADERBOARDSBUTTONHEIGHT, "Most reviewed", color(255), widgetFont, EVENT_BUTTON5, 10, 10 );
  topTwenty= new RadioButton(RADIOBUTTONX, TOPTWENTY, LEADERBOARDSBUTTONWIDTH, LEADERBOARDSBUTTONHEIGHT, "Top 20 rated", color(255), widgetFont, EVENT_BUTTON6, 10, 10 );
  mostUseful= new RadioButton(RADIOBUTTONX, MOSTUSEFULY, LEADERBOARDSBUTTONWIDTH, LEADERBOARDSBUTTONHEIGHT, "Most useful", color(255), widgetFont, EVENT_BUTTON7, 10, 10 );
  funniest= new RadioButton(RADIOBUTTONX, FUNNIESTY, LEADERBOARDSBUTTONWIDTH, LEADERBOARDSBUTTONHEIGHT, "Funniest", color(255), widgetFont, EVENT_BUTTON8, 10, 10 );
  coolest= new RadioButton(RADIOBUTTONX, COOLESTY, LEADERBOARDSBUTTONWIDTH, LEADERBOARDSBUTTONHEIGHT, "Coolest", color(255), widgetFont, EVENT_BUTTON9, 10, 10 );
  barChartGraph= new RadioButton(BARCHARTBUTTONX, BARCHARTBUTTONY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT, "Bar Chart", color(255), widgetFont, EVENT_BUTTON13, 12, 10);
  lineChartGraph = new RadioButton(LINECHARTBUTTONX, LINECHARTBUTTONY, RADIOBUTTONWIDTH, RADIOBUTTONHEIGHT, "Line Chart", color(255), widgetFont, EVENT_BUTTON14, 5, 10);
  mapButton = new RadioButton(RADIOBUTTONX, MAPBUTTONY, LEADERBOARDSBUTTONWIDTH, LEADERBOARDSBUTTONHEIGHT, "Map of businesses", color(255), widgetFont, EVENT_BUTTON15, 10, 10);
  previousYear= new Widget(YEARBUTTONX, YEARBUTTONY, YEARBUTTONWIDTH, YEARBUTTONHEIGHT, "<< year", color(255), widgetFont, EVENT_BUTTON17, 5, 10);
  nextYear = new Widget(YEARBUTTONX+135, YEARBUTTONY, YEARBUTTONWIDTH, YEARBUTTONHEIGHT, "year >>", color(255), widgetFont, EVENT_BUTTON18, 5, 10);


  selectedBusiness=null;
  selectedAC = null;
  selectedReview=null;
  // initialising data structures
  table = loadTable("reviews.csv", "header");
  reviewerIds = new HashSet<String>();
  businessReviewMap = new TreeMap<String, ArrayList<Review>>();
  reviewerReviewMap = new TreeMap<String, ArrayList<Review>>();
  dataPoints = new ArrayList<DataPoint>();
  reviews = new ArrayList<Review>();
  businessNames = new HashSet<String>();
  reviewsString = new ArrayList<String>();
  reviewHeaders= new ArrayList<String>();
  reviewTexts= new ArrayList<String>();
  businesses = new ArrayList<Business>();
  searchedBusinesses  = new ArrayList<Business>();
  reviewsPerMonth = new ArrayList<Business>();
  //  loading of data
  loadData();
  loadReviewBusiness();

  search = new Search();
  search.createBusinessAZMap();
  search.createReviewerMap();
  println(reviewerReviewMap.keySet());

  // autocomplete initialised with individual business names - Tom
  autoComplete = new AutoComplete(businessReviewMap.keySet());

  search.mostRecentReview(reviews);
  println(businessReviewMap.keySet());

  //homescreen widget list
  homeScreen.addWidget(searchbox);
  homeScreen.addWidget(searchButton);
  homeScreen.addWidget(leaderboardsButton);

  //leaderboards screen widget list
  leaderboardsScreen.addWidget(searchButton);
  leaderboardsScreen.addWidget(searchbox);
  leaderboardsScreen.addWidget(topStars);
  leaderboardsScreen.addWidget(mostReviewed);
  leaderboardsScreen.addWidget(topTwenty);
  leaderboardsScreen.addWidget(mostUseful);
  leaderboardsScreen.addWidget(funniest);
  leaderboardsScreen.addWidget(coolest);
  leaderboardsScreen.addWidget(mapButton);

  //business screen widget list
  businessScreen.addWidget(searchbox);
  businessScreen.addWidget(searchButton);
  businessScreen.addWidget(barChartGraph);
  businessScreen.addWidget(lineChartGraph);
  //businessScreen.addWidget(previousYear);
  //businessScreen.addWidget(nextYear);

  currentScreen=homeScreen;

  recentReviews = initRecentReviewBoxes();
  leaderboardRungList = initTopBusinesses();

  //setup for the Top 20 list on the leaderboards screen - Kamil
  cp5 = new ControlP5(this);
  cp5.addScrollableList("TopTwenty")
    .setPosition(TOPTWENTYLISTX, TOPTWENTYLISTY)
    .setSize(TOPTWENTYWIDTH, TOPTWENTYHEIGHT)             
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

  //setup for the list of reviews on the business screen - Kamil  
  cp5Reviews = new ControlP5(this);  
  cp5Reviews.addScrollableList("Reviews")
    .setPosition(BUSINESSREVIEWSX, BUSINESSREVIEWSY)
    .setSize(REVIEWTEXTWIDTH, REVIEWTEXTHEIGHT)
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

  statsForNerds();
}


void draw() {
  background(255);
  currentScreen.draw();

  if (drawScreen) {
    currentScreen.drawWidgets();
    // draws the rectangles on the top of the screen (black and grey) - Kamil
    fill(100);
    noStroke();
    rect(0, 70, SCREENX, 5);
    fill(0);
    rect(0, 0, SCREENX, 70);

    // draws the magnifying glass on the search button - Kamil
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
  }
  //draws the pie chart for a user - Claire
  if (drawPieChart) {
    pieChart.pieChart(100, author.type);
  }

  //draws the relevant bar chart - Claire
  if (drawGraph) {
    noStroke();
    if (goToGraph) {
      barchart.draw();
      for (int i=0; i<barchart.bars.length && !barchart.bars[i].drawBar(); i++);
    }
  }
  // drawing bar charts on map
  if (drawMap) {
    for (int i=0; i<map.bars.length && !map.bars[i].drawBar(); i++);
  }

  // boolean for determining if the top 20 list should be shown - Kamil
  if (!listTopTwenty) {
    cp5.hide();
  } else if (listTopTwenty) {
    cp5.show();
    cam.setActive(false);
  }

  // boolean which changes the colour of the searchbox to show the user they can type - Kamil
  if (canType) {
    searchbox.setSearchboxColor(255);
  } else if (!canType) {
    searchbox.setSearchboxColor(190);
  }

  // sets the search query to the selected auto complete suggestion if required - Tom
  if (selectedAC!=null) {
    searchbox.myText = selectedAC;
  }

  // goes to the business page of selected business from top 20 list - Kamil
  if (selectedBusiness!= null) {                                                                                              
    displayBusinessScreen();
  }

  // draws the home screen - Ruairi
  if (currentScreen == homeScreen) {
    noStroke();
    drawRecentReviewBoxes();
    drawTopBusinessTable();
    cam.setActive(false);
    listTopTwenty=false;
    fill(255);
    textSize(25);
    text("Stats for Nerds", 650, 300);
    for (int index = 0; index <  bubbles.length; index++) {
    bubbles[index].drawBubblesRising();
  }
  }

  // draws the line seperating the buttons from the graphs - Kamil
  if (currentScreen==leaderboardsScreen && drawScreen==true) {
    fill(HIGHLIGHT);
    noStroke();
    rect(275, 150, 1, 590);
    if (cp5AutoComplete.get(ScrollableList.class, "Autocomplete").isVisible()) {
      topStars.removeStroke();
    }
    if (!cp5AutoComplete.get(ScrollableList.class, "Autocomplete").isVisible()) {
      topStars.removeStroke();
    }
  }
  // takes care of the business screen - Kamil
  if (currentScreen==businessScreen) {

    //prints out an error if a searched business is not found
    if (businessFound==false) {                                                               
      stroke(#C62800);
      strokeWeight(5);
      fill(255);
      rect(320, (SCREENY/2)-80, 720, 200);
      fill(0);
      textFont(font);
      text("Sorry this business doesn't exist.\nPlease try again.", 355, (SCREENY/2)+10);
      return;
    }

    // draws the bar chart if the bar chart button is pressed
    if (drawStarChart) {     
      displayBusinessStarsChart(searchedBusinesses);
    }

    // draws the line chart if the line chart button is pressed
    if (drawLineChart) {
      previousYear.draw();
      nextYear.draw();
      lineGraph.drawLineGraph();                              
      fill(0);
      text(year, YEARBUTTONX+YEARBUTTONWIDTH+5, YEARBUTTONY+22);
    }
    // resets the boolean to prevent constant restarts on drawing the chart
    drawStarChart=false;
    drawMap=false;
    if (drawScreen) {
      // draws the transparent rectangle behind review text
      fill(0, 130); 
      noStroke();
      rect(BUSINESSREVIEWSX, BUSINESSREVIEWSY, REVIEWTEXTWIDTH, 600);

      // if a review is selected, print out its text on the area of the rectangle
      if (selectedReview!=null) {
        fill(255);
        textSize(17);
        text(header+"\n", BUSINESSREVIEWSX+10, BUSINESSNAMEY+80, REVIEWTEXTWIDTH-10, 725);
        text(selectedReview, BUSINESSREVIEWSX+10, BUSINESSNAMEY+100, REVIEWTEXTWIDTH-10, 725);

        //method to deal with profile - Claire
        printReviewersProfile();
      } 

      //if the mouse is over the list of the reviews, you can scroll through the list, else 'scroll' zooms out/in on the screen
      if (overReviews()) {
        cam.setActive(false);
      } else if (!overReviews()) {
        cam.setActive(true);
      }

      cp5.get(ScrollableList.class, "TopTwenty").hide();
      // draws the line under the business page header
      fill(HIGHLIGHT);
      rect(BUSINESSREVIEWSX, BUSINESSNAMEY+10, REVIEWTEXTWIDTH, 2);
      cp5Reviews.get(ScrollableList.class, "Reviews").show();

      // prints the header on the business page (business name and rating)
      fill(255);
      textFont(font);
      textSize(40);
      text(businessName+"  "+rating+"*", BUSINESSNAMEX, BUSINESSNAMEY);
      textSize(19);
      if (drawLineChart) {
        text("Amount of reviews \nof all time" + " = " + reviewAmount, LINECHARTBUTTONX-120, LINECHARTBUTTONY+90);                      
        text("Amount of reviews \nfor " + year + " = " + totalReviewsForYear, LINECHARTBUTTONX-120, LINECHARTBUTTONY+130);
      }
    }
    if (!drawScreen) {
      cp5Reviews.get(ScrollableList.class, "Reviews").hide();
    }
  }
  //resets the values 
  selectedBusiness = null;
  selectedAC = null;
  if (drawMap) {
    map.drawMap();
  }
}


// Function for getting the index of a pressed business on the Top 20 list on leaderboards screen - Kamil
void TopTwenty(int index) {
  selectedBusiness = cp5.get(ScrollableList.class, "TopTwenty").getItem(index).get("name").toString();
}

// Function for getting the index of a pressed review on the business screen - Kamil
void Reviews(int index) {
  selectedReview=reviewTexts.get(index);

  //getting information for reviwer profile - Claire
  selectedAuthorId = reviewerIdsForPieChart.get(index);
  selectedAuthor = reviewerNamesForProfile.get(index);
  header = reviewHeaders.get(index);
}

// Function for pressing an autocomplete suggestion - Tom
void Autocomplete(int index) {
  selectedAC = cp5AutoComplete.get(ScrollableList.class, "Autocomplete").getItem(index).get("name").toString();
  canType = true;
}

//getting the information for the reviwer and printing out reviewers profile - Claire
void printReviewersProfile() {
  fill(255, 180);
  rect(BUSINESSREVIEWSX, BUSINESSREVIEWSY + 620, REVIEWTEXTWIDTH-190, 125);

  author = new Author(selectedAuthorId);
  pieChart = new PieChart(720, 830, author.type());
  drawPieChart = true;

  fill(#58862E);
  textSize(22);
  textFont(reviewerProfileHeaderFont);
  text("Reviewer Profile", BUSINESSREVIEWSX + 20, BUSINESSREVIEWSY + 650);

  textSize(20);
  text("Name: ", BUSINESSREVIEWSX + 20, BUSINESSREVIEWSY + 680);

  textFont(reviewerProfileFont);
  textSize(20);
  text(selectedAuthor, BUSINESSREVIEWSX + 100, BUSINESSREVIEWSY + 680);

  textFont(reviewerProfileHeaderFont);
  textSize(20);
  text("Amount of reviews: ", BUSINESSREVIEWSX + 20, BUSINESSREVIEWSY + 700);

  textFont(reviewerProfileFont);
  textSize(20);
  text(author.getAmountOfReviews(), BUSINESSREVIEWSX + 200, BUSINESSREVIEWSY + 700);

  textFont(reviewerProfileHeaderFont);
  textSize(20);
  text("Average star rating given: ", BUSINESSREVIEWSX + 20, BUSINESSREVIEWSY + 720);

  textFont(reviewerProfileFont);
  textSize(20);
  text(author.getAverageStarRating(), BUSINESSREVIEWSX + 260, BUSINESSREVIEWSY + 720);
}

//creation of bubble facts animation for homepage - Claire
void statsForNerds() {
  bubbles[0] = new Bubble(650, 400, 150, #C2BDCB, "There are currently \n" + reviews.size() + " \nreviews on this site.", 0);
  Business[] tmpBusinesses = search.mostReviewed();
  Business tmpBusiness = tmpBusinesses[0];
  bubbles[1] = new Bubble(770, 550, 130, #BFADBE, tmpBusiness.getBusinessName() +  "\nhas the most \nreviews.", 150);
  bubbles[2] = new Bubble(820, 420, 100, #AAC5E0, search.getTopBusiness().getBusinessName() + "\nis the best \nrated.", 280);
  bubbles[3] = new Bubble(640, 650, 90, #B0E0AA, search.getWorstBusiness().getBusinessName() + "\nis the worst \nrated.", 370);
  bubbles[4] = new Bubble(800, 760, 160, #F7CBA7, search.sortByCool()[0].getAuthor() + "\nis the coolest \nreviewer.", 550);
}

void mouseMoved() {
  searchbox.setStroke(mouseX, mouseY);
  leaderboardsButton.setStroke(mouseX, mouseY);

  //gets the piechart for a reviewer if the mouse is hovered over their name - Claire
  if (currentScreen == homeScreen) {
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
}


// allows the user to type into the searchbox, delete characters using BACKSPACE, reset the whole string using DELETE, and press ENTER to search for the entry - Kamil
// shows autocomplete suggestions - Tom
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
    } else if (searchbox.myText.length() <=36) {
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

// rotates the graphs when mouse dragged - Kamil
void mouseDragged() {
  if (currentScreen!=homeScreen && !overReviews() && !listTopTwenty) {
    cam.setActive(true);
    drawScreen=false;
    drawPieChart = false;
  }
}

// resets the screen back to normal when mouse released - Kamil
void mouseReleased() {
  drawScreen=true;
  cam.reset();
}

// takes care of all the widget interactions - Kamil
void mousePressed() {
  int event;
  // in charge of the home button (top left logo) - Kamil
  event = homeButton.getEvent(mouseX, mouseY);
  if (event==EVENT_BUTTON2) {
    searchbox.myText="Search...";
    canType=false;
    goToGraph=false;
    drawGraph = false;
    drawMap=false;
    currentScreen=homeScreen;
    listTopTwenty=false;
    selectedBusiness=null;
    cp5AutoComplete.get(ScrollableList.class, "Autocomplete").hide();
    cp5Reviews.get(ScrollableList.class, "Reviews").hide();
  }

  event = currentScreen.getEvent(mouseX, mouseY); 
  // in charge of the other widgets
  switch(event) {

    // searchbox button
  case EVENT_BUTTON1:
    if (searchbox.myText=="Search...") {
      searchbox.myText="";
    } 
    canType=true;
    break;

    // button to go to the leaderboards page - Kamil
  case EVENT_BUTTON3:
    currentScreen=leaderboardsScreen;
    listTopTwenty=true;
    cp5.get(ScrollableList.class, "TopTwenty").show();
    cp5.get(ScrollableList.class, "TopTwenty").open();
    cp5.get(ScrollableList.class, "TopTwenty").setCaptionLabel("Top 20 rated businesses");
    break;

    // shows top star rated graph on leaderboards screen - Kamil & Claire
  case EVENT_BUTTON4:
    currentScreen=leaderboardsScreen;
    displayTopRatedChart();
    goToGraph = true;
    drawGraph = true;
    drawLineChart = false;
    listTopTwenty=false;
    drawMap=false;
    break;

    // shows most reviewed graph on leaderboards screen - Kamil & Claire
  case EVENT_BUTTON5:
    displayMostReviewed();
    listTopTwenty=false;    
    drawLineChart = false;
    drawMap=false;
    break;

    // shows top 20 rated list on leaderboards screen - Kamil
  case EVENT_BUTTON6:
    cp5.get(ScrollableList.class, "TopTwenty").open();
    cp5.get(ScrollableList.class, "TopTwenty").setCaptionLabel("Top 20 rated businesses");
    listTopTwenty=true;
    cam.setActive(false);
    drawGraph=false;
    drawMap=false;
    break;

    // shows most useful graph on leaderboards screen - Kamil & Claire
  case EVENT_BUTTON7:
    displayUsefulChart();
    listTopTwenty=false;
    drawLineChart = false;
    drawMap=false;
    break;

    // shows funniest reviewer graph on leaderboards screen - Kamil & Claire
  case EVENT_BUTTON8:
    displayFunniestChart();
    listTopTwenty=false;
    drawLineChart = false;
    drawMap=false;
    break;

    // shows coolest reviewer graph on leaderboards screen - Kamil & Claire
  case EVENT_BUTTON9:
    displayCoolChart();
    listTopTwenty=false;
    drawLineChart = false;
    drawMap=false;
    break;

    // the search button beside the searchbox - Kamil
  case EVENT_BUTTON10:
    listTopTwenty=false;
    drawLineChart = false;

    canType=false;
    if (searchbox.myText=="Search..." ) {
      break;
    } else {
      prepareBusinessReviews(searchbox.myText);                                                                                            
      displayBusinessScreen();
      break;
    }

    // link from home page to business page when clicked on most recent business - Claire
  case EVENT_BUTTON11:
    for (int i = 0; i < listOfRecentReviews.size(); i++) {
      if (listOfRecentReviews.get(i).businessButton.getEvent(mouseX, mouseY) != EVENT_NULL) {
        searchbox.myText = listOfRecentReviews.get(i).getBusinessName();
        displayBusinessScreen();
      }
    }
    break;

    // link from home page to business page when clicked on business from top 15 table - Claire
  case EVENT_BUTTON12:
    for (int i = 0; i < leaderboardRungList.size(); i++) {
      if (leaderboardRungList.get(i).rowInTable.getEvent(mouseX, mouseY) != EVENT_NULL) {
        searchbox.myText = leaderboardRungList.get(i).getBusinessName();
        displayBusinessScreen();
      }
    }
    break;

    // button to display bar chart on business page - Kamil
  case EVENT_BUTTON13:
    drawGraph=false;
    drawStarChart=true;                                                                                               
    drawLineChart = false;
    break;

    // button to display line chart on business page - Kamil
  case EVENT_BUTTON14:
    drawGraph=false;
    drawStarChart=false;
    drawLineChart = true;
    break;

    // button to display map on leaderboards page - Kamil  
  case EVENT_BUTTON15:
    listTopTwenty=false;
    drawGraph=false;
    drawMap=true;
    break;
    // read full review button - Kamil
  case EVENT_BUTTON16:
    for (int i = 0; i < listOfRecentReviews.size(); i++) {
      if (listOfRecentReviews.get(i).seeFullReviewButton.getEvent(mouseX, mouseY) != EVENT_NULL) {
        searchbox.myText = listOfRecentReviews.get(i).getBusinessName();
        displayBusinessScreen();
        prepareBusinessReviews(searchbox.myText);
        selectedReview= reviewTexts.get(0);
        cp5Reviews.get(ScrollableList.class, "Reviews").close(); 
        header = reviewHeaders.get(0);
        cp5Reviews.get(ScrollableList.class, "Reviews").setCaptionLabel(header);
        author = new Author(listOfRecentReviews.get(i).reviewerId);
        pieChart = new PieChart(500, 500, author.type());
        drawPieChart = true;
      }
    }
    break;

  default:
    if (drawGraph || drawMap) {
      listTopTwenty=false;
    } else if (currentScreen==leaderboardsScreen) {  
      listTopTwenty=true;
    }
    canType=false;
    if (searchbox.myText=="") {
      searchbox.myText="Search...";
    }
    cp5AutoComplete.get(ScrollableList.class, "Autocomplete").hide();
    break;
  }

  // previous & next year buttons for changing the line chart with respect to year - Kamil
  // seperate from switch statement because theyre not added to be part of a screen, so cant use currentScreen.getEvent, this is so that they are not drawn all the time and only when the line chart is shown
  // - Kamil
  event = previousYear.getEvent(mouseX, mouseY); 
  if (event==EVENT_BUTTON17 && currentScreen == businessScreen) {
    if (year<=2007) {
      year=2007;
    } else {
      year--;
    }
    reviewsPerMonth = search.sortReviewsByMonth(searchedBusinesses.get(0), year);
    totalReviewsForYear = displayBusinessLineGraph(reviewsPerMonth, year);
  }

  event= nextYear.getEvent(mouseX, mouseY);
  if (event==EVENT_BUTTON18 && currentScreen == businessScreen) {
    if (year>=2017) {
      year=2017;
    } else {
      year++;
      println(year);
    }
    reviewsPerMonth = search.sortReviewsByMonth(searchedBusinesses.get(0), year);
    totalReviewsForYear = displayBusinessLineGraph(reviewsPerMonth, year);
  }
}

// loads raw data from table - Tom
void loadData() {
  for (TableRow row : table.rows()) {
    DataPoint dp = new DataPoint(row.getString(0), row.getString(1), row.getString(2), row.getString(3), row.getInt(4), row.getString(5), row.getString(6), row.getInt(7), row.getInt(8), row.getInt(9), row.getFloat(10), row.getFloat(11));
    dataPoints.add(dp);
  }
}

// loads reviews and businesses array lists - Tom
void loadReviewBusiness() {
  for (DataPoint dp : dataPoints) {
    reviews.add(new Review(dp.getUserName(), dp.getUserId(), dp.getBusinessName(), dp.getBusinessId(), dp.getStars(), dp.getText(), dp.getDate(), dp.getUseful(), dp.getFunny(), dp.getCool()));
    businesses.add(new Business(dp.getBusinessName(), dp.getBusinessId(), dp.getLongitude(), dp.getLatitude()));
  }
}


//initialises the 10 top rated businesses bar chart and sets the screen into 3D viewing mode - Claire
void displayTopRatedChart() {
  drawGraph = true;
  goToGraph = true;
  Business[] topRatedBusinesses = search.getTopTenBusinesses();
  barchart = new BusinessBarChart(LEADERBOARDSGRAPHX, LEADERBOARDSGRAPHY, topRatedBusinesses, "topBusinesses");
}

//initialises the funniest review bar chart and sets the screen into 3D viewing mode - Claire
void displayFunniestChart() {
  drawGraph = true;
  goToGraph = true;
  Review[] funniest = search.sortByFunny();
  barchart = new BusinessBarChart(LEADERBOARDSGRAPHX, LEADERBOARDSGRAPHY, funniest, "funny");
}

//initialises the most useful review bar chart and sets the screen into 3D viewing mode - Claire
void displayUsefulChart() {
  drawGraph = true;
  goToGraph = true;
  Review[] useful = search.sortByUseful();
  barchart = new BusinessBarChart(LEADERBOARDSGRAPHX, LEADERBOARDSGRAPHY, useful, "useful");
}

//initialises the coolest review bar chart and sets the screen into 3D viewing mode - Claire
void displayCoolChart() {
  drawGraph = true;
  goToGraph = true;
  Review[] cool = search.sortByCool();
  barchart = new BusinessBarChart(LEADERBOARDSGRAPHX, LEADERBOARDSGRAPHY, cool, "cool");
}

//initialises the most reviewed bar chart and sets the screen into 3D viewing mode - Claire
void displayMostReviewed() {
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
  int x=60;
  int y=270;
  recentReviewsHeader = new TitleBox(x, y-100, 380, 60, 25, 25, color(255, 127), DEFAULT_TEXT_COLOUR, color(0), widgetFont, "Most Recent Reviews", 5);
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


// draws the business screen - Kamil
void displayBusinessScreen() {
  currentScreen=businessScreen;
  searchedBusinesses = search.searchBusinessList(searchbox.myText);
  drawGraph = true;

  // if no business found
  if (searchedBusinesses==null || selectedBusiness==null) {
    businessFound=false;
  }

  // if business found
  if (searchedBusinesses.size() != 0||selectedBusiness!=null) {
    businessFound=true;
    year = 2016;
    listTopTwenty = false;
    if (selectedBusiness != null) {
      String[] businessDetails = selectedBusiness.split("  ", -1);
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
    //keeps the business name permanently on the screen so its not affected by changes to searchbox
    businessName=searchbox.myText;
  } 

  //draws the amount of the stars the business searched has if business is in data base - Claire
  displayBusinessStarsChart(searchedBusinesses);                                                            
  for (Business business : searchedBusinesses) {
    business.searchedFor = true;
  }
}

// this method creates an arraylist of leaderboard rungs containing the highest rated businesses-Ruairi
ArrayList<LeadersTable> initTopBusinesses() {
  Business[] topBusinesses = search.getTop15Businesses();
  leaderboardRungList = new ArrayList<LeadersTable>();
  int ranking = 1;
  int x=1000;
  int y=270;
  topBusinessesHeader = new TitleBox(x, y-100, 450, 60, 25, 25, color(255, 127), DEFAULT_TEXT_COLOUR, color(0), widgetFont, "Top Rated Businesses", 5);
  for (int i=0; i<topBusinesses.length; i++) {
    String currentBusinessName = topBusinesses[i].getBusinessName();
    String actualBusinessName = topBusinesses[i].getBusinessName();
    //if business name is too long to fit in row, following method will decrease its size
    if (currentBusinessName.length()>=29) {
      currentBusinessName = currentBusinessName.substring(0, Math.min(currentBusinessName.length(), 28));
      currentBusinessName+="..";
    }
    LeadersTable rung = new LeadersTable(x, y, ranking, currentBusinessName, actualBusinessName, topBusinesses[i].getAverageStarsOfBusiness());
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


// function for the business page to differentiate whether to scroll review list or zoom in/out the screen - Kamil
boolean overReviews() {
  boolean canScroll=false;
  if (currentScreen==businessScreen && mouseX>=BUSINESSREVIEWSX && mouseX<= BUSINESSREVIEWSX+REVIEWTEXTWIDTH+35 && mouseY >= BUSINESSREVIEWSY && mouseY<=BUSINESSREVIEWSY+700) {
    canScroll=true;
  }
  return canScroll;
}


// loads in two arrayLists, one for review headers (for the scrollable list) and one with the actual text of the review
// also resets the list to these values and opens it to be seen - Kamil
void prepareBusinessReviews(String businessName) {
  drawStarChart=true;
  selectedReview=null;
  reviewTexts.clear();
  reviewHeaders.clear();
  reviewerIdsForPieChart.clear();
  reviewerNamesForProfile.clear();
  String reviewHeader="";
  String reviewText="";
  String idOfReviewer = "";
  String name = "";
  for (Review review : search.getReviewsForBusiness(businessName)) {
    reviewHeader=(review.getDate()+"  "+review.getAuthor()+"  "+review.getStars()+"*");
    reviewHeaders.add(reviewHeader);
    reviewText=review.getText();
    reviewTexts.add(reviewText);

    //for piechart representation of what type of reviewer the author of the review is - Claire
    idOfReviewer = review.getAuthorId();
    reviewerIdsForPieChart.add(idOfReviewer);

    name = review.getAuthor();
    reviewerNamesForProfile.add(name);
  }
  cp5Reviews.get(ScrollableList.class, "Reviews").clear();                                                      
  cp5Reviews.get(ScrollableList.class, "Reviews").addItems(reviewHeaders); 
  cp5Reviews.get(ScrollableList.class, "Reviews").setCaptionLabel("Reviews");
  cp5Reviews.get(ScrollableList.class, "Reviews").open();
}