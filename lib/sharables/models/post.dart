import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:latlong2/latlong.dart';

import 'models.dart';

class Post extends Sharable implements LocationModel {
  final String title;
  //final DateTime? endDate;
  final LatLng? location;
  final String? locationDescription;
  final List<String> tags;
  final bool isPrivate;
  final Club? club;
  final Event? event;

  const Post(
      {required super.media,
      required super.content,
      required super.id,
      required this.title,
      required this.locationDescription,
      required super.commentCount,
      required super.datePosted,
      required this.isPrivate,
      required this.tags,
      //required this.endDate,
      required super.isAnonymous,
      required this.location,
      required this.club,
      required this.event,
      required super.ratingAverage,
      required super.author,
      required super.rateCount,
      required super.requestData});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        media: List<String>.from(json['media'] ?? [])
            .map((e) => NetworkMediaData.fromURL(e))
            .toList(),
        content: json['content'],
        id: json['id'],
        title: json['title'],
        locationDescription: json['location_description'],
        commentCount: json['comments'] ?? 0,
        isAnonymous: json['is_anon'] ?? false,
        datePosted: DateTime.parse(json['created_at']),
        club: json['author_club'] == null
            ? null
            : Club.fromJson(json['author_club']),
        event: json['event_id'],
        isPrivate: json['is_private'] ?? false,
        tags: List<String>.from(json['tags'] ?? []),
        location: LatLng(json['latitude'] ?? 0, json['longitude'] ?? 0),
        ratingAverage: json['rate'] ?? 0,
        author: PostAuthor.fromJson(json),
        rateCount: json['rate_count'] ?? 0,
        requestData: json['request_data'] == null
            ? null
            : SharableRequestData.fromJson(json['request_data']));
  }

  @override
  MarkerType get markerType => MarkerType.Post;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'title': title,
      'author_club_id': club?.id,
      'latitude': location?.latitude,
      'longitude': location?.longitude,
      'location_description': locationDescription,
      'tags': tags,
      'event_id': event?.id,
      'media': media.map((e) => e.toJson()).toList(),
      'is_private': isPrivate,
      'is_anon': isAnonymous,
    };
  }
}
