//String userId, String userName, String businessId, String businessName, int stars, String date, String text, int useful, int funny, int cool

ArrayList<DataPoint> dataPoints;
ArrayList<String> userIds;
Table table;

void setup() {
  
  dataPoints = new ArrayList<DataPoint>();
  table = loadTable("reviews.csv", "header");
  for (TableRow row : table.rows()) {
    DataPoint dp = new DataPoint(row.getString(0), row.getString(1), row.getString(2), row.getString(3), 
                            row.getInt(4), row.getString(5), row.getString(6), row.getInt(7), row.getInt(8), row.getInt(9));
    dataPoints.add(dp);
    
  }
  
  for (DataPoint dp : dataPoints) {
    println(dp);
  }
}

void draw() {
}

void mousePressed() {
}

void loadData(String fileName) { 
  String[] rawData = loadStrings(fileName);
  println(Arrays.toString(rawData));
  for (int i = 1; i < rawData.length; i++) {

    String[] row = split(rawData[i], ",");
    println(Arrays.toString(row));
    for (int j = 0; j < 10; j++) {
      println(row[j]);
    }
    dataPoints.add(new DataPoint(row[0], row[1], row[2], row[3], Integer.parseInt(row[4]), row[5], 
      row[6], Integer.parseInt(row[7]), Integer.parseInt(row[8]), Integer.parseInt(row[9])));
  }
}