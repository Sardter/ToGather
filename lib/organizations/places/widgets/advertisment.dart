import 'package:flutter/material.dart';
import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/utilities/utilities.dart';

class AdvertisementWidget extends StatefulWidget {
  const AdvertisementWidget({super.key, required this.advertisement});
  final PlaceAdvertisement advertisement;

  @override
  State<AdvertisementWidget> createState() => _AdvertisementWidgetState();
}

class _AdvertisementWidgetState extends State<AdvertisementWidget> {
  @override
  Widget build(BuildContext context) {
    return SylvestCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: ThemeService.allAroundBorderRadius,
              child: SylvestImage(
                  image: widget.advertisement.image,
                  useDefault: false,
                  height: 170,
                  width: 300,
                  defaultImage: null),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(widget.advertisement.description),
            )
          ],
        ));
  }
}
