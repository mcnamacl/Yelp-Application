class Search {
  ArrayList<Review> reviews;

  Search() {
  }


  ArrayList searchBusinessList(String userSearch, ArrayList<Business> businesses) {
    userSearch = userSearch.toLowerCase();
    ArrayList<Business> foundBusinesses = new ArrayList<Business>();
    int index;
    for (index = 0; index < businesses.size(); index++) {
      if (userSearch.equals(businesses.get(index).getBusinessName().toLowerCase())) {
        foundBusinesses.add(businesses.get(index));
      }
    }
    return foundBusinesses;
  }

  double getStars(Business business) {
    int total = 0;
    int counter = 0;
    for (Review review : business.getReviews()) {
      total = review.getStars() + total;
      counter++;  
      business.returnStars()[review.getStars()-1] = business.returnStars()[review.getStars()-1] + 1;
    }
    return total / counter;
  }
}