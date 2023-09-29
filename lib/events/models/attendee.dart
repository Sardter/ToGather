import 'package:ToGather/users/users.dart';

class EventAttendee extends Profile {
  final bool attended;
  const EventAttendee(
      {required super.id,
      required super.username,
      required super.location,
      required super.locationDescription,
      required super.verified,
      required super.reviewAverage,
      required super.requestData,
      required this.attended,
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

  factory EventAttendee.fromUser(Profile user, {bool attended = false}) {
    return EventAttendee(
        id: user.id,
        username: user.username,
        location: user.location,
        locationDescription: user.locationDescription,
        verified: user.verified,
        reviewAverage: user.reviewAverage,
        requestData: user.requestData,
        attended: attended,
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
}
