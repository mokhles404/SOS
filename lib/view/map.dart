import 'dart:async';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlng/latlng.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:location/location.dart';
import 'package:lottie/lottie.dart' as lt;
import 'package:sos/controller/controller.dart';
import 'package:sos/models/route.dart';
import 'package:sos/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/proximity_service.dart';
import '../models/Place.dart';
import '../utils/widgets.dart';

class CustomMap extends StatefulWidget {
  String? type;
  Place? place;
  CustomMap({Key? key, this.type, this.place}) : super(key: key);

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  bool tracking = false;
  LocationData? currentlocation;
  MapController controller = MapController();
  bool loading = false;
  StreamSubscription<LocationData>? locationlistner;
  late List<latLng.LatLng> points;
  MyRoute? route;

  Future<LocationData> init_Location() async {
    LocationData _locationData = await Location().getLocation();
    return _locationData;
  }

  Future<void> getCurrentLocation() async {
    tracking = !tracking;
    if (!tracking && locationlistner != null) {
      locationlistner!.cancel();
      setState(() {});
      return;
    }
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    if (tracking) {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
    }
    loading = true;
    locationlistner =
        location.onLocationChanged.listen(cancelOnError: true, (location) {
      print("location!= currentlocation 1=" +
          (location != currentlocation).toString());
      setState(() {
        currentlocation = location;
      });
      if (tracking) {
        print(" currentlocation?.latitude 2 " +
            (currentlocation?.latitude ?? "none").toString());
        controller.move(
            latLng.LatLng(
                currentlocation!.latitude!, currentlocation!.longitude!),
            16);
      }
    });
    print("loading 3" + loading.toString());
    print(" currentlocation?.latitude =4 " +
        (currentlocation?.latitude ?? "hyyyy").toString());
    //  print("brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    loading = false;
    print("loading5 " + loading.toString());
    setState(() {});
  }
  Future<void> getroute(latLng.LatLng start , latLng.LatLng dest) async {
    ApiProximity api =ApiProximity();
     route =await api.getRoute(start, dest);
    setState(() {
    });
  }

  @override
  void initState() {
    init_Location().then((value) {
      setState(() {
        currentlocation = value;
      });
    });
    // points=polyline_points;
    points = widget.place!.coordinates!
        .map<latLng.LatLng>((coord) => latLng.LatLng(
              double.tryParse(coord.long!)!,
              double.tryParse(coord.lat!)!,
            ))
        .toList();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (locationlistner != null) {
      locationlistner!.cancel();
    }
    // print("dispose: ${locationlistner.isPaused}");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    latLng.LatLng exactlyPoint =
        latLng.LatLng(points.first.latitude, points.first.longitude);
    return Scaffold(
      body: loading || currentlocation == null
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.green,
              strokeWidth: 3,
            ))
          : FlutterMap(
              mapController: controller,
              options: MapOptions(
                  center: exactlyPoint,
                  plugins: <MapPlugin>[
                    MarkerClusterPlugin(),
                  ],
                  zoom: 15.0,
                  maxZoom: 18,
                  minZoom: 7),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/mokhles404/cl74h16sa003514p78ey34in6/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibW9raGxlczQwNCIsImEiOiJjbDZ6MzZwb3cwMGpsM29uMXZtdWlwcXByIn0.uY-hjHl7fIdgGgREn-5m-Q",
                  additionalOptions: {
                    'accessToken':
                        'sk.eyJ1IjoibW9raGxlczQwNCIsImEiOiJjbDcwOHc1NmowYzZjM29wZ3NiY3p5YXRyIn0.ATuFTifS9pHGXUC-BR-K1A',
                    'id': 'mapbox.mapbox-streets-v8'
                  },
                ),
                PolylineLayerOptions(polylines: [
                  Polyline(
                      color: Colors.lightBlueAccent,
                      borderColor: Colors.black87,
                      strokeWidth: 5,
                      points: points)
                ]),
                if(route!=null)
                  PolylineLayerOptions(polylines: [
                    Polyline(
                        color: Colors.orangeAccent,
                        borderColor: Colors.black87,
                        strokeWidth: 5,
                        points: route!.waypoints)
                  ]),



                MarkerLayerOptions(markers: [
                  Marker(
                      width: 100.0,
                      height: 100.0,
                      // point: latLng.LatLng(34.712446, 10.544073),
                      point: exactlyPoint,
                      builder: (context) => Container(
                            // color: Colors.black,
                            alignment: Alignment.center,
                            child: InkWell(
                              child: lt.Lottie.asset("assets/red_postion.json",
                                  height: 80),
                              onTap: () {
                                setState(() {
                                  controller.move(
                                      // latLng.LatLng(34.712446, 10.544073), 16);
                                      exactlyPoint,
                                      16);
                                });
                                print("pk");
                              },
                            ),
                          )),
                  if (tracking)
                    Marker(
                        width: 250.0,
                        height: 250.0,
                        point: latLng.LatLng(currentlocation!.latitude!,
                            currentlocation!.longitude!),
                        builder: (context) => Container(
                              // color: Colors.black,
                              alignment: Alignment.center,
                              child: lt.Lottie.asset("assets/ourpostion1.json",
                                  height: 220, width: 220),
                            )),
                ])
              ],
            ),
      floatingActionButton: FabCircularMenu(
        ringWidth: 130,
        ringColor: Colors.white60,
        fabColor: const Color(0xff4CACa7),
        fabOpenIcon: const Icon(Icons.menu,size: 40,),
        // fabOpenIcon: Image.asset(
        //   "assets/hathemi/5bd2b381f439b8b24b826fa919abf861.png",
        //   width: 50,
        // ),
        children: [
          CustomIconButton("Urgence",
              const Icon(Icons.call, color: Color(0xffde2c2c), size: 45),
              color: const Color(0xffde2c2c), func: () async {
            print("done1");
            final Uri _url = Uri.parse('tel://20353532');
            if (!await launchUrl(_url)) {
              throw 'Could not launch $_url';
            }
            print("done2");
          }),
          CustomIconButton(
              !tracking
                  ? "Suivre votre\nposition"
                  : "Désactiver le suivi\nde la position",
              const Icon(Icons.location_on_rounded,
                  color: Color(0xff4CACa7), size: 38),
              color: const Color(0xff319da0), func: () {
            getCurrentLocation();
          }),

          CustomIconButton(
              "Rejoindre \n le circuit",
              const Icon(
                Icons.my_location,
                color: Color(0xff386c4c),
                size: 38,
              ),
              func: () {
                setState(() {
                  loading=true;
                });
                getroute(latLng.LatLng(currentlocation!.latitude!,
                    currentlocation!.longitude!), points.first);
    setState(() {
          controller.move(latLng.LatLng(currentlocation!.latitude!,currentlocation!.longitude!), 16);

              loading=false;

        });
                // func: () => setState(() {
                //       // controller.move(exactlyPoint, 16);
                //
                //     }),
              },
              color: const Color(0xff386c4c)),
          CustomIconButton("Exit",
              const Icon(Icons.close_outlined, color: Color(0xff483838), size: 38),
              func: () => Navigator.of(context).pop(),
              color: Color(0xff483838)),
          // CustomIconButton("Recenter",Icon(Icons.my_location)),
        ],
      ),
    );
  }
}
