import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:meta/meta.dart';

class ProfileRecievedConnectionsAPIModelService extends ProfileAPIModelService {
  @protected
  Profile? currentProfile;
  String get url => URLManager.connectionsReceived;
}

class ProfileSentConnectionsAPIModelService extends ProfileAPIModelService {
  @protected
  Profile? currentProfile;
  String get url => URLManager.connectionsSent;
}