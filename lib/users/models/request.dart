import 'package:ToGather/utilities/utilities.dart';

enum ConnectionStatus {
  NotConnected,
  RequestSent,
  RequestRecieved,
  Connected,
  Me,
}

Map<int, ConnectionStatus> IntToConnectionStatus = {
  -1: ConnectionStatus.Me,
  0: ConnectionStatus.NotConnected,
  1: ConnectionStatus.RequestSent,
  2: ConnectionStatus.RequestRecieved,
  3: ConnectionStatus.Connected
};

class ProfileAllowedActions extends AllowedActions {
  final bool canBlock;
  final bool canConnect;

  const ProfileAllowedActions(
      {required super.canUpdate,
      required super.canDelete,
      required super.canHide,
      required this.canBlock,
      required this.canConnect,
      required super.canReport});

  factory ProfileAllowedActions.fromJson(Map<String, dynamic> json) {
    return ProfileAllowedActions(
        canUpdate: json['can_update'] ?? false,
        canDelete: json['can_delete'] ?? false,
        canHide: json['can_hide'] ?? false,
        canBlock: json['can_block'] ?? false,
        canConnect: json['can_connect'] ?? false,
        canReport: json['can_report'] ?? false);
  }
}

class ProfileRequestData {
  final ConnectionStatus connectionStatus;
  final bool isBlocked;
  final bool isBlockedBy;
  final ProfileAllowedActions allowedActions;

  const ProfileRequestData(
      {required this.connectionStatus,
      required this.isBlocked,
      required this.isBlockedBy,
      required this.allowedActions});

  factory ProfileRequestData.fromJson(Map<String, dynamic> json) {
    return ProfileRequestData(
        connectionStatus: json['connection_status'] == null
            ? ConnectionStatus.NotConnected
            : (IntToConnectionStatus[json['connection_status']] ??
                ConnectionStatus.NotConnected),
        isBlocked: json['is_blocked'] ?? false,
        isBlockedBy: json['is_blocked_by'] ?? false,
        allowedActions:
            ProfileAllowedActions.fromJson(json['allowed_actions']));
  }
}
