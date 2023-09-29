import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/utilities/utilities.dart';

class MapPlaceMarker extends MapMarker {
  MapPlaceMarker(
      {required Place place,
      super.height,
      super.width,
      super.showTitle,
      super.canLaunchPage})
      : super(
            id: place.id,
            image: place.banner,
            title: place.title,
            model: place,
            locationDescription: place.locationDescription,
            category: place.category,
            location: place.location!,
            type: MarkerType.Place);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: canLaunchPage ? () => launchPage(context, PlaceDetailPage(id: id!)) : null,
      child: MarkerWidget(
          size: min(height, width),
          icon: Icons.store,
          color: ThemeService.placeColor,
          title: title,
          showTitle: showTitle,
          category: category,
          image: image),
    );
  }
}
