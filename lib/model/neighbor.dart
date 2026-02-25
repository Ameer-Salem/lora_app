class Neighbor {
  final int id;
  final int rssi;
  final int lastSeen;
  double? lat;
  double? lon;

  Neighbor(this.id, this.rssi, this.lastSeen , this.lat, this.lon);
}
