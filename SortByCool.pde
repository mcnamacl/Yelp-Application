
import java.util.Comparator;

class SortByCool implements Comparator<Review> {
  public int compare(Review review1, Review review2) {
    return review2.getCool() - review1.getCool();
  }
}