
class WorldMap {
  private float lon, lat;
  private int mapX, mapY, mapHeight, mapWidth;
  ArrayList<Float> latitudes, longitudes;
  PShape map;

  public WorldMap() {
    this.lon = 0;
    this.lat = 0;
    this.mapHeight = MAP_HEIGHT;
    this.mapWidth = MAP_WIDTH;
    this.mapX = MAP_X;
    this.mapY = MAP_Y;
    this.map = loadShape("BlankMap-Equirectangular.svg");
    this.latitudes = search.getLatitudes();
    this.longitudes = search.getLongitudes();
  }

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