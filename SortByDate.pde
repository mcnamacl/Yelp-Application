
import java.util.Comparator;

class SortByDate implements Comparator<Review> {
  public int compare(Review review1, Review review2) {
    return review2.getDate().compareTo(review1.getDate());
  }
  
}