// world map class - Tom
class WorldMap {
  private float lon, lat;
  private int mapX, mapY, mapHeight, mapWidth;
  ArrayList<Float> latitudesBar, longitudesBar, latitudes, longitudes;
  PShape map;
  Bar bars[];
  ArrayList<Business> topTwentyBusinesses;

  public WorldMap() {
    this.lon = 0;
    this.lat = 0;
    this.mapHeight = MAP_HEIGHT;
    this.mapWidth = MAP_WIDTH;
    this.mapX = MAP_X;
    this.mapY = MAP_Y;
    this.map = loadShape("BlankMap-Equirectangular.svg");
    
    topTwentyBusinesses = search.getTopTwentyBusinesses();
    
    this.latitudes = search.getLatitudes(businesses);
    this.longitudes = search.getLongitudes(businesses);  
    
    this.latitudesBar = search.getLatitudes(topTwentyBusinesses);
    this.longitudesBar = search.getLongitudes(topTwentyBusinesses);  
    
    bars = new Bar[latitudesBar.size()];
    for (int i = 0; i < latitudesBar.size(); i++) {
      lat = map(latitudesBar.get(i), 90, -90, 0, mapHeight) + mapY;
      lon = map(longitudesBar.get(i), -180, 180, 0, mapWidth) + mapX;
      
      bars[i] = new Bar(topTwentyBusinesses.get(i).getAverageStarsOfBusiness()*20, lon, lat, businesses.get(i).getBusinessName(), lat + 2, (float) 50, "map");
    }
  }
  // draws circle on map to represent each business
  public void drawMap() {
    fill(100);
    shape(map, mapX, mapY, mapWidth, mapHeight);
    for (int i = 0; i < this.latitudes.size(); i++) {
      lat = map(latitudes.get(i), 90, -90, 0, mapHeight) + mapY;
      lon = map(longitudes.get(i), -180, 180, 0, mapWidth) + mapX;

      fill(255, 0, 0, 150);
      noStroke();
      ellipse(lon, lat, 5, 5);
    }
  }
}