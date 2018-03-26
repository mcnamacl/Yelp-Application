class Business {

  private String businessName;
  private String businessId;
  int month ;
  private ArrayList<Review> businessReviews;
  private int[] stars = new int[5];
  private int amountOfReviews;
  private double averageStars;
  
  
 // constructor for a particular branch of a business - Claire/Tom
  public Business(String businessName, String businessId) {
    this.businessName = businessName;
    this.businessId = businessId;
    this.businessReviews = new ArrayList<Review>(); 
    
    //gets the amount of stars in the relevant category for the business - Claire
    for (int i = 0; i < stars.length; i++) {
      stars[i] = 0;
    }
  }

// constructors for all branchs of a business - Claire
  public Business(String businessName, int amountOfReviews) {
    this.amountOfReviews = amountOfReviews;
    this.businessName = businessName;
  }
  
  public Business(String businessName, int amountOfReviews, int month){
    this.amountOfReviews = amountOfReviews;
    this.businessName = businessName;
    this.month = month;
  }
  
  int getMonth() {
    return month;
  }
  
  public int returnAmountOfReviews(){
    return amountOfReviews;
  }

  public String getBusinessName() {
    return businessName;
  }

  public String getBusinessId() {
    return businessId;
  }

  public ArrayList<Review>getBusinessReviews() {
    return businessReviews;
  }

  //gets all the reviews for a particular business - Claire
  public ArrayList<Review> getReviews() {
    for (Review review : reviews) {
      if (review.getBusiness().equals(businessName) && review.getBusinessId().equals(businessId)) {
        businessReviews.add(review);
      }
    }
    return businessReviews;
  }
  
  //returns arraylist of how many stars in each category a business has 
  public int[] returnStars(){ 
    getReviews();
    println(businessReviews.size());
    for (Review review : businessReviews){
      int placeInArray = review.getStars();
      stars[placeInArray-1]++;
    }
    //println(stars);
    return stars;
  }

  //prints all the stars a business has in the relevent categories
  public void displayStarCategories() {
    int counter = 0;
    for (int i : stars) {
      counter++;
      if (i > 0) {
        println("This business has " + i + " " + counter + " star rating/s.");
      }
    }
  }

//get the average stars of the business - Claire/Tom
  double getAverageStarsOfBusiness() {
    ArrayList<Review> businessReviews = businessReviewMap.get(businessName);
    double total = 0;
    double count = 0;
    if (businessReviews != null) {
      for (Review review : businessReviews) {
        total += review.getStars();
        count++;
      }
    }
    return Double.parseDouble(String.format("%.2f", total/count));
  }

//returns amount of reviews a business has - Claire
  int amountOfReviews() {
    ArrayList<Review> allReviews = new ArrayList<Review>();
    for (Review review : reviews) { 
      if (review.getBusiness().equals(businessName)){
        allReviews.add(review);
      }
    }
    return allReviews.size();
  }


  @Override
    public String toString() {
    return "Business{" + ", businessName=" + businessName + ", businessId=" + businessId + ", businessReviews=" + businessReviews + '}';
  }
}