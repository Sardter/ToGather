import 'package:ToGather/utilities/utilities.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../config/firebase_options.dart';

LatLng? postionFromString(String? str) {
  if (str == null || str.isEmpty) return null;
  try {
    final cordsStr = str.split(',');
    final lat = double.parse(cordsStr[0]);
    final lng = double.parse(cordsStr[1]);
    return LatLng(lat, lng);
  } catch (e) {
    return null;
  }
}

bool ifNullThenFalseElse(bool? item) {
  return item != null && item;
}

Future<FirebaseApp?> initializeFirebase() async {
  if (kIsWeb) return null;

  try {
    return Firebase.app("sylvest_firebase");
  } catch (e) {
    print(e);
    print("initializing");
    try {
      final app = await Firebase.initializeApp(
        name: "sylvest_firebase",
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print(app);
      return app;
    } catch (e) {
      print("Failed to initiliaze firebase");
      print(e);
    }
    return null;
  }
}

Iterable<T> uniqueBy<T, V>(Iterable<T> items, V Function(T) attr) {
  var uniqueItemsMap = <V, T>{};

  for (var item in items) {
    var value = attr(item); // Extract value of the attribute
    if (!uniqueItemsMap.containsKey(value)) {
      // Check for uniqueness
      uniqueItemsMap[value] = item;
    }
  }

  return uniqueItemsMap.values;
}

String dateTimeToStr(DateTime date) {
  final min =
      '${date.minute}'.length == 1 ? '0${date.minute}' : '${date.minute}';
  final hour = '${date.hour}'.length == 1 ? '0${date.hour}' : '${date.hour}';
  return '${date.day}/${date.month}/${date.year}, $hour:$min';
}

Future<dynamic> launchPage<T>(BuildContext context, Widget page) async {
  try {
    return await Navigator.push<T>(
      context, MaterialPageRoute(builder: (context) => page));
  } catch (e) {
    return null;
  }
}

void closePage(BuildContext context, {dynamic result}) {
  try {
    Navigator.pop(context, result);
  } catch (e) {
    
  }
}

String getShortNumber(var number) {
  var f = NumberFormat.compact(locale: "tr_TR");
  return f.format(number);
}

Future<double?> rate(
    {required BuildContext context,
    required Future<double?> Function(double? score) onRate,
    required double? initialScore}) async {
  return await showDialog<double?>(
      context: context,
      builder: (context) => RatePage(
            onRate: onRate,
            initialScore: initialScore,
          ));
}

double? calculateRadius(MapController mapController) {
  // Get the bounds of the current map view
  LatLngBounds? bounds = mapController.bounds;

  if (bounds == null) return null;

  double zoom = mapController.zoom;

  LatLng? northEast = bounds.northEast;
  LatLng? southWest = bounds.southWest;

  if (northEast == null || southWest == null) return null;

  double distance = Distance().distance(southWest, northEast);

  double radius = distance /
      (zoom + 1); // Adding 1 to avoid division by zero for very low zoom levels

  return radius;
}
