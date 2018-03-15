
import java.util.Comparator;

class SortByUseful implements Comparator<Review> {
  public int compare(Review review1, Review review2) {
    return review2.getUseful() - review1.getUseful();
  }
}