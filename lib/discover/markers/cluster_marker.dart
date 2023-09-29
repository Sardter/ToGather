import 'package:flutter_map/plugin_api.dart';

import 'markers.dart';

class ClusterMarker extends Marker {
  final MapMarker marker;
  ClusterMarker(
      {super.anchorPos,
      required super.height,
      required this.marker,
      required super.width,
      required super.point,
      required super.builder});

  MarkerHash get hash => marker.hash!;
}

