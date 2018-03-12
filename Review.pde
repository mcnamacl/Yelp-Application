import java.text.SimpleDateFormat;
import java.util.Date;
import java.text.ParseException;

class Review {

  private String author;
  private String business;
  private int stars;
  private String text;
  private String dateString;
  private int useful;
  private int funny;
  private int cool;
  private String businessId;
  private Date date;

  Review (String author, String business, String businessId, int stars, String text, String dateString, int useful, int funny, int cool) {
    this.author = author;
    this.business = business;
    this.businessId = businessId;
    this.stars = stars;
    this.text = text;
    this.dateString = dateString;
    SimpleDateFormat formatter = new SimpleDateFormat("dd/mm/yyyy");
    try {
      this.date = formatter.parse(dateString);
    } 
    catch (ParseException e) {
      e.printStackTrace();
    }
    this.useful = useful;
    this.funny = funny;
    this.cool = cool;
  }


  String getAuthor() {
    return author;
  }
  void setAuthor(String author) {
    this.author = author;
  }
  String getBusiness() {
    return business;
  }
  void setBusiness(String business) {
    this.business = business;
  }
  
  String getBusinessId(){
    return businessId;
  }
  int getStars() {
    return stars;
  }

  String getText() {
    return text;
  }

  Date getDate() {
    return date;
  }

  @Override
    public String toString() {
    return "Review [author=" + author + ", business=" + business + ", stars=" + stars + ", text=" + text + ", date="
      + date + ", useful=" + useful + ", funny=" + funny + ", cool=" + cool + "]";
  }
}