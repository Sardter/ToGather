import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/utilities/utilities.dart';

class MapEventMarker extends MapMarker {
  const MapEventMarker(
      {required super.image,
      required super.location,
      required super.id,
      required super.category,
      required super.locationDescription,
      super.height,
      super.width,
      super.canLaunchPage,
      super.showTitle,
      super.model,
      super.type,
      required super.title});

  factory MapEventMarker.fromEvent(Event event) {
    return MapEventMarker(
        image: event.media
                .where((element) => element is NetworkImageData)
                .isNotEmpty
            ? (event.media.firstWhere((element) => element is NetworkImageData)
                as NetworkImageData)
            : null,
        location: event.location!,
        id: event.id,
        category: event.category,
        model: event,
        locationDescription: event.locationDescription,
        type: MarkerType.Event,
        title: event.title);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          canLaunchPage ? () => launchPage(context, EventPage(id: id!)) : null,
      child: MarkerWidget(
          size: min(height, width),
          icon: Icons.local_activity,
          color: ThemeService.eventColor,
          title: title,
          showTitle: showTitle,
          category: category,
          image: image),
    );
  }
}
