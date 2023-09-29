import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ToGather/auth/services/auth.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:ToGather/utilities/utilities.dart';

import '../../auth/models/auth_cred.dart';

enum APIAction { Get, Post, Delete, Put }

final Hidden_Form_Headers = {
  HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
};

class APIService {
  static final APIService _api = APIService._internal();
  factory APIService() {
    return _api;
  }
  APIService._internal();

  static List<int> safeStatus = const [200, 201];
  final _auth = AuthService();

  Future<http.Response> _get({required String url, String? token}) async {
    return await http.get(Uri.parse(url), headers: {
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer ${token}',
    });
  }

  Future<http.Response> _post(
      {required String url,
      String? token,
      required Map? body,
      required Map<String, String>? headers}) async {
    return await http.post(Uri.parse(url),
        headers: headers ??
            {
              if (token != null)
                HttpHeaders.authorizationHeader: 'Bearer ${token}',
              HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
            },
        body: jsonEncode(body));
  }

  Future<http.Response> _put(
      {required String url, String? token, required Map? body}) async {
    return await http.put(Uri.parse(url),
        headers: {
          if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));
  }

  Future<http.Response> _delete({required String url, String? token}) async {
    return await http.delete(Uri.parse(url), headers: {
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    });
  }

  static Future<dynamic> _decodeResponse(
      http.Response response, BuildContext? context,
      {bool showErrors = true}) async {
    try {
      final decoded = json.decode(utf8.decode(response.bodyBytes));
      if (!safeStatus.contains(response.statusCode) &&
          showErrors &&
          context != null) {
        for (List errors in decoded.values) {
          for (var error in errors) {
            await showSylvestSnackbar(
                context: context,
                message: error,
                type: DisplayMessageType.Danger);
          }
        }
      }
      return decoded;
    } catch (e) {
      if (showErrors && context != null)
        await showSylvestSnackbar(
            context: context,
            message: LanguageService().data.errors.somethingWentWrong,
            type: DisplayMessageType.Danger);
      return null;
    }
  }

  Future<bool> _refreshToken(BuildContext? context) async {
    String? token = await _auth.refresh;

    if (token == null) return false;

    final response = await _post(
      url: URLManager.tokenRefresh,
      body: {'token': token},
      headers: null,
    );
    final items = await _decodeResponse(response, context);
    if (response.statusCode == 401) return false;

    try {
      _auth.setCredentials(AuthCredentials.fromJson(items));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<http.Response> _actionAndResponse(
      {required String url,
      required String? accessToken,
      required Map? body,
      required Map<String, String>? headers,
      required APIAction action}) async {
    switch (action) {
      case APIAction.Get:
        return _get(url: url, token: accessToken);
      case APIAction.Post:
        return _post(
            url: url, body: body, token: accessToken, headers: headers);
      case APIAction.Delete:
        return _delete(url: url, token: accessToken);
      case APIAction.Put:
        return _put(url: url, body: body, token: accessToken);
    }
  }

  Future<dynamic> actionAndGetResponseItems(
      {BuildContext? context,
      required String url,
      Map? body,
      Map<String, String>? headers,
      bool showDecodeErrors = true,
      APIAction action = APIAction.Get}) async {
    final authCred = await _auth.credentials;
    http.Response? response;

    print("auth cred: ${authCred?.toJson()}");

    if (authCred == null) {
      response = await _actionAndResponse(
          url: url,
          accessToken: null,
          body: body,
          action: action,
          headers: headers);
    } else {
      response = await _actionAndResponse(
          url: url,
          accessToken: (await _auth.credentials)?.accessToken,
          body: body,
          headers: headers,
          action: action);
      if (!safeStatus.contains(response.statusCode)) {
        if (!await _refreshToken(context)) {
          response = await _actionAndResponse(
              url: url,
              accessToken: null,
              body: body,
              action: action,
              headers: headers);
        } else {
          response = await _actionAndResponse(
              url: url,
              headers: headers,
              accessToken: (await _auth.credentials)?.accessToken,
              body: body,
              action: action);
        }

        if (!safeStatus.contains(response.statusCode)) {
          if (context != null)
            await showSylvestSnackbar(
                context: context,
                message: LanguageService().data.alerts.loggedOut);
          _auth.clear();
        }
      }
    }

    print("body: $body");

    print("url: $url");
    print("response (${response.statusCode}): ${response.body}");

    return await _decodeResponse(response, context,
        showErrors: showDecodeErrors);
  }
}
