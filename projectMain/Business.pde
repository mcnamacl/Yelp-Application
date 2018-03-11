class Business {

  private int avStars;
  private String businessName;
  private String businessId;
  private ArrayList<Review> businessReviews;
  private int[] stars = new int[5];

  public Business(String businessName, String businessId) {
    this.businessName = businessName;
    this.businessId = businessId;
    this.avStars = 0;
    this.businessReviews = new ArrayList<Review>();     
    for (int i = 0; i < stars.length; i++) {
      stars[i] = 0;
    }
  }

  int[] returnStars() {
    return stars;
  }
  public int getAvStars() {
    return avStars;
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

  public ArrayList<Review> getReviews() {
    for (Review review : reviews) {
      //println(reviews);
      if (review.getBusiness().equals(businessName) && review.getBusinessId().equals(businessId)) {
        businessReviews.add(review);
      }
    }
    return businessReviews;
  }

  public void displayStarCategories() {
    int counter = 0;
    for (int i : stars) {
      counter++;
      if (i > 0) {
        println("This business has " + i + " " + counter + " star rating/s.");
      }
    }
  }

  @Override
    public String toString() {
    return "Business{" + "avStars=" + avStars + ", businessName=" + businessName + ", businessId=" + businessId + ", businessReviews=" + businessReviews + '}';
  }
}