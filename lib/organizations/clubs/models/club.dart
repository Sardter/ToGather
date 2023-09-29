import 'package:ToGather/category/category.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/organizations/clubs/models/models.dart';
import 'package:ToGather/organizations/models/organization.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:latlong2/latlong.dart';

class Club extends Organization implements ModelWithMedia {
  final int members;
  final bool postPolicy;
  final ClubRequestData? requestData;

  const Club(
      {required super.id,
      required super.title,
      required super.about,
      required super.image,
      required super.ratingCount,
      required super.reviewAverage,
      required super.banner,
      required super.events,
      required this.postPolicy,
      required super.verified,
      required super.locationDescription,
      required super.links,
      required super.eventAttends,
      required super.posts,
      required super.tags,
      required this.members,
      required super.category,
      required this.requestData,
      required super.location});

  factory Club.fromJson(Map<String, dynamic> json) {
    print(json);
    final media = List<String>.from(json['media'] ?? [])
        .map((e) => NetworkMediaData.fromURL(e))
        .toList();

    return Club(
        id: json['id'],
        title: json['name'],
        about: json['description'],
        image: media[0] is NetworkEmptyMediaData ? null : media[0] as ImageData,
        ratingCount: json['rate_count'],
        reviewAverage: json['rate'],
        banner:
            media[1] is NetworkEmptyMediaData ? null : media[0] as ImageData,
        events: json['events'] ?? 0,
        verified: json['is_verified'] ?? false,
        locationDescription: json['location_description'],
        links: List<Map>.from(json['links']?['links'] ?? [])
            .map((e) => LinkData.fromJson(e))
            .toList(),
        postPolicy: json['post_policy'] ?? false,
        eventAttends: json['event_attends'] ?? 0,
        posts: json['posts'] ?? 0,
        tags: List<String>.from((json['tags'] ?? []).cast<String>()),
        members: json['members'] ?? 0,
        category: Category.fromJson(json['category']),
        requestData: json['request_data'] == null
            ? null
            : ClubRequestData.fromJson(json['request_data']),
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
      'post_policy': postPolicy,
      'category_id': category.id,
      'links': {'links': links.map((e) => e.toJson()).toList()},
      'tags': tags,
    };
  }

  @override
  MarkerType get markerType => MarkerType.Club;
  
  @override
  List<MediaData?> get media => [image, banner];
}
