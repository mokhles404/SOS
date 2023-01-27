import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;
import 'package:dio/dio.dart';

import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import 'package:intl/intl.dart';

import '../models/route.dart';
class ApiProximity {
  static const endpoint = "https://tourtunisieapi.herokuapp.com/sites";
  static BaseOptions options = BaseOptions(
      baseUrl: endpoint,
      responseType: ResponseType.plain,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: (code) {
        if (code! >= 200) {
          return true;
        } else {
          return false;
        }
      });
  static Dio dio = Dio(options);


  double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(deg2rad(lat1)) *
            Math.cos(deg2rad(lat2)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  double deg2rad(deg) {
    return deg * (Math.pi / 180);
  }
  Future<dynamic> getRoute(LatLng start,LatLng dest) async {
    print("**********************************************************");
    print("${start.latitude}, ${start.longitude}");
    print("${dest.latitude}, ${dest.longitude}");
    print("**********************************************************");

    print("IAMAT GET route points");
    List<LatLng> waypoints=[];
    dynamic distance,time;
    try {
      print("IAMAT try");

      var response = await dio.get("https://api.tomtom.com/routing/1/calculateRoute/${start.latitude},${start.longitude}:${dest.latitude},${dest.longitude}/json?routeRepresentation=polyline&routeType=shortest&avoid=unpavedRoads&travelMode=car&key=EsMKu4XN343S6tEmAHH6yeRKrYXxmTBC");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data.toString());
        var responsejson = json.decode(response.data.toString());
        print(responsejson);
        distance=responsejson["routes"][0]["summary"]["lengthInMeters"];
        time=responsejson["routes"][0]["summary"]["travelTimeInSeconds"];
        for (var element in responsejson["routes"][0]["legs"][0]["points"]) {
          waypoints.add(LatLng(element["latitude"],element["longitude"]));
          }
        print(waypoints);
        return MyRoute(waypoints: waypoints,distance: distance,time: time);
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        print(response.data.toString());
        return "ERROR" + response.data.toString();
      }
    } on DioError catch (exception) {
      print("IAMAT route");

      if (exception == null ||
          exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        throw Exception(
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        print(exception.error);
        print(exception.message);

        return null;
      }
    }
  }

}
