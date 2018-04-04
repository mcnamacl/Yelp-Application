//Class that deals with the bar chart for a particular author - Claire
class PieChart {

  int x,y;
  float diameter;
  int[] data;
  color[] colours = new color[3];
  String[] types = new String[3];


  PieChart(int x, int y, int[] data) {
    this.x = x;
    this.y = y;
    this.data = data;
    colours[0] = #6195A2;
    colours[1] = #616AA0;
    colours[2] = #61A063;
    
    types[0] = "Funny";
    types[1] = "Useful";
    types[2] = "Cool";
  }

  //calculates the slice of the pie chart a particular value requires
  void pieChart(float diameter, int[] data) {
    noStroke();
    fill(255, 200);
    rect(x-55,y-65,175, 125);
    
    float lastAngle = 0;
    float total = 0;
    for (int i : data){
      total= i + total;
    }
    int tmpY = y - 25;
    for (int i = 0; i < data.length; i++) {
      fill(colours[i], 255);
      float angle = (map(data[i], 0, total, 0, 360)) * PI/180;
      arc(x, y, diameter, diameter, lastAngle, lastAngle+angle);
      lastAngle += angle;
      
      text(types[i], x + 60, tmpY);
      tmpY += 20;
    }
  }
}