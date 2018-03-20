class PieChart {

  int x,y;
  float diameter;
  int[] data;

  PieChart(int x, int y, int[] data) {
    this.x = x;
    this.y = y;
    this.data = data;
  }

  //calculates the slice of the pie chart a particular value requires
  void pieChart(float diameter, int[] data) {
    float lastAngle = 0;
    for (int i = 0; i < data.length; i++) {
      float gray = map(i, 0, data.length, 0, 255);
      fill(gray);
      arc(width/2, height/2, diameter, diameter, lastAngle, lastAngle+radians(data[i]));
      lastAngle += radians(data[i]);
    }
  }
}