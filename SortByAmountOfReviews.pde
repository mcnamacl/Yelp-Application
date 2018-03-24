//Class that sorts businesses by amount of reviews - Claire
import java.util.Comparator;

class SortByAmountOfReviews implements Comparator<Business> {
  public int compare(Business b1, Business b2) {
    return b1.returnAmountOfReviews() - b2.returnAmountOfReviews();
  }
}