import java.util.Collections;

class Search {

  ArrayList searchBusinessList(String userSearch) {
    userSearch = userSearch.toLowerCase();
    ArrayList<Business> foundBusinesses = new ArrayList<Business>();
    int index;
    for (index = 0; index < businesses.size(); index++) {
      if (userSearch.equals(businesses.get(index).getBusinessName().toLowerCase())) {
        Business business = businesses.get(index);
        if (!foundBusinesses.contains(business)) {
          foundBusinesses.add(business);
        }
      }
    }
    return foundBusinesses;
  }

  public void getStars(Business business) {
    for (Review review : business.getReviews()) {
      business.returnStars()[review.getStars()-1] = business.returnStars()[review.getStars()-1] + 1;
    }
  }

  public ArrayList<Review> mostRecentReview(ArrayList<Review> reviews) {
    //ArrayList<Review> sortedList = new ArrayList<Review>();
    Collections.sort(reviews, new SortByDate());
    return reviews;
  } 


  public ArrayList<Review> sortBusinessByName(ArrayList<Review> reviews) {
    Collections.sort(reviews, new SortByName());
    return reviews;
  }

  public ArrayList<Review> searchReviewByBusinessName(ArrayList<Review> reviews, String businessName) {
    ArrayList<Review> foundReviews = new ArrayList<Review>();
    for (Review review : reviews) {
      if (review.getBusiness().equals(businessName)) {
        foundReviews.add(review);
      }
    }
    return foundReviews;
  }


  void createBusinessAZMap() {
    for (Business business : businesses) {
      businessNames.add(business.getBusinessName());
    }
    for (String name : businessNames) {
      ArrayList<Review> businessReviews = new ArrayList<Review>();
      for (Review review : reviews) {
        if (review.getBusiness().equals(name)) {
          businessReviews.add(review);
        }
      }
      businessReviewMap.put(name, businessReviews);
    }
  }

  double getAverageStarsOfBusiness(String businessName) {
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
}