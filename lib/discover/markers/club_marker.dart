import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/utilities/utilities.dart';

class MapClubMarker extends MapMarker {
  const MapClubMarker(
      {required super.image,
      required super.location,
      required super.id,
      required super.category,
      required super.locationDescription,
      super.height,
      super.width,
      super.canLaunchPage,
      super.type,
      super.showTitle,
      super.model,
      required super.title});

  factory MapClubMarker.fromClub(Club club) {
    return MapClubMarker(
        id: club.id,
        image: club.banner,
        title: club.title,
        category: club.category,
        model: club,
        locationDescription: club.locationDescription,
        location: club.location!,
        type: MarkerType.Club);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: canLaunchPage ? () => launchPage(context, ClubPage(id: id!)) : null,
      child: MarkerWidget(
          size: min(height, width),
          icon: Icons.people,
          color: ThemeService.clubColor,
          showTitle: showTitle,
          title: title,
          category: category,
          image: image),
    );
  }
}
