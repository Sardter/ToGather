import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:background_location/background_location.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  static final LocationService _locationService = LocationService._internal();
  factory LocationService() {
    return _locationService;
  }
  LocationService._internal();

  final currentLocation = ValueNotifier<LatLng?>(null);

  Future<bool> requestPermision() async {
    print("requesting permision");

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    } else if (permission == LocationPermission.deniedForever) {
      return false;
    }

    /* bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      print("service not enabled");
      return false;
    } */

    return true;
  }

  Future<LatLng?> getCurrentLocation() async {
    //if (!await requestPermision()) return null;
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("current location: $position");

    final result = LatLng(position.latitude, position.longitude);

    currentLocation.value = result;

    return result;
  }

  void initStream(void Function(LatLng postion) onUpdate) async {
    BackgroundLocation.startLocationService(forceAndroidLocationManager: true, distanceFilter: 10);
    print("started location stream");

    await getCurrentLocation();

    BackgroundLocation.getLocationUpdates((location) {
      print("location: $location");

      if (location.latitude != null && location.longitude != null) {
        currentLocation.value = LatLng(location.latitude!, location.longitude!);
        onUpdate(currentLocation.value!);
      }
    });
  }
}
