import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/events/pages/event_page.dart';
import 'package:ToGather/organizations/clubs/pages/detail_page.dart';
import 'package:ToGather/modals/modals.dart';
import 'package:ToGather/notifications/models/models.dart';
import 'package:ToGather/notifications/requests_page.dart';
import 'package:ToGather/sharables/pages/detail_page.dart';
import 'package:ToGather/users/pages/user_page.dart';
import 'package:ToGather/utilities/utilities.dart';

import 'type.dart';

class LikeNotification implements PushNotificationType {
  @override
  IconData? get icon => LineIcons.heart;

  String message(PushNotificationBody body) {
    return "${body.user} ${LanguageService().data.notifications.like}";
  }

  @override
  Future<void> route(int itemId, BuildContext context) async {
    await launchPage(context, PostDetailPage(id: itemId));
  }

  @override
  bool get fromUser => true;
}

class CommentNotification implements PushNotificationType {
  @override
  IconData? get icon => LineIcons.comment;

  String message(PushNotificationBody body) {
    return "${body.user} ${LanguageService().data.notifications.comment}";
  }

  @override
  Future<void> route(int itemId, BuildContext context) async {
    await launchPage(context, PostDetailPage(id: itemId));
  }

  @override
  bool get fromUser => true;
}

class LikeCommentNotification implements PushNotificationType {
  @override
  IconData? get icon => LineIcons.heart;

  String message(PushNotificationBody body) {
    return "${body.user} ${LanguageService().data.notifications.commentLike}";
  }

  @override
  Future<void> route(int itemId, BuildContext context) async {
    await launchPage(context, PostDetailPage(id: itemId));
  }

  @override
  bool get fromUser => true;
}

class ConnectionRequestNotification implements PushNotificationType {
  @override
  IconData? get icon => LineIcons.userPlus;

  String message(PushNotificationBody body) {
    return "${body.user} ${LanguageService().data.notifications.request}";
  }

  @override
  Future<void> route(int itemId, BuildContext context) async {
    await launchModal(context, RequestsPage());
  }

  @override
  bool get fromUser => true;
}

class ConnectionAcceptNotification implements PushNotificationType {
  @override
  IconData? get icon => LineIcons.userPlus;

  String message(PushNotificationBody body) {
    return "${body.user} ${LanguageService().data.notifications.accept}";
  }

  @override
  Future<void> route(int itemId, BuildContext context) async {
    await launchPage(context, UserPage(id: itemId, setPage: (a) {}));
  }

  @override
  bool get fromUser => true;
}

class JoinNotification implements PushNotificationType {
  @override
  IconData? get icon => LineIcons.userPlus;

  String message(PushNotificationBody body) {
    return "${body.user} ${LanguageService().data.notifications.join}";
  }

  @override
  Future<void> route(int itemId, BuildContext context) async {
    await launchPage(context, ClubPage(id: itemId));
  }

  @override
  bool get fromUser => true;
}


class AttendNotification implements PushNotificationType {
  @override
  IconData? get icon => LineIcons.calendar;

  String message(PushNotificationBody body) {
    return "${body.user} ${LanguageService().data.notifications.attend}";
  }

  @override
  Future<void> route(int itemId, BuildContext context) async {
    await launchPage(context, EventPage(id: itemId));
  }

  @override
  bool get fromUser => true;
}


class NewEventNotification implements PushNotificationType {
  @override
  IconData? get icon => LineIcons.calendar;

  String message(PushNotificationBody body) {
    return "${body.event} ${body.startDate} ${LanguageService().data.notifications.event}";
  }

  @override
  Future<void> route(int itemId, BuildContext context) async {
    await launchPage(context, EventPage(id: itemId));
  }

  @override
  bool get fromUser => true;
}
