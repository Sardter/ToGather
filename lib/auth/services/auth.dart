import 'package:flutter/material.dart';
import 'package:ToGather/auth/pages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:ToGather/utilities/utilities.dart';

import '../models/auth_cred.dart';

class AuthService {
  static final AuthService _authService = AuthService._internal();
  factory AuthService() {
    return _authService;
  }
  AuthService._internal();

  final _storage = StorageService();
  final _storageKey = 'auth_cred';

  AuthCredentials? _credentials;

  bool get isLogedIn => _credentials != null;

  Future<AuthCredentials?> get credentials async {
    if (this._credentials != null) {
      return this._credentials;
    }
    final stored = await _storage.getItem(_storageKey);
    if (stored == null) return null;
    try {
      _credentials = AuthCredentials.fromJson(stored);
    } catch (e) {
      print(e);
    }
    return _credentials;
  }

  Future<void> setCredentials(AuthCredentials? credentials) async {
    print("setting credentials: ${credentials?.toJson()}");
    if (credentials == null) {
      clear();
      return;
    }

    await _storage.setItem(_storageKey, credentials.toJson());
    _credentials = credentials;
    print("seted credentials: ${_credentials?.toJson()}");
  }

  Future<String?> get access async => (await credentials)?.accessToken;

  Future<String?> get refresh async => (await credentials)?.refreshToken;

  Future<void> launchLoginPage(BuildContext context) async {
    await launchPage(context, LoginPage());
  }

  Future<bool?> login({required AuthFields fields}) async {
    final result = await APIService().actionAndGetResponseItems(
        url: URLManager.login,
        body: fields.toJson(),
        action: APIAction.Post /* ,
        headers: Hidden_Form_Headers */
        );

    print("login result: $result");
    if (result == null || result['access_token'] == null) return false;

    try {
      setCredentials(AuthCredentials.fromJson(result));
      return true;
    } catch (e) {
      print("login error: $e");
      return null;
    }
  }

  Future<bool?> register({required AuthFields fields}) async {
    final result = await APIService().actionAndGetResponseItems(
        url: URLManager.register,
        body: fields.toJson(),
        action: APIAction.Post);

    if (result == null) return false;

    return result['access_token'] != null;
  }

  Future<bool?> resetPassword({required AuthFields fields}) async {
    final result = await APIService().actionAndGetResponseItems(
        url: URLManager.passwordReset + fields.email!,
        body: fields.toJson(),
        action: APIAction.Post);

    return result != null;
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    print(googleAuth);
    // Create a new credential
    /* final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    ); */

    //print(credential);

    // Once signed in, return the UserCredential
    //return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signInWithFacebook() async {
    // Trigger the sign-in flow
    //final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    /* final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token); */

    // Once signed in, return the UserCredential

    //return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  void clear() async => _storage.deleteItem(_storageKey);
}
