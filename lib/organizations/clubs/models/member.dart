import 'package:ToGather/users/models/models.dart';

class ClubMember extends Profile {
  final bool isAdmin;

  const ClubMember(
      {required super.id,
      required super.username,
      required this.isAdmin,
      required super.verified,
      required super.reviewAverage,
      required super.location,
      required super.requestData,
      required super.locationDescription,
      required super.firstName,
      required super.lastName,
      required super.about,
      required super.posts,
      required super.educationData,
      required super.connections,
      required super.birth,
      required super.email,
      required super.links,
      required super.interestes,
      required super.isPrivate,
      required super.images,
      required super.gender});

  factory ClubMember.fromUser(Profile user, {bool isAdmin = false}) =>
      ClubMember(
          id: user.id,
          username: user.username,
          location: user.location,
          locationDescription: user.locationDescription,
          verified: user.verified,
          reviewAverage: user.reviewAverage,
          requestData: user.requestData,
          isAdmin: isAdmin,
          firstName: user.firstName,
          lastName: user.lastName,
          about: user.about,
          posts: user.posts,
          educationData: user.educationData,
          connections: user.connections,
          birth: user.birth,
          email: user.email,
          links: user.links,
          interestes: user.interestes,
          isPrivate: user.isPrivate,
          images: user.images,
          gender: user.gender);
}
