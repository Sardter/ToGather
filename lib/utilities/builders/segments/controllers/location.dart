import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/utilities/utilities.dart';

class BuilderLocationData {
  final String description;
  final LatLng location;

  const BuilderLocationData(
      {required this.description, required this.location});
}

class BuilderLocationController
    extends BuilderSegmentController<BuilderLocationData?> {
  BuilderLocationController(
      {LatLng? selectedLocation, this.initialLocationDescription}) {
    mapItemController.setMarker(selectedLocation);
  }

  factory BuilderLocationController.fromLocationModel(LocationModel model) {
    return BuilderLocationController(
        selectedLocation: model.location,
        initialLocationDescription: model.locationDescription);
  }

  final String? initialLocationDescription;

  LatLng? get selectedLocation => mapItemController.locationMarker?.location;

  final mapItemController = MapItemController(items: []);
  late final locationDescription =
      TextEditingController(text: initialLocationDescription);
  late final hasLocationCheckBoxController =
      SylvestCheckBoxController(toggled: selectedLocation != null);

  @override
  BuilderLocationData? get data =>
      isValid && hasLocationCheckBoxController.toggled.value
          ? BuilderLocationData(
              description: locationDescription.text,
              location: mapItemController.locationMarker!.location)
          : null;

  @override
  List<String> get errorMesseges => [
        if (hasLocationCheckBoxController.toggled.value &&
            mapItemController.locationMarker == null)
          "Konum boş olamaz"
      ];
}
