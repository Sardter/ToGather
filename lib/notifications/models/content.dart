import 'dart:convert';

import 'package:ToGather/utilities/utilities.dart';

import 'models.dart';

class PushNotificationContent {
  final ImageData? largeIcon;
  final int id;
  final PushNotificationBody body;

  const PushNotificationContent(
      {required this.largeIcon, required this.id, required this.body});

  factory PushNotificationContent.fromJson(Map json) {
    return PushNotificationContent(
        largeIcon: json['image'],
        id: int.parse(json['item_id']),
        body: PushNotificationBody.fromJson(jsonDecode(json['body'])));
  }
}