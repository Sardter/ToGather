import 'dart:async';
import 'dart:convert';

import 'package:ToGather/auth/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ToGather/organizations/clubs/pages/detail_page.dart';
import 'package:ToGather/notifications/notifications_page.dart';
import 'package:ToGather/sharables/pages/detail_page.dart';
import 'package:ToGather/notifications/requests_page.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

import '../models/models.dart';

class PushNotificationEvent {
  final bool newSocialNotification;
  final int lastSocialId;

  const PushNotificationEvent(
      {this.newSocialNotification = false, this.lastSocialId = -1});
}

class PushNotificationsService {
  final _notifications = FlutterLocalNotificationsPlugin();
  final _stream = FirebaseMessaging.onMessage;
  final _newNotifications = ValueNotifier<int>(0);

  int _socialLastId = -1;

  int get socialLastId => _socialLastId;

  ValueNotifier<int> get notifier => _newNotifications;

  BuildContext? context;
  void Function(int page)? setPage;

  final _eventController = StreamController<PushNotificationEvent>();
  late final Stream<PushNotificationEvent> eventStream =
      _eventController.stream.asBroadcastStream();

  static final PushNotificationsService _service =
      PushNotificationsService._internal();

  factory PushNotificationsService() {
    return _service;
  }

  PushNotificationsService._internal();

  final foregroundNotifications = const [];

  Future initialise() async {
    if (kIsWeb) return;
    await FirebaseMessaging.instance.getInitialMessage();
  }

  Future<void> getUnread() async {
    if (AuthService().isLogedIn)
      _newNotifications.value =
          await ModelServiceFactory.NOTIFICATION.getUnreadNotificationCount() ??
              0;
  }

  Future<void> resetUnread() async {
    _newNotifications.value = 0;
  }

  void _onSocialNotification(PushNotificationData data) {
    //if (data.content.id == _socialLastId) return;
    _socialLastId = data.time.millisecondsSinceEpoch;
    if (foregroundNotifications.contains(data.type))
      createNotificationFromData(data);
    _eventController.add(PushNotificationEvent(
        newSocialNotification: true, lastSocialId: socialLastId));
  }

  void notificationStream() {
    _stream.listen((message) {
      print(message);
      final data = PushNotificationData.fromJson(message.data);
      _onSocialNotification(data);
      getUnread();
    });
  }

  Future<bool?> initializeNotifications(
      {void Function(NotificationResponse)? onAction,
      void Function(NotificationResponse)? onBackground}) async {
    return await _notifications.initialize(
        InitializationSettings(
            android: AndroidInitializationSettings('ic_stat_name'),
            iOS: DarwinInitializationSettings(notificationCategories: [
              DarwinNotificationCategory(
                "social",
                actions: [
                  DarwinNotificationAction.plain("foreground", "foreground",
                      options: {DarwinNotificationActionOption.foreground})
                ],
                options: <DarwinNotificationCategoryOption>{
                  DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
                },
              )
            ])),
        onDidReceiveBackgroundNotificationResponse: onBackground,
        onDidReceiveNotificationResponse: onAction);
  }

  Future<void> onNotificationTap(DateTime? time) async {
    if (context != null && setPage != null)
      await launchPage(
          context!, NotificationsPage(setPage: setPage!, launchTime: time));
  }

  static Widget routeFromNotification(
      int itemId, String notificationType, BuildContext context) {
    switch (notificationType) {
      case 'like':
        return PostDetailPage(id: itemId);
      case 'like_comment':
        return PostDetailPage(id: itemId);
      case 'attend':
        return PostDetailPage(id: itemId);
      case 'contribute':
        return PostDetailPage(id: itemId);
      case 'comment':
        return PostDetailPage(id: itemId);
      case 'follow':
        return UserPage(
          id: itemId,
          setPage: (a) {},
        );
      case 'follow_request':
        return RequestsPage();
      case 'join':
        return ClubPage(id: itemId);
      case 'token':
        return UserPage(id: itemId, setPage: (a) {});
      default:
        throw Exception("Type not expected: $notificationType");
    }
  }

  Future<void> createNotificationFromData(PushNotificationData data) async {
    final image = await FileService.getFileContent(data.content.largeIcon?.url);

    return await _notifications.show(
        data.content.id,
        LanguageService().data.appTitle,
        data.type.message(data.content.body),
        NotificationDetails(
            android: AndroidNotificationDetails(
              "social",
              "social",
              ledOffMs: 500,
              ledOnMs: 500,
              ledColor: ThemeService.eventColor,
              priority: Priority.max,
              groupAlertBehavior: GroupAlertBehavior.all,
              largeIcon: image == null ? null : ByteArrayAndroidBitmap(image),
            ),
            iOS: DarwinNotificationDetails(attachments: [])),
        payload:
            jsonEncode({'time': data.time.toString(), 'item_id': data.itemId}));
  }

  Future<void> createNotification(RemoteMessage message) async {
    final data = PushNotificationData.fromJson(message.data);

    await createNotificationFromData(data);
  }
}
