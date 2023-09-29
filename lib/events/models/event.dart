import 'package:ToGather/category/category.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/events/models/models.dart';
import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/users/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:latlong2/latlong.dart';

class Event extends LocationModel implements ModelWithMedia {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final int attendees;
  final String? description;
  final double? reviewsAverage;
  final int? ratingCount;
  final bool verified;
  final Category category;
  final EventHost? host;
  final bool isOnline;
  final bool isPrivate;
  final List<LinkData> links;
  final EventRequestData requestData;
  final List<String> tags;
  final List<FormBlockData>? formData;
  final List<MediaData> media;

  const Event(
      {required super.id,
      required super.location,
      required this.description,
      required this.links,
      required this.ratingCount,
      required this.requestData,
      required this.tags,
      required this.reviewsAverage,
      required this.startDate,
      required this.formData,
      required this.isOnline,
      required this.isPrivate,
      required this.media,
      required super.locationDescription,
      required this.attendees,
      required this.host,
      required this.title,
      required this.endDate,
      required this.category,
      required this.verified});

  factory Event.fromJson(Map<String, dynamic> json) {
    print("event josn: $json");
    return Event(
        id: json['id'],
        location: LatLng(json['latitude'] ?? 0, json['longitude'] ?? 0),
        description: json['description'],
        links: List<Map>.from(json['links']?['links'] ?? [])
            .map((e) => LinkData.fromJson(e))
            .toList(),
        ratingCount: json['rate_count'],
        requestData: EventRequestData.fromJson(json['request_data']),
        tags: List<String>.from(json['tags']),
        reviewsAverage: json['rate'],
        startDate: DateTime.parse(json['start_date']),
        formData: json['form'] == null
            ? null
            : List<Map<String, dynamic>>.from(json['form']?['items'] ?? [])
                .map((e) => FormBlockData.fromJson(e))
                .toList(),
        isOnline: json['is_online'] ?? false,
        isPrivate: json['is_private'] ?? false,
        media: List<Map>.from(json['media'])
            .map((e) => NetworkMediaData.fromURL(e['url']))
            .toList(),
        locationDescription: json['location_description'],
        attendees: json['attendee_count'] ?? 0,
        host: EventHost.fromJson(json),
        title: json['name'],
        endDate: DateTime.parse(json['end_date']),
        category: Category.fromJson(json['category']),
        verified: json['is_verified'] ?? false);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'description': description,
      'latitude': location?.latitude,
      'longitude': location?.longitude,
      'location_description': locationDescription,
      'category_id': category.id,
      'start_date': startDate.toString(),
      'end_date': endDate.toString(),
      'links': links.map((e) => e.toJson()).toList(),
      'tags': tags,
      'from': formData?.map((e) => e.toJson()).toList(),
      'media': media.map((e) => e.toJson()).toList(),
      'is_private': isPrivate,
      'is_online': isOnline,
    };
  }

  @override
  MarkerType get markerType => MarkerType.Event;
}
