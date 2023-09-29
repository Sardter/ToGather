import 'package:ToGather/category/category.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/organizations/models/organization.dart';
import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:latlong2/latlong.dart';

class Place extends Organization implements ModelWithMedia {
  final PlaceRequestData requestData;

  const Place(
      {required super.id,
      required super.title,
      required super.image,
      required super.ratingCount,
      required super.location,
      required super.banner,
      required super.verified,
      required super.about,
      required super.tags,
      required super.locationDescription,
      required this.requestData,
      required super.reviewAverage,
      required super.posts,
      required super.links,
      required super.events,
      required super.eventAttends,
      required super.category});

  factory Place.fromJson(Map<String, dynamic> json) {
    final media = List<Map>.from(json['media'])
        .map((e) => NetworkMediaData.fromURL(e['url'] ?? ""))
        .toList();

    return Place(
        id: json['id'],
        title: json['name'],
        about: json['description'],
        image: media.isEmpty
            ? null
            : media[0] is NetworkEmptyMediaData
                ? null
                : media[0] as ImageData,
        ratingCount: json['rate_count'],
        reviewAverage: json['rate'],
        banner: media.isEmpty
            ? null
            : media[1] is NetworkEmptyMediaData
                ? null
                : media[0] as ImageData,
        events: json['events'] ?? 0,
        verified: json['is_verified'] ?? false,
        locationDescription: json['location_description'],
        links: List<Map>.from(json['links']?['links'] ?? [])
            .map((e) => LinkData.fromJson(e))
            .toList(),
        eventAttends: json['event_attends'] ?? 0,
        posts: json['posts'] ?? 0,
        tags: List<String>.from(json['tags']),
        category: Category.fromJson(json['category']),
        requestData: PlaceRequestData.fromJson(json['request_data']),
        location: LatLng(json['latitude'] ?? 0, json['longitude'] ?? 0));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'description': about,
      'media': [
        if (image == null) NetworkEmptyMediaData() else image,
        if (banner == null) NetworkEmptyMediaData() else banner
      ].map((e) => e!.toJson()).toList(),
      'verified': verified,
      'latitude': location?.latitude,
      'longitude': location?.longitude,
      'location_description': locationDescription,
      'category_id': category.id,
      'links': links.map((e) => e.toJson()).toList(),
      'tags': tags,
    };
  }

  @override
  MarkerType get markerType => MarkerType.Place;

  @override
  List<MediaData?> get media => [image, banner];
}
