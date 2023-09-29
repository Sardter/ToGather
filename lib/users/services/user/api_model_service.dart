import 'package:flutter/src/widgets/framework.dart';
import 'package:ToGather/auth/services/auth.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class ProfileAPIModelService extends APIModelService<Profile>
    implements ProfileModelService {
  @protected
  Profile? currentProfile;
  @override
  String get url => URLManager.users;

  String get meUrl => URLManager.myProfile;

  Future<Map<String, dynamic>?> _getAPICurrentUser() async {
    return await api.actionAndGetResponseItems(url: meUrl);
  }

  Future<Map<String, dynamic>?> _updateCurrentUser(
      {required Map<String, dynamic> updatedItem}) async {
    return await api.actionAndGetResponseItems(
        url: meUrl, action: APIAction.Put, body: updatedItem);
  }

  Future<bool?> _blockUser({required ItemParameters itemParameters}) async {
    return await api.actionAndGetResponseItems(
        url: URLManager.userBlock(itemParameters.id!), action: APIAction.Post);
  }

  Future<int?> _connect({required ItemParameters itemParameters}) async {
    return await api.actionAndGetResponseItems(
        url: URLManager.userConnect(itemParameters.id!),
        action: APIAction.Post);
  }

  Future<int?> _disconnect({required ItemParameters itemParameters}) async {
    return await api.actionAndGetResponseItems(
        url: URLManager.userDisconnect(itemParameters.id!),
        action: APIAction.Post);
  }

  @override
  Future<Profile?> getCurrentUser(BuildContext context,
      {bool launchLogin = true}) async {
    if (currentProfile != null) return currentProfile;
    if (!await onGetCurrentUser(context, launchLogin)) return null;
    final item = await _getAPICurrentUser();

    if (item == null) return null;

    try {
      return currentProfile = Profile.fromJson(item);
    } catch (e) {
      print(e);
      return null;
    }
  }

  final authService = AuthService();

  @override
  Future<bool> onGetCurrentUser(BuildContext context, bool launchLogin) async {
    if (!authService.isLogedIn && launchLogin)
      authService.launchLoginPage(context);

    return authService.isLogedIn;
  }

  @override
  Future<bool?> blockUser({required ItemParameters itemParameters}) {
    return _blockUser(itemParameters: itemParameters);
  }

  @override
  String get modelType => "User";

  @override
  Future<ConnectionStatus?> connect(
      {required ItemParameters itemParameters}) async {
    return IntToConnectionStatus[
        await _connect(itemParameters: itemParameters) ?? -9];
  }

  @override
  Future<ConnectionStatus?> disconnect(
      {required ItemParameters itemParameters}) async {
    return IntToConnectionStatus[
        await _disconnect(itemParameters: itemParameters) ?? -9];
  }

  @override
  Future<Profile?> updateCurrentUser({required Profile updatedItem}) async {
    final item = await _updateCurrentUser(updatedItem: updatedItem.toJson());

    if (item?['updated'] == null) return null;

    await onModelWithMedia(item!, updatedItem);

    try {
      return currentProfile = Profile.fromJson(item['updated']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
