import 'dart:convert';

import 'package:ToGather/utilities/utilities.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ToGather/home/base.dart';
import 'package:ToGather/notifications/services/notifications_service.dart';
import 'package:intl/date_symbol_data_local.dart';


@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await LanguageService().initializeData();
  await initializeFirebase();
  print(message);
  PushNotificationsService().createNotification(message);
}

@pragma('vm:entry-point')
Future<void> notificationActionHandler(NotificationResponse response) async {
  final payload =
      response.payload == null ? null : jsonDecode(response.payload!);
  if (payload == null || payload['time'] == null) return;
  print(payload);
  PushNotificationsService().onNotificationTap(DateTime.parse(payload['time']));
}

@pragma('vm:entry-point')
Future<void> locationHandler() async {
  LocationService().initStream((position) {
    print(position);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) initializeFirebase();
  await PushNotificationsService().initializeNotifications(
      onBackground: notificationActionHandler,
      onAction: notificationActionHandler);
  await LanguageService().initializeData();
  if (!kIsWeb)
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  //locationHandler();
  initializeDateFormatting("tr_TR").then((_) => runApp(Sylvest()));
}

class Sylvest extends StatefulWidget {
  const Sylvest({
    Key? key,
  }) : super(key: key);

  @override
  State<Sylvest> createState() => _SylvestState();
}

class _SylvestState extends State<Sylvest> {
  final Color backgroundColor = Colors.white,
      materialColor = ThemeService.eventColor,
      secondaryColor = Colors.black;

  static const String _title = 'sylvest';

  Future<void> _initialize() async {
    await PushNotificationsService().initialise();
    /* LocationService().initStream((postion) {
      print(postion);
    }); */
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initialize();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: _title,
            initialRoute: '/',
            theme: ThemeService.lightTheme,
            routes: {
              '/': (context) => BasePage(),
            },
            //home: SylvestMain(),
          );
  }
}
