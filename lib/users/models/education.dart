import 'package:ToGather/discover/markers/abstract_marker.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:latlong2/latlong.dart';

class University extends LocationModel {
  final String schoolName;

  const University(
      {required this.schoolName,
      required super.id,
      required super.location,
      required super.locationDescription});

  factory University.fromJson(Map<String, dynamic> json) {
    print(json);
    return University(
        schoolName: json['name'],
        id: json['id'],
        location: LatLng(
            json['latitude'] is String
                ? double.tryParse(json['latitude']) ?? 0
                : json['latitude'] ?? 0,
            json['longitude'] is String
                ? double.tryParse(json['longitude']) ?? 0
                : json['longitude'] ?? 0),
        locationDescription: json['location_description']);
  }

  @override
  MarkerType get markerType => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': schoolName,
      'latitude': location?.latitude,
      'longitude': location?.longitude,
      'location_description': locationDescription,
    };
  }
}
