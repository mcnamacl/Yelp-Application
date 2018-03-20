/*import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.lang.*;
import java.util.Comparator;
import java.util.Arrays;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AutoComplete {
  

  public Term[] queries;

  // Initialize the data structure from the given array of terms.
  public AutoComplete(Term[] terms) {
    if (terms == null) {
      throw new java.lang.NullPointerException();
    }
    this.queries = terms;
    Arrays.sort(queries);
  }

  // Return all terms that start with the given prefix, in descending order of weight.
  public Term[] allMatches(String prefix) {
    if (prefix == null) {
      throw new java.lang.NullPointerException();
    }
    Term temp = new Term(prefix, 0);

    int i = BinarySearchDeluxe.firstIndexOf(queries, temp, Term.byPrefixOrder(prefix.length()));
    int j = BinarySearchDeluxe.lastIndexOf(queries, temp, Term.byPrefixOrder(prefix.length()));
    println(i);
    println(j);
    if (i == -1 || j == -1) {
      throw new java.lang.NullPointerException();
    }
    Term[] matches = new Term[j - i + 1];
    matches = Arrays.copyOfRange(queries, i, j);
    Arrays.sort(matches, temp.byReverseWeightOrder());
    return matches;
  }

  // Return the number of terms that start with the given prefix.
  public int numberOfMatches(String prefix) {
    if (prefix == null) {
      throw new java.lang.NullPointerException();
    }
    Term temp = new Term(prefix, 0);
    int i = BinarySearchDeluxe.firstIndexOf(queries, temp, Term.byPrefixOrder(prefix.length()));
    int j = BinarySearchDeluxe.lastIndexOf(queries, temp, Term.byPrefixOrder(prefix.length()));
    return j - i + 1;
  }
}*/