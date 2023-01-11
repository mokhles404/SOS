


import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/Place.dart';

class PointList{
  Future<List<Place>> getdata() async {
    final jsondata = await rootBundle.loadString("assets/data/tracks.json");
    var userMap =
    jsonDecode(jsondata) as List<dynamic>;

    return userMap.map((e) => Place.fromJson(e)).toList();
  }
}