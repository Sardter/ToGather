import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

abstract class PostAuthor {
  ImageData? get image;
  String get title;

  factory PostAuthor.fromJson(Map<String, dynamic> json) {
    if (json['author_club'] != null && (json['shared_by_admin'] ?? false))
      return PostClubAuthor.fromClub(Club.fromJson(json['author_club']));
    else if (json['author_user'] != null)
      return PostUserAuthor.fromProfile(Profile.fromJson(json['author_user']));
    return PostAnonymousAuthor();
  }
}

class PostUserAuthor extends Profile implements PostAuthor {
  const PostUserAuthor(
      {required super.id,
      required super.username,
      required super.verified,
      required super.reviewAverage,
      required super.locationDescription,
      required super.requestData,
      required super.location,
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

  @override
  ImageData? get image => this.profileImage;

  @override
  String get title => this.username;

  factory PostUserAuthor.fromProfile(Profile user) {
    return PostUserAuthor(
        id: user.id,
        username: user.username,
        location: user.location,
        locationDescription: user.locationDescription,
        verified: user.verified,
        reviewAverage: user.reviewAverage,
        requestData: user.requestData,
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

class PostClubAuthor extends Club implements PostAuthor {
  const PostClubAuthor(
      {required super.id,
      required super.title,
      required super.image,
      required super.members,
      required super.postPolicy,
      required super.ratingCount,
      required super.location,
      required super.reviewAverage,
      required super.verified,
      required super.banner,
      required super.links,
      required super.about,
      required super.locationDescription,
      required super.events,
      required super.eventAttends,
      required super.posts,
      required super.tags,
      required super.category,
      required super.requestData});

  factory PostClubAuthor.fromClub(Club club) {
    return PostClubAuthor(
        id: club.id,
        title: club.title,
        image: club.image,
        members: club.members,
        postPolicy: club.postPolicy,
        ratingCount: club.ratingCount,
        location: club.location,
        reviewAverage: club.reviewAverage,
        verified: club.verified,
        banner: club.banner,
        links: club.links,
        about: club.about,
        locationDescription: club.locationDescription,
        events: club.events,
        eventAttends: club.eventAttends,
        posts: club.posts,
        tags: club.tags,
        category: club.category,
        requestData: club.requestData);
  }
}

class PostAnonymousAuthor implements PostAuthor {
  @override
  ImageData? get image => /* NetworkImageData(url: /*DefaultImageManager.anonUser*/ null) */ null;

  @override
  String get title => "Anonim";
}
