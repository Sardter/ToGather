import 'package:ToGather/utilities/utilities.dart';

class PlaceAdvertisement extends Model {
  final String description;
  final ImageData image;

  const PlaceAdvertisement(
      {required super.id, required this.description, required this.image});

  factory PlaceAdvertisement.fromJson(Map<String, dynamic> json) {
    final media = List<Map>.from(json['media'])
        .map((e) => NetworkMediaData.fromURL(e['url'] ?? ""))
        .toList();

    return PlaceAdvertisement(
        id: json['id'], image: media[0] as ImageData, description: json['description']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'media': [
        image,
      ].map((e) => e.toJson()).toList(),
      'description': description
    };
  }
}
