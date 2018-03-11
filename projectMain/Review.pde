
class Review {

  private String author;
  private String business;
  private int stars;
  private String text;
  private String date;
  private int useful;
  private int funny;
  private int cool;
  private String businessId;

  Review (String author, String business, String businessId, int stars, String text, String date, int useful, int funny, int cool) {
    this.author = author;
    this.business = business;
    this.businessId = businessId;
    this.stars = stars;
    this.text = text;
    this.date = date;
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

  String getDate() {
    return date;
  }
  void setDate(String date) {
    this.date = date;
  }

  @Override
    public String toString() {
    return "Review [author=" + author + ", business=" + business + ", stars=" + stars + ", text=" + text + ", date="
      + date + ", useful=" + useful + ", funny=" + funny + ", cool=" + cool + "]";
  }
}