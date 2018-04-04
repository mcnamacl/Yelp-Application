// Initial object each line of csv is loaded into - Tom
class DataPoint {

  private String userId;
  private String userName;
  private String businessId;
  private String businessName;
  private int stars;
  private String date;
  private String text;
  private int useful;
  private int funny;
  private int cool;
  private float longitude;
  private float latitude;
 
 
 //public DataPoint(String userId, String userName, String businessId, String businessName, int stars, String date, String text, int useful, int funny, int cool){
 public DataPoint(String userId, String userName, String businessId, String businessName, int stars, String date, String text, int useful, int funny, int cool, float longitude, float latitude) {
    this.userId = userId;
    this.userName = userName;
    this.businessId = businessId;
    this.businessName = businessName;
    this.stars = stars;
    this.date = date;
    this.text = text;
    this.useful = useful;
    this.funny = funny;
    this.cool = cool;
    this.longitude = longitude;
    this.latitude = latitude;
  }

  public String getUserId() {
    return userId;
  }

  public String getUserName() {
    return userName;
  }

  public String getBusinessId() {
    return businessId;
  }

  public String getBusinessName() {
    return businessName;
  }

  public int getStars() {
    return stars;
  }

  public String getDate() {
    return date;
  }

  public String getText() {
    return text;
  }

  public int getUseful() {
    return useful;
  }

  public int getFunny() {
    return funny;
  }

  public int getCool() {
    return cool;
  }
  
  public float getLongitude() {
    return this.longitude;
  }
  
  public float getLatitude() {
    return this.latitude;
  }
  
  
  public String toString() {
    String string = "userID = " + this.userId + "\n";
    string += "userName = " + this.userName + "\n";
    string += "businessID = " + this.businessId + "\n";
    string += "business name = " + this.businessName + "\n";
    string += "stars = " + this.stars + "\n";
    string += "date = " + this.date + "\n";
    string += "review: " + this.text + "\n";
    string += "useful: " + this.useful + "\n";
    string += "funny: " + this.funny + "\n";
    string += "cool: " + this.cool + "\n";
    return string;
  }
}