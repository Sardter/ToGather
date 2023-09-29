import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'api.dart';
import 'api_url_service.dart';
import '../../auth/services/auth.dart';

class DeviceService {
  final _auth = AuthService();
  final _api = APIService();

  Future<Map?> registerDevice(BuildContext context) async {
    if (kIsWeb) return null;
    final url = URLManager.device;
    final loginCred = await _auth.credentials;

    if (loginCred == null) return null;

    final deviceInfo = DeviceInfoPlugin();
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    final regToken = await messaging.getToken();

    Map body = {};

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;

        body = {
          'device_id': androidInfo.id,
          'type': 'android',
          'name': androidInfo.model,
          'active': true,
          'registeration_token': regToken
        };
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        body = {
          'device_id': iosInfo.identifierForVendor,
          'type': 'ios',
          'name': iosInfo.name,
          'active': true,
          'registeration_token': regToken
        };
      } else {
        final webInfo = await deviceInfo.webBrowserInfo;
        body = {
          'device_id': webInfo.appCodeName,
          'type': 'web',
          'name': webInfo.appName,
          'active': true,
          'registeration_token': regToken
        };
      }
      print(body);
      final items = await _api.actionAndGetResponseItems(
          context: context, url: url, body: body, action: APIAction.Post);
      print(items);
      return items;
    } catch (e) {
      print(e);
      return null;
    }
  }
}