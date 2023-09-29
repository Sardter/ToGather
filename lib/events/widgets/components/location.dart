import 'package:flutter/material.dart';
import 'package:ToGather/discover/discover.dart';

import 'package:ToGather/utilities/services/theme.dart';

class LocationDetailWidget extends StatefulWidget {
  const LocationDetailWidget({super.key, required this.marker});

  final MapMarker marker;

  @override
  State<LocationDetailWidget> createState() => _LocationDetailWidgetState();
}

class _LocationDetailWidgetState extends State<LocationDetailWidget> {
  late final _mapItemController = MapItemController(items: [widget.marker]);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Icon(Icons.location_pin, size: 40),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.marker.locationDescription != null)
                    Text(widget.marker.locationDescription!,
                        style: TextStyle(
                            fontFamily: ThemeService.headlineFont,
                            fontSize: 18)),
                  Text("Harita üzerinde göster",
                      style: TextStyle(
                          color: ThemeService.secondaryText,
                          fontFamily: ThemeService.headlineFont,
                          fontSize: 12)),
                ],
              ))
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: MapWidget(
            markTapLocation: false,
            defaultLocation: widget.marker.location,
            mapItemController: _mapItemController,
            isInteractive: false,
          ),
        )
      ],
    );
  }
}
