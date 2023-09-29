import 'package:flutter/material.dart';
import 'package:ToGather/notifications/models/models.dart';

import 'types.dart';



abstract class PushNotificationType {
  Future<void> route(int itemId, BuildContext context);

  IconData? get icon;

  bool get fromUser;

  String message(PushNotificationBody body);

  factory PushNotificationType.fromType(String type) {
    switch (type) {
      case "like":
        return LikeNotification();
      case "comment":
        return CommentNotification();
      case "comment_comment":
        return CommentNotification();
      case "comment_like":
        return LikeCommentNotification();
      case "request":
        return ConnectionRequestNotification();
      case "accept":
        return ConnectionAcceptNotification();
      case "join":
        return JoinNotification();
      case "attend":
        return AttendNotification();
      case "event":
        return NewEventNotification();
      default:
        throw UnimplementedError("Type not implemented: $type");
    }
  }
}