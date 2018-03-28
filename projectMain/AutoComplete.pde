import java.util.ArrayList;

public class AutoComplete {

  Set<String> terms;

  public AutoComplete(Set<String> terms) {
    this.terms = terms;
  }

  public String[] getMatches(String prefix) {
    ArrayList<String> matches = new ArrayList<String>();
    for (String term : terms) {
      if (term.toLowerCase().startsWith(prefix.toLowerCase())) {
        matches.add(term);
      }
    }
    println(matches);
    String[] matchesArray = matches.toArray(new String[matches.size()]);
    //println(matchesArray[1]);
    return matchesArray;
  }
}