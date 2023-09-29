import 'package:flutter/material.dart';
import 'package:ToGather/auth/services/auth.dart';
import 'package:ToGather/users/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';

abstract class ProfileModelService<T extends Profile> extends ModelService<T> {
  @protected
  Profile? currentProfile;

  @protected
  final authService = AuthService();

  Future<Profile?> getCurrentUser(BuildContext context, {bool launchLogin = true});

  Future<Profile?> updateCurrentUser(
      {required Profile updatedItem});

  Future<bool?> blockUser({required ItemParameters itemParameters});

  Future<ConnectionStatus?> connect({required ItemParameters itemParameters});

  Future<ConnectionStatus?> disconnect({required ItemParameters itemParameters});

  @protected
  Future<bool> onGetCurrentUser(BuildContext context, bool launchLogin) async {
    if (!authService.isLogedIn && launchLogin) authService.launchLoginPage(context);

    return authService.isLogedIn;
  }
}
