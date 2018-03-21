import java.util.Collections;

Set<String> businessNames;
Map<String, ArrayList<Review>> businessReviewMap; 
Set<String> reviewerIds;
Map<String, ArrayList<Review>> reviewerReviewMap;

class Search {

  ArrayList<Business> searchBusinessList(String userSearch) {
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

  public void printBusinesses() {
    String businesses = ""; 
    Set<String> keys = businessReviewMap.keySet(); 
    for (String key : keys) {
      businesses += searchBusinessList(key).get(0).getBusinessName() + ", ";
    }
    businesses = businesses.substring(0, businesses.lastIndexOf(",")); 
    businesses += "."; 
    println(businesses);
  }


  public ArrayList<Review> mostRecentReview(ArrayList<Review> reviews) {
    Collections.sort(reviews, new SortByDate());
    return reviews;
  } 


  public ArrayList<Review> sortBusinessByName(ArrayList<Review> reviews) {
    Collections.sort(reviews, new SortByName());
    return reviews;
  }

  //get top 10 coolest reviews
  public Review[] sortByCool() {
    Review[] coolReviews = new Review[10];
    Collections.sort(reviews, new SortByCool());
    for (int i = 0; i < 10; i++) {
      coolReviews[i] = (reviews.get(i));
    }
    return coolReviews;
  }

  //get top 10 most useful reviews
  public Review[] sortByUseful() {
    Review[] usefulReviews = new Review[10];
    Collections.sort(reviews, new SortByUseful());
    for (int i = 0; i < 10; i++) {
      usefulReviews[i] = (reviews.get(i));
    }
    return usefulReviews;
  }

  //get top 10 funniest reviews
  public Review[] sortByFunny() {
    Review[] funnyReviews = new Review[10];
    Collections.sort(reviews, new SortByFunny());
    for (int i = 0; i < 10; i++) {
      funnyReviews[i] = (reviews.get(i));
    }
    return funnyReviews;
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

  int[] getStarsForCollectionOfBusinesses(ArrayList<Business> searchedBusinesses) {
    int[] starsForBusinesses = new int[5];
    int[] tmpStarsForBusinesses = new int[5];
    for (Business business : searchedBusinesses) {
      getStarsForOneBusiness(business);
      tmpStarsForBusinesses = business.returnStars();
      for (int i = 0; i < tmpStarsForBusinesses.length; i++) {
        int tmpN = starsForBusinesses[i] + tmpStarsForBusinesses[i];
        starsForBusinesses[i] = tmpN;
      }
    }
    println(starsForBusinesses);
    return starsForBusinesses;
  }

  void getStarsForOneBusiness(Business business) {
    for (Review review : business.getReviews()) {
      business.returnStars()[review.getStars()-1] = business.returnStars()[review.getStars()-1] + 1;
    }
  }

  // Initialises map of business and that business's reviews
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

  // Initialises map of reviewer's name and all that reviewer's reviews
  // Can be used to determine if reviewer is harsh or easliy pleased
  void createReviewerMap() {
    for (Review review : reviews) {
      // reviewerNames.add(review.getAuthor().toLowerCase());
      reviewerIds.add(review.getAuthorId());
    }
    for (String id : reviewerIds) {
      ArrayList<Review> reviewerReviews = new ArrayList<Review>();
      for (Review review : reviews) {
        if (review.getAuthorId().equals(id)) {
          reviewerReviews.add(review);
        }
      }
      reviewerReviewMap.put(id, reviewerReviews);
    }
  }

  public Business[] getTopTenBusinesses() {
    Business[] topTenBusinesses = new Business[10];
    sortBusinesses();
    int counter = 0;
    ArrayList<String> gotStarsFor = new ArrayList<String>();
    for (int i  = businesses.size(); counter < 10; i--) {
      if (!gotStarsFor.contains(businesses.get(i-1).getBusinessName())) {
        gotStarsFor.add(businesses.get(i-1).getBusinessName());
        topTenBusinesses[counter] = businesses.get(i-1);
        counter++;
      }
    }
    return topTenBusinesses;
  }

  public Business[] getTop20Businesses() {
    Business[] top20Businesses = new Business[20];
    sortBusinesses();
    int counter = 0;
    ArrayList<String> gotStarsFor = new ArrayList<String>();
    for (int i  = businesses.size(); counter < 20; i--) {
      if (!gotStarsFor.contains(businesses.get(i-1).getBusinessName())) {
        gotStarsFor.add(businesses.get(i-1).getBusinessName());
        top20Businesses[counter] = businesses.get(i-1);
        counter++;
      }
    }
    return top20Businesses;
  }

  void sortBusinesses() {
    Collections.sort(businesses, new Comparator<Business>() {
      @Override
        public int compare(Business b1, Business b2) {
        Double av1 = ((Business) b1).getAverageStarsOfBusiness();
        Double av2 = ((Business) b2).getAverageStarsOfBusiness();
        return av1.compareTo(av2);
      }
    }  
    );
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

  Business[] mostReviewed() {
    Collections.sort(businesses, new Comparator<Business>() {
      @Override
        public int compare(Business b1, Business b2) {
          Integer size1 = ((Business) b1).amountOfReviews();
          Integer size2 = ((Business) b2).amountOfReviews();
        return size1.compareTo(size2);
      }
    }
    );
    
    Business[] mostReviewed = new Business[10];
    for (int i  = 0; i < mostReviewed.length; i++) {
      mostReviewed[i] = businesses.get(businesses.size()-(i+1));
    }
    return mostReviewed;
  }


  /*public Term[] autoComplete(String searchQuery) {
   
   take in hashmap <weights and queries> (<business name string, number of reviews>)
   construct terms into array
   get k amount of queries to show
   prefix = user types in (after two chars entered)
   
   //weightedMap
   Term[] terms = new Term[businessReviewMap.size()];
   int i = 0;
   for (Map.Entry<String, ArrayList<Review>> entry : businessReviewMap.entrySet()) {
   int weight = entry.getValue().size();
   String query = entry.getKey();
   
   terms[i] = new Term(query, weight);
   i++;
   }
   println(Arrays.toString(terms));
   AutoComplete autoComplete = new AutoComplete(terms);
   String prefix = searchQuery;
   
   Term[] results = autoComplete.allMatches(prefix);
   if (results.length > 0) {
   return results;
   }
   println("wut");
   return null;
   }*/
}