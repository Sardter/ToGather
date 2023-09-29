import 'package:ToGather/category/category.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/users/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:email_validator/email_validator.dart';
import 'package:latlong2/latlong.dart';

class LinkData {
  final String url;
  final String type;

  const LinkData({required this.url, required this.type});

  factory LinkData.fromJson(Map json) {
    return LinkData(url: json['url'], type: json['type']);
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'type': type};
  }
}

class Profile extends LocationModel implements ModelWithMedia {
  final String about;
  final List<MediaData> images;
  final List<Category> interestes;
  final int posts;
  final int connections;
  final String email;
  final String? gender;
  final DateTime? birth;
  final bool isPrivate;
  final List<LinkData> links;
  final University? educationData;
  final String username;
  final bool verified;
  final double? reviewAverage;
  final String firstName;
  final String lastName;
  final ProfileRequestData? requestData;

  @override
  List<MediaData?> get media => images;

  const Profile(
      {required super.id,
      required this.about,
      required this.posts,
      required this.educationData,
      required super.locationDescription,
      required this.requestData,
      required this.username,
      required super.location,
      required this.reviewAverage,
      required this.verified,
      required this.connections,
      required this.birth,
      required this.firstName,
      required this.email,
      required this.links,
      required this.interestes,
      required this.isPrivate,
      required this.images,
      required this.lastName,
      required this.gender});

  ImageData? get profileImage =>
      (images.isEmpty ? null : images.first) as ImageData?;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        id: json['id'],
        about: json['bio'] ?? "",
        posts: json['post_count'] ?? 0,
        educationData: json['university'] == null
            ? null
            : University.fromJson(json['university']),
        locationDescription: null,
        requestData: json['request_data'] == null
            ? null
            : ProfileRequestData.fromJson(json['request_data']),
        username: json['username'],
        location: LatLng(json['latitude'] ?? 0, json['longitude'] ?? 0),
        reviewAverage: json['rate'],
        verified: json['is_verified'] ?? false,
        connections: json['connection_count'] ?? 0,
        birth: json['birth_date'] == null
            ? null
            : DateTime.parse(json['birth_date']),
        firstName: json['first_name'] ?? "",
        email: json['email'],
        links: List<Map>.from(json['links']?['links'] ?? [])
            .map((e) => LinkData.fromJson(e))
            .toList(),
        interestes: List<Map<String, dynamic>>.from(json['interests'])
            .map((e) => Category.fromJson(e))
            .toList(),
        isPrivate: json['is_priavte'] ?? false,
        images: List<String>.from(json['media'] ?? [])
            .map((e) => NetworkMediaData.fromURL(e))
            .toList(),
        lastName: json['last_name'] ?? "",
        gender: json['gender']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      //'id': id,
      'bio': about,
      'university_id': educationData?.id,
      //'latitude': location?.latitude,
      //'longitude': location?.longitude,
      'social_links': {'links': links.map((e) => e.toJson()).toList()},
      'media': images.map((e) => e.toJson()).toList(),
      'is_private': isPrivate,
      'is_verified': verified,
      'username': username,
      'email': EmailValidator.validate(email) ? email : null,
      'first_name': firstName,
      'last_name': lastName,
      'birth': birth?.toString(),
      'gender': gender
    };
  }

  @override
  MarkerType get markerType => MarkerType.Profile;
}
