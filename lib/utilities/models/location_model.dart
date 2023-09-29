import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:latlong2/latlong.dart';

abstract class LocationModel extends Model {
  final LatLng? location;
  final String? locationDescription;
  const LocationModel({required super.id, required this.location, required this.locationDescription});

  MarkerType get markerType;
}