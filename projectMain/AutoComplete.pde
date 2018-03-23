
import java.util.ArrayList;

public class AutoComplete {

  Set<String> terms;

  public AutoComplete(Set<String> terms) {
    this.terms = terms;
  }

  public ArrayList<String> getMatches(String prefix) {
    ArrayList<String> matches = new ArrayList<String>();
    for (String term : terms) {
      if (term.toLowerCase().startsWith(prefix.toLowerCase())) {
        matches.add(term);
      }
    }
    return matches;
  }
}