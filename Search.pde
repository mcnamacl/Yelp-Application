import java.util.Collections;

Set<String> businessNames;
Map<String, ArrayList<Review>> businessReviewMap; 
Set<String> reviewerIds;
Map<String, ArrayList<Review>> reviewerReviewMap;
Map<String, Business> amountOfReviews;


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

  /*public void initAmountOfReviews() {
   for (String business : businessReviewMap.keySet()) {
   int numberOfReviews = businessReviewMap.get(business).size();
   businessAmountOfReviews.put(business, numberOfReviews);
   }
   }*/

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

  //get top 10 coolest reviews - Claire
  public Review[] sortByCool() {
    Review[] coolReviews = new Review[10];
    Collections.sort(reviews, new SortByCool());
    for (int i = 0; i < 10; i++) {
      coolReviews[i] = (reviews.get(i));
    }
    return coolReviews;
  }

  //get top 10 most useful reviews - Claire
  public Review[] sortByUseful() {
    Review[] usefulReviews = new Review[10];
    Collections.sort(reviews, new SortByUseful());
    for (int i = 0; i < 10; i++) {
      usefulReviews[i] = (reviews.get(i));
    }
    return usefulReviews;
  }

  //get top 10 funniest reviews - Claire
  public Review[] sortByFunny() {
    Review[] funnyReviews = new Review[10];
    Collections.sort(reviews, new SortByFunny());
    for (int i = 0; i < 10; i++) {
      funnyReviews[i] = (reviews.get(i));
    }
    return funnyReviews;
  }

  //gets the amount of stars for all branches of a particular business - Claire
  int[] getStarsForCollectionOfBusinesses(ArrayList<Business> searchedBusinesses) {
    int[] starsForBusinesses = new int[5];
    int[] tmpStarsForBusinesses = new int[5];
    ArrayList<String> businessesWithReviewsGotten = new ArrayList<String>();
    for (Business business : searchedBusinesses) {
    println(business.getBusinessName() + " " + business.getBusinessId());
      if (!businessesWithReviewsGotten.contains(business.getBusinessId())) {
        businessesWithReviewsGotten.add(business.getBusinessId());
        tmpStarsForBusinesses = business.returnStars();
        //println(tmpStarsForBusinesses);
        for (int i = 0; i < tmpStarsForBusinesses.length; i++) {
          int tmpN = starsForBusinesses[i] + tmpStarsForBusinesses[i];
          //println(starsForBusinesses[i] + " " + tmpStarsForBusinesses[i] + " " + tmpN);
          starsForBusinesses[i] = tmpN;
        }
        println(" ");
      }
    }
    return starsForBusinesses;
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

  //gets the top 10 rated businesses - Claire
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

  //gets the top 20 rated businesses - Claire
  public String[] getTop20Businesses() {
    String[] top20Businesses = new String[20];
    sortBusinesses();
    int counter = 0;
    ArrayList<String> gotStarsFor = new ArrayList<String>();
    for (int i  = businesses.size(); counter < 20; i--) {
      if (!gotStarsFor.contains(businesses.get(i-1).getBusinessName())) {
        gotStarsFor.add(businesses.get(i-1).getBusinessName());
        int amountOfReviews = amountOfReviews(businesses.get(i-1).getBusinessName());
        top20Businesses[counter] = ((counter+1)+")  "+businesses.get(i-1).getBusinessName()+"  ("+businesses.get(i-1).getAverageStarsOfBusiness()+"*)  "+amountOfReviews+"-Review(s)");
        counter++;
      }
    }
    return top20Businesses;
  }

  //sorts the business in terms of average stars - Claire
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

  //gets the average stars of all branches of a business - Claire/Tom
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

  //sorts the business reviews in order of amount of reviews - Claire
  Business[] mostReviewed() {
    ArrayList<Business> amountOfReviewsPerBusiness = new ArrayList<Business>();
    Set<String> keys = businessReviewMap.keySet();
    for (String key : keys) { 
      int counter = 0;
      for (Review review : reviews) {
        if (review.getBusiness().equals(key)) {
          counter++;
        }
      }
      Business business = new Business(key, counter);
      amountOfReviewsPerBusiness.add(business);
    }   
    Collections.sort(amountOfReviewsPerBusiness, new SortByAmountOfReviews());
    Business[] mostReviewed = new Business[10];
    for (int i  = 0; i < mostReviewed.length; i++) {
      mostReviewed[i] = amountOfReviewsPerBusiness.get(amountOfReviewsPerBusiness.size()-(i+1));
    }
    return mostReviewed;
    /*Collections.sort(businesses, new SortByMostReviews());
     println("\n\n\n\n\n");
     for (Business business : businesses) {
     println(business + " " + business.businessReviews.size());
     }
     return null;*/
  }

  //returns the amount of reviews for all branches of a business - Claire
  int amountOfReviews(String businessName) {
    int amountOfReviews = 0;
    for (Review review : reviews) {
      if (review.getBusiness().equals(businessName)) {
        amountOfReviews++;
      }
    }
    return amountOfReviews;
  }


  //gets all the reviews for a particular business per month for a specific year - Claire
  ArrayList<Business> sortReviewsByMonth(Business business, int year) {
    String name = business.getBusinessName();
    int[] months = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
    SimpleDateFormat df = new SimpleDateFormat("dd/mm/yyyy");
    Collections.sort(reviews, new SortByDate());
    ArrayList<Business> reviewsPerMonth = new ArrayList<Business>();
    ArrayList<Review> reviewsYear = new ArrayList<Review>();
    ArrayList<Review> sortReviewsMonth = new ArrayList<Review>();
    int month;
    for (Review review : reviews) {
      String tmpYear = df.format(review.getDate());
      int checkYear = Integer.parseInt(tmpYear.substring(6, 10));
      if (checkYear == year) {
        reviewsYear.add(review);
      }
    }
    for (int intMonth : months) {
      for (Review reviewMonth : reviewsYear) {
        String checkMonthTmp = df.format(reviewMonth.getDate());
        month = Integer.parseInt(checkMonthTmp.substring(3, 5));
        if (month == intMonth) {
          sortReviewsMonth.add(reviewMonth);
        }
      }
      int counter = 0;
      for (Review sortBusiness : sortReviewsMonth) {
        if (sortBusiness.getBusiness().equals(name)) {
          counter++;
        }
      } 
      Business tmpBusiness = new Business(name, counter, intMonth);
      reviewsPerMonth.add(tmpBusiness);
      sortReviewsMonth.clear();
    }
    return reviewsPerMonth;
  }
}


import java.util.Comparator;

class SortByName implements Comparator<Review> {
  public int compare(Review review1, Review review2) {
    return review1.getBusiness().compareToIgnoreCase(review2.getBusiness());
  }
}

//Class that sorts businesses by amount of reviews - Claire
class SortByAmountOfReviews implements Comparator<Business> {
  public int compare(Business b1, Business b2) {
    return b1.returnAmountOfReviews() - b2.returnAmountOfReviews();
  }
}

class SortByCool implements Comparator<Review> {
  public int compare(Review review1, Review review2) {
    return review2.getCool() - review1.getCool();
  }
}

class SortByUseful implements Comparator<Review> {
  public int compare(Review review1, Review review2) {
    return review2.getUseful() - review1.getUseful();
  }
}

class SortByFunny implements Comparator<Review> {
  public int compare(Review review1, Review review2) {
    return review2.getFunny() - review1.getFunny();
  }
}

class SortByDate implements Comparator<Review> {
  public int compare(Review review1, Review review2) {
    return review2.getDate().compareTo(review1.getDate());
  }
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