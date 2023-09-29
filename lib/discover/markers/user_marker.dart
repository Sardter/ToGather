import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/users/models/models.dart';
import 'package:ToGather/users/pages/user_page.dart';
import 'package:ToGather/utilities/utilities.dart';

class MapUserMarker extends MapMarker {
  MapUserMarker(
      {required Profile user,
      super.height,
      super.width,
      super.showTitle,
      super.canLaunchPage})
      : super(
            id: user.id,
            locationDescription: user.locationDescription,
            model: user,
            image: user.images
                    .where((element) => element is NetworkImageData)
                    .isNotEmpty
                ? (user.images
                        .firstWhere((element) => element is NetworkImageData)
                    as NetworkImageData)
                : null,
            title: user.username,
            category: null,
            location: user.location!,
            type: MarkerType.Profile);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: canLaunchPage ? () => UserPage(setPage: (id) {}, id: id!) : null,
      child: MarkerWidget(
          size: min(height, width),
          icon: Icons.person,
          color: ThemeService.friendColor,
          showTitle: showTitle,
          title: title,
          image: image),
    );
  }
}
