import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/notifications/types/type.dart';
import 'package:ToGather/notifications/types/types.dart';
import 'package:ToGather/notifications/requests_page.dart';
import 'package:ToGather/utilities/utilities.dart';

import 'models/models.dart';

class NotificationsPage extends StatefulWidget {
  final void Function(int value) setPage;
  final DateTime? launchTime;

  const NotificationsPage({required this.setPage, this.launchTime});

  @override
  State<NotificationsPage> createState() => NotificationsPageState();
}

class NotificationsPageState extends State<NotificationsPage> {
  final _manager = ModelServiceFactory.NOTIFICATION;
  final _refreshController = RefreshablePageController<NotificationWidget>();

  int _requestNum = 0;

  void _onNewNotification(Map data) {
    final notification = PushNotificationData.fromJson(data);
    if (notification.type is ConnectionRequestNotification) {
      _requestNum++;
    }
    _refreshController.items.value
        .insert(0, NotificationWidget(data: notification));
  }

  Future<List<Widget>?> _onRefresh() async {
    _manager.reset();

    final _notifications = await _manager.getList() ?? [];
    _requestNum =
        await ModelServiceFactory.RECIVED_CONNECTIONS.getListCount() ?? 0;

    await ModelServiceFactory.NOTIFICATION.resetUnreadNotifcations();

    if (widget.launchTime != null) {
      _launchNotification(widget.launchTime!);
    }

    if (mounted) setState(() {});

    return _notifications.map((e) => NotificationWidget(data: e)).toList();
  }

  Future<List<Widget>?> _onLoad() async {
    if (!_manager.next()) return null;

    final newNotifications = await _manager.getList() ?? [];

    return newNotifications.map((e) => NotificationWidget(data: e)).toList();
  }

  Widget _emptyNotifications() {
    final height = MediaQuery.of(context).size.height / 2;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: height - 50 - (20 * (4 / 3)) - 40),
        Icon(
          LineIcons.heart,
          color: ThemeService.disabledColor,
          size: 50,
        ),
        Text(
          LanguageService().data.hints.emptyNotifications,
          style: TextStyle(color: ThemeService.disabledColor, fontSize: 20),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  void _launchNotification(DateTime dateTime) {
    try {
      final launched = _refreshController.items.value
          .firstWhere((element) => element.data.time == dateTime)
          .data;
      if (launched.itemId != null)
        launched.type.route(launched.itemId!, context);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RemoteMessage>(
      stream: FirebaseMessaging.onMessage,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          /* APIService.displayError(
              LanguageService().data.errors.notificationSetup, context); */
        } else {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.active) {
            print("here ---->");
            final message = snapshot.data as RemoteMessage;
            print(message);
            _onNewNotification(message.data);
          }
        }
        return RefreshablePage(
          onLoad: _onLoad,
          onRefresh: _onRefresh,
          pageController: _refreshController,
          headerBuilder: _requestNum == 0
              ? null
              : (context) => RequestsWidget(requestNum: _requestNum),
          emptyBuilder: (context) => _emptyNotifications(),
        );
      },
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final PushNotificationData data;

  const NotificationWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationFromUserWidget(
      imageUrl: data.content.largeIcon,
      title: data.type.message(data.content.body),
      type: data.type,
      time: data.time,
      itemId: data.itemId!,
    );
  }
}

class NotificationFromUserWidget extends StatelessWidget {
  final String title;
  final ImageData? imageUrl;
  final PushNotificationType type;
  final DateTime time;
  final int itemId;
  const NotificationFromUserWidget(
      {required this.imageUrl,
      required this.title,
      required this.type,
      required this.time,
      required this.itemId});

  factory NotificationFromUserWidget.fromMap(Map data) {
    final content = jsonDecode(data['data']['content']);
    return NotificationFromUserWidget(
        imageUrl: content['largeIcon'],
        title: content['body'],
        time: DateTime.parse(data['time']),
        itemId: data['item_id'],
        type: data['data']['type']);
  }

  final modalPages = const [RequestsPage];

  String? _defaultImage() {
    switch (type.runtimeType) {
      case NewEventNotification:
        return /*DefaultImageManager.eventBanner*/ null;
      default:
        return /*DefaultImageManager.user*/ null;
    }
  }

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () async {
        await type.route(itemId, context);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: ThemeService.menuBackground,
            borderRadius: BorderRadius.circular(30)),
        child: IntrinsicHeight(
          child: Row(
            children: [
              SylvestImageProvider(
                  image: imageUrl, defaultImage: _defaultImage()),
              const SizedBox(width: 15),
              Icon(type.icon, color: ThemeService.eventColor),
              VerticalDivider(
                width: 15,
                color: ThemeService.secondaryText,
                thickness: 1,
                indent: 8,
                endIndent: 8,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(title,
                            style: TextStyle(
                                fontSize: 14,
                                color: ThemeService.primaryText))),
                    Text(DateFormat('d MMM y | kk:mm').format(time),
                        style: TextStyle(
                            fontSize: 8,
                            color: ThemeService.secondaryText,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
