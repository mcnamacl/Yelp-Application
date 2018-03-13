
import java.util.Comparator;

class SortByName implements Comparator<Review> {
  public int compare(Review review1, Review review2) {
    return review1.getBusiness().compareToIgnoreCase(review2.getBusiness());
  }
}