import java.util.ArrayList;

// Takes set of terms to autocomplete and sees if a given prefix matches any - Tom
public class AutoComplete {

  Set<String> terms;

  public AutoComplete(Set<String> terms) {
    this.terms = terms;
  }
  // searches through terms and matches prefix into String array
  public String[] getMatches(String prefix) {
    ArrayList<String> matches = new ArrayList<String>();
    for (String term : terms) {
      if (term.toLowerCase().startsWith(prefix.toLowerCase())) {
        matches.add(term);
      }
    }
    println(matches);
    String[] matchesArray = matches.toArray(new String[matches.size()]);
    return matchesArray;
  }
}