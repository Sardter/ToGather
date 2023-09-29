import 'package:ToGather/events/events.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/users/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';

abstract class EventHost extends Model {
  const EventHost({required super.id});

  ImageData? get image;

  String get title;

  bool get verified;

  double? get reviewAverage;

  Widget get detailPage;

  factory EventHost.fromJson(Map<String, dynamic> json) {
    if (json['host_user'] != null) {
      print(json['host_user']);
      return EventUserHost.fromUser(Profile.fromJson(json['host_user']));
    }
      
    else if (json['host_club'] != null)
      return EventClubHost.fromClub(Club.fromJson(json['host_club']));
    throw UnimplementedError("Neither host_user nor host_club are present");
  }
}

class EventClubHost extends Club implements EventHost {
  const EventClubHost(
      {required super.id,
      required super.title,
      required super.image,
      required super.postPolicy,
      required super.ratingCount,
      required super.members,
      required super.verified,
      required super.reviewAverage,
      required super.location,
      required super.locationDescription,
      required super.banner,
      required super.about,
      required super.events,
      required super.eventAttends,
      required super.posts,
      required super.tags,
      required super.category,
      required super.requestData,
      required super.links});

  factory EventClubHost.fromClub(Club club) {
    return EventClubHost(
        id: club.id,
        title: club.title,
        image: club.image,
        members: club.members,
        ratingCount: club.ratingCount,
        verified: club.verified,
        reviewAverage: club.reviewAverage,
        location: club.location,
        banner: club.banner,
        about: club.about,
        postPolicy: club.postPolicy,
        locationDescription: club.locationDescription,
        events: club.events,
        eventAttends: club.eventAttends,
        posts: club.posts,
        links: club.links,
        tags: club.tags,
        category: club.category,
        requestData: club.requestData);
  }

  @override
  Widget get detailPage => ClubPage(id: id);
}

class EventUserHost extends Profile implements EventHost {
  const EventUserHost(
      {required super.id,
      required super.username,
      required super.location,
      required super.reviewAverage,
      required super.verified,
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

  factory EventUserHost.fromUser(Profile user) {
    return EventUserHost(
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

  @override
  ImageData? get image => profileImage;

  @override
  String get title => username;

  @override
  Widget get detailPage => throw EventPage(id: id);
}
