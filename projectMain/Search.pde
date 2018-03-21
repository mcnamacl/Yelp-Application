import java.util.Collections;

Set<String> businessNames;
Map<String, ArrayList<Review>> businessReviewMap; 
Set<String> reviewerNames;
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
    //ArrayList<Review> sortedList = new ArrayList<Review>();
    Collections.sort(reviews, new SortByDate());
    return reviews;
  } 


  public ArrayList<Review> sortBusinessByName(ArrayList<Review> reviews) {
    Collections.sort(reviews, new SortByName());
    return reviews;
  }

  public ArrayList<Review> sortByCool(ArrayList<Review> reviews) {
    Collections.sort(reviews, new SortByCool());
    return reviews;
  }

  public ArrayList<Review> sortByUseful(ArrayList<Review> reviews) {
    Collections.sort(reviews, new SortByUseful());
    return reviews;
  }

  public ArrayList<Review> sortByFunny(ArrayList<Review> reviews) {
    Collections.sort(reviews, new SortByFunny());
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

  int[] getStarsForCollectionOfBusinesses(ArrayList<Business> searchedBusinesses) {
    int[] starsForBusinesses = new int[5];
    int[] tmpStarsForBusinesses = new int[5];
    for (Business business : searchedBusinesses) {
      getStarsForOneBusiness(business);
      tmpStarsForBusinesses = business.returnStars();
      for (int i = 0; i < tmpStarsForBusinesses.length; i++){
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
      reviewerNames.add(review.getAuthor().toLowerCase());
    }
    for (String name : reviewerNames) {
      ArrayList<Review> reviewerReviews = new ArrayList<Review>();
      for (Review review : reviews) {
        if (review.getAuthor().toLowerCase().equals(name)) {
          reviewerReviews.add(review);
        }
      }
      reviewerReviewMap.put(name, reviewerReviews);
    }
  }

  public Business[] getTopTenBusinesses() {
    Business[] topTenBusinesses = new Business[10];
    Collections.sort(businesses, new Comparator<Business>() {
      @Override
        public int compare(Business b1, Business b2) {
        Double av1 = ((Business) b1).getAverageStarsOfBusiness();
        Double av2 = ((Business) b2).getAverageStarsOfBusiness();
        return av1.compareTo(av2);
      }
    }  
    );

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