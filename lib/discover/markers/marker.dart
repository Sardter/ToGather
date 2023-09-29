import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:ToGather/category/category.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/sharables/models/models.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

import 'markers.dart';

class MapMarker extends StatelessWidget implements AbstractMapMarker {
  final ImageData? image;
  final LatLng location;
  final String? locationDescription;
  final int? id;
  final double width;
  final double height;
  final MarkerType type;
  final String title;
  final Category? category;
  final bool showTitle;
  final bool canLaunchPage;
  final LocationModel? model;

  MapMarker copyWith({bool showTitle = true, bool canLaunchPage = true}) {
    return MapMarker(
      image: image,
      location: location,
      id: id,
      title: title,
      showTitle: showTitle,
      type: type,
      locationDescription: locationDescription,
      category: category,
      model: model,
      height: height,
      width: width,
    );
  }

  const MapMarker(
      {required this.image,
      this.height = 75,
      this.width = 60,
      required this.location,
      required this.id,
      required this.category,
      required this.locationDescription,
      required this.title,
      required this.model,
      this.showTitle = true,
      this.canLaunchPage = true,
      this.type = MarkerType.None});

  factory MapMarker.fromModel(LocationModel model) {
    switch (model.runtimeType) {
      case Event:
        return MapEventMarker.fromEvent(model as Event);
      case Club:
        return MapClubMarker.fromClub(model as Club);
      case Post:
        return MapPostMarker(post: model as Post);
      case Place:
        return MapPlaceMarker(place: model as Place);
      case Profile:
        return MapUserMarker(user: model as Profile);
      default:
        throw UnimplementedError();
    }
  }

  MarkerHash? get hash => id == null ? null : MarkerHash(id: id!, type: type);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.location_pin,
          color: ThemeService.eventColor, size: min(width, height)),
    );
  }
}
