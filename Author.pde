class Author {

  String name, id;
  ArrayList<Review> authorReviews;
  int[] type = new int[3];

  Author(String id) {
    this.id = id;
    println(id);
    authorReviews = (ArrayList<Review>)reviewerReviewMap.get(id);
    for (int i : type) {
      type[i] = 0;
    }
  }

  //getting what type of reviewer the author of a review is
  int[] type() {
    int funny = 0;
    int useful = 0;
    int cool = 0;
    for (Review review : authorReviews) {
      if (review.getFunny()!=0) {
        funny = review.getFunny() + funny;
      }
      if (review.getUseful() != 0) {
        useful = review.getUseful() + useful;
      }
      if (review.getCool() != 0) {
        cool = review.getCool() + cool;
      }
    }
    type[0] = funny;
    type[1] = useful;
    type[2] = cool;
    println(type);
    return type;
  }


  void drawPieChart() {
    PieChart pieChart = new PieChart(100, 100, type);
    pieChart.pieChart(300, type);
  }
}