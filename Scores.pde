class Scores {

  int x, y;
  float[] scores;
  String[] months;

  public Scores(int x, int y, float[] scores) {
    this.x = x;
    this.y = y;
    this.scores = scores;
  }

  public Scores(int x, int y, String[] months) {
    this.x = x;
    this.y = y;
    this.months = months;
  }

  void drawScores() {
    fill(255);
    if (scores!=null) {
      for (int i = 0; i < scores.length; i++) {
        textSize(18);
        text(scores[i], (float)x, (float)y+20);
        x+=60;
      }
    } else {
      for (int i = 0; i < months.length; i++) {
        pushMatrix();
        translate(x, y);
        rotate(HALF_PI);
        translate(-x, -y);
        fill(#DFFF12);
        textSize(20);
        text(months[i], (float)x, (float)y);
        popMatrix();
        x+=60;
      }
    }
  }
}