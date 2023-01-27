import 'package:latlong2/latlong.dart';

class MyRoute {
  dynamic distance,time;
  List<LatLng> waypoints;
  MyRoute({
    this.distance,
    this.time,
    required this.waypoints
});

}