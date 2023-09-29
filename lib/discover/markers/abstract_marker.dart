import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

enum MarkerType { Event, Post, Club, Place, Profile, None }

abstract class AbstractMapMarker extends Widget {
  final LatLng location;
  final int? id;
  final double width;
  final double height;
  final MarkerType type;

  const AbstractMapMarker(
      {required this.location,
      required this.id,
      this.type = MarkerType.None,
      this.height = 60,
      this.width = 60});
}