import 'package:flutter/material.dart';
import 'package:ToGather/users/models/models.dart';
import 'package:ToGather/users/services/services.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:latlong2/latlong.dart';

class ProfileTestModelService extends ProfileModelService {
  @override
  Future<bool> deleteItem({required ItemParameters itemParameters}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return true;
  }

  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return true;
  }

  @override
  Future<bool?> hideItem({required ItemParameters itemParameters}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return true;
  }

  @override
  Future<Profile?> getItem({required ItemParameters itemParameters}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return Profile(
        id: 1,
        about: "Profile About",
        locationDescription: "Bilkent G-132",
        reviewAverage: 5,
        verified: true,
        posts: 2,
        educationData: await ModelServiceFactory.UNIVERSITY
            .getItem(itemParameters: ItemParameters()),
        interestes: await ModelServiceFactory.CATEGORY.getList() ?? [],
        isPrivate: false,
        requestData: ProfileRequestData(
            connectionStatus: ConnectionStatus.Me,
            isBlocked: false,
            isBlockedBy: false,
            allowedActions: ProfileAllowedActions(
                canUpdate: true,
                canDelete: true,
                canHide: false,
                canBlock: false,
                canConnect: false,
                canReport: false)),
        username: "Sardter",
        location: LatLng(28, 28),
        connections: 200,
        birth: DateTime.now(),
        firstName: "Sadra",
        email: "sadra701@gmail.com",
        links: [
          LinkData(url: "aaa", type: "whatsapp"),
          LinkData(url: "aaa", type: "snapchat"),
          LinkData(url: "aaa", type: "email"),
        ],
        images: [
          NetworkImageData(
              url:
                  "https://media.licdn.com/dms/image/D4D03AQFfz6iHmaZm1A/profile-displayphoto-shrink_800_800/0/1667086029305?e=2147483647&v=beta&t=XhhHXF4g_tAp-1iV6srIZsZ9AN067b8xqaQCXKlpzrs")
        ],
        lastName: "Mohammadzadehazarabadi",
        gender: "Male");
  }

  @override
  Future<List<Profile>?> getList({QueryParameters? queryParameters}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return [
      Profile(
          id: 1,
          about: "Profile About",
          locationDescription: "Bilkent G-132",
          posts: 2,
          interestes: await ModelServiceFactory.CATEGORY.getList() ?? [],
          reviewAverage: 5,
          verified: true,
          educationData: await ModelServiceFactory.UNIVERSITY
              .getItem(itemParameters: ItemParameters()),
          isPrivate: false,
          requestData: ProfileRequestData(
              connectionStatus: ConnectionStatus.Me,
              isBlocked: false,
              isBlockedBy: false,
              allowedActions: ProfileAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canHide: false,
                  canBlock: false,
                  canConnect: false,
                  canReport: false)),
          username: "Sardter",
          location: LatLng(28, 28),
          connections: 200,
          birth: DateTime.now(),
          firstName: "Sadra",
          email: "sadra701@gmail.com",
          links: [],
          images: [
            NetworkImageData(
                url:
                    "https://media.licdn.com/dms/image/D4D03AQFfz6iHmaZm1A/profile-displayphoto-shrink_800_800/0/1667086029305?e=2147483647&v=beta&t=XhhHXF4g_tAp-1iV6srIZsZ9AN067b8xqaQCXKlpzrs")
          ],
          lastName: "Mohammadzadehazarabadi",
          gender: "Male"),
      Profile(
          id: 1,
          about: "Profile About",
          locationDescription: "Bilkent G-132",
          posts: 2,
          interestes: await ModelServiceFactory.CATEGORY.getList() ?? [],
          reviewAverage: 5,
          verified: true,
          educationData: await ModelServiceFactory.UNIVERSITY
              .getItem(itemParameters: ItemParameters()),
          isPrivate: false,
          requestData: ProfileRequestData(
              connectionStatus: ConnectionStatus.Me,
              isBlocked: false,
              isBlockedBy: false,
              allowedActions: ProfileAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canHide: false,
                  canBlock: false,
                  canConnect: false,
                  canReport: false)),
          username: "Sardter",
          location: LatLng(28, 28),
          connections: 200,
          birth: DateTime.now(),
          firstName: "Sadra",
          email: "sadra701@gmail.com",
          links: [],
          images: [],
          lastName: "Mohammadzadehazarabadi",
          gender: "Male"),
      Profile(
          id: 1,
          about: "Profile About",
          locationDescription: "Bilkent G-132",
          posts: 2,
          interestes: await ModelServiceFactory.CATEGORY.getList() ?? [],
          reviewAverage: 5,
          verified: true,
          educationData: await ModelServiceFactory.UNIVERSITY
              .getItem(itemParameters: ItemParameters()),
          isPrivate: false,
          requestData: ProfileRequestData(
              connectionStatus: ConnectionStatus.Me,
              isBlocked: false,
              isBlockedBy: false,
              allowedActions: ProfileAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canHide: false,
                  canBlock: false,
                  canConnect: false,
                  canReport: false)),
          username: "Sardter",
          location: LatLng(28, 28),
          connections: 200,
          birth: DateTime.now(),
          firstName: "Sadra",
          email: "sadra701@gmail.com",
          links: [],
          images: [],
          lastName: "Mohammadzadehazarabadi",
          gender: "Male"),
      Profile(
          id: 1,
          about: "Profile About",
          locationDescription: "Bilkent G-132",
          posts: 2,
          interestes: await ModelServiceFactory.CATEGORY.getList() ?? [],
          reviewAverage: 5,
          verified: true,
          educationData: await ModelServiceFactory.UNIVERSITY
              .getItem(itemParameters: ItemParameters()),
          isPrivate: false,
          requestData: ProfileRequestData(
              connectionStatus: ConnectionStatus.Me,
              isBlocked: false,
              isBlockedBy: false,
              allowedActions: ProfileAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canHide: false,
                  canBlock: false,
                  canConnect: false,
                  canReport: false)),
          username: "Sardter",
          location: LatLng(28, 28),
          connections: 200,
          birth: DateTime.now(),
          firstName: "Sadra",
          email: "sadra701@gmail.com",
          links: [],
          images: [],
          lastName: "Mohammadzadehazarabadi",
          gender: "Male"),
      Profile(
          id: 1,
          about: "Profile About",
          locationDescription: "Bilkent G-132",
          posts: 2,
          reviewAverage: 5,
          interestes: await ModelServiceFactory.CATEGORY.getList() ?? [],
          verified: true,
          educationData: await ModelServiceFactory.UNIVERSITY
              .getItem(itemParameters: ItemParameters()),
          isPrivate: false,
          requestData: ProfileRequestData(
              connectionStatus: ConnectionStatus.Me,
              isBlocked: false,
              isBlockedBy: false,
              allowedActions: ProfileAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canHide: false,
                  canBlock: false,
                  canConnect: false,
                  canReport: false)),
          username: "Sardter",
          location: LatLng(28, 28),
          connections: 200,
          birth: DateTime.now(),
          firstName: "Sadra",
          email: "sadra701@gmail.com",
          links: [],
          images: [],
          lastName: "Mohammadzadehazarabadi",
          gender: "Male"),
      Profile(
          id: 1,
          about: "Profile About",
          locationDescription: "Bilkent G-132",
          posts: 2,
          reviewAverage: 5,
          interestes: await ModelServiceFactory.CATEGORY.getList() ?? [],
          verified: true,
          educationData: await ModelServiceFactory.UNIVERSITY
              .getItem(itemParameters: ItemParameters()),
          isPrivate: false,
          requestData: ProfileRequestData(
              connectionStatus: ConnectionStatus.Me,
              isBlocked: false,
              isBlockedBy: false,
              allowedActions: ProfileAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canHide: false,
                  canBlock: false,
                  canConnect: false,
                  canReport: false)),
          username: "Sardter",
          location: LatLng(28, 28),
          connections: 200,
          birth: DateTime.now(),
          firstName: "Sadra",
          email: "sadra701@gmail.com",
          links: [],
          images: [],
          lastName: "Mohammadzadehazarabadi",
          gender: "Male"),
      Profile(
          id: 1,
          about: "Profile About",
          locationDescription: "Bilkent G-132",
          posts: 2,
          reviewAverage: 5,
          interestes: await ModelServiceFactory.CATEGORY.getList() ?? [],
          verified: true,
          educationData: await ModelServiceFactory.UNIVERSITY
              .getItem(itemParameters: ItemParameters()),
          isPrivate: false,
          requestData: ProfileRequestData(
              connectionStatus: ConnectionStatus.Me,
              isBlocked: false,
              isBlockedBy: false,
              allowedActions: ProfileAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canHide: false,
                  canBlock: false,
                  canConnect: false,
                  canReport: false)),
          username: "Sardter",
          location: LatLng(28, 28),
          connections: 200,
          birth: DateTime.now(),
          firstName: "Sadra",
          email: "sadra701@gmail.com",
          links: [],
          images: [],
          lastName: "Mohammadzadehazarabadi",
          gender: "Male"),
      Profile(
          id: 1,
          about: "Profile About",
          locationDescription: "Bilkent G-132",
          posts: 2,
          reviewAverage: 5,
          verified: true,
          interestes: await ModelServiceFactory.CATEGORY.getList() ?? [],
          educationData: await ModelServiceFactory.UNIVERSITY
              .getItem(itemParameters: ItemParameters()),
          isPrivate: false,
          requestData: ProfileRequestData(
              connectionStatus: ConnectionStatus.Me,
              isBlocked: false,
              isBlockedBy: false,
              allowedActions: ProfileAllowedActions(
                  canUpdate: true,
                  canDelete: true,
                  canHide: false,
                  canBlock: false,
                  canConnect: false,
                  canReport: false)),
          username: "Sardter",
          location: LatLng(28, 28),
          connections: 200,
          birth: DateTime.now(),
          firstName: "Sadra",
          email: "sadra701@gmail.com",
          links: [],
          images: [],
          lastName: "Mohammadzadehazarabadi",
          gender: "Male"),
    ];
  }

  @override
  Future<int?> getListCount({QueryParameters? queryParameters}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return 6;
  }

  @override
  Future<Profile?> updateItem(
      {required Profile updatedItem,
      required ItemParameters itemParameters}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return updatedItem;
  }

  @override
  Future<Profile?> postItem({required Profile item}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return item;
  }

  @override
  Future<Profile?> getCurrentUser(BuildContext context,
      {bool launchLogin = true}) async {
    await Future.delayed(Duration(milliseconds: 750));

    await onGetCurrentUser(context, launchLogin);
    return currentProfile = await getItem(itemParameters: ItemParameters());
  }

  @override
  Future<bool?> blockUser({required ItemParameters itemParameters}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return true;
  }

  @override
  Future<ConnectionStatus?> connect(
      {required ItemParameters itemParameters}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return ConnectionStatus.NotConnected;
  }

  @override
  Future<ConnectionStatus?> disconnect(
      {required ItemParameters itemParameters}) async {
    await Future.delayed(Duration(milliseconds: 750));

    return ConnectionStatus.NotConnected;
  }

  @override
  Future<Profile?> updateCurrentUser({required Profile updatedItem}) async {
    return updatedItem;
  }
}
