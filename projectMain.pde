//String userId, String userName, String businessId, String businessName, int stars, String date, String text, int useful, int funny, int cool

ArrayList<DataPoint> dataPoints;
ArrayList<String> userIds;
Table table;
PFont font;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  font = loadFont("Cambria-20.vlw");
  dataPoints = new ArrayList<DataPoint>();
  table = loadTable("testData.csv", "header");
  for (TableRow row : table.rows()) {
    DataPoint dp = new DataPoint(row.getString(0), row.getString(1), row.getString(2), row.getString(3), 
                            row.getInt(4), row.getString(5), row.getString(6), row.getInt(7), row.getInt(8), row.getInt(9));
    dataPoints.add(dp);
    
  }
}

void draw() {
  background(backgroundColour);
  int y = 10;
  for (DataPoint dp : dataPoints) {
    fill(textColour);
    text(dp.toString(), 0, y, SCREENX, SCREENY);
    y+=200;
  }
}

void mousePressed() {
}