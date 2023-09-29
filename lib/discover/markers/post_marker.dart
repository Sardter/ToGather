import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/sharables/models/models.dart';
import 'package:ToGather/sharables/pages/detail_page.dart';
import 'package:ToGather/utilities/utilities.dart';

class MapPostMarker extends MapMarker {
  MapPostMarker(
      {required Post post,
      super.height,
      super.width,
      super.showTitle,
      super.canLaunchPage})
      : super(
            id: post.id,
            locationDescription: post.locationDescription,
            model: post,
            image: post.media
                    .where((element) => element is NetworkImageData)
                    .isNotEmpty
                ? (post.media
                        .firstWhere((element) => element is NetworkImageData)
                    as NetworkImageData)
                : null,
            title: post.title,
            category: null,
            location: post.location!,
            type: MarkerType.Post);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: canLaunchPage ? () => launchPage(context, PostDetailPage(id: id!)) : null,
      child: MarkerWidget(
          size: min(height, width),
          icon: Icons.grid_3x3,
          showTitle: showTitle,
          color: ThemeService.postColor,
          title: title,
          image: image),
    );
  }
}
