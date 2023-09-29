import 'package:ToGather/utilities/utilities.dart';

class ClubAllowedActions extends AllowedActions {
  final bool canJoin;
  final bool canEdit;
  final bool canModerate;
  final bool canPost;
  final bool canEvent;

  const ClubAllowedActions(
      {required super.canUpdate,
      required super.canDelete,
      required super.canHide,
      required super.canReport,
      required this.canJoin,
      required this.canEdit,
      required this.canModerate,
      required this.canPost,
      required this.canEvent});

  factory ClubAllowedActions.formJson(Map<String, dynamic> json) {
    return ClubAllowedActions(
        canUpdate: json['can_update'] ?? false,
        canDelete: json['can_delete'] ?? false,
        canHide: json['can_hide'] ?? false,
        canReport: json['can_report'] ?? false,
        canJoin: json['can_join'] ?? false,
        canEdit: json['can_edit'] ?? false,
        canModerate: json['can_moderate'] ?? false,
        canPost: json['can_post'] ?? false,
        canEvent: json['can_event'] ?? false);
  }
}

class ClubRequestData {
  final ClubAllowedActions allowedActions;
  final bool isJoined;

  const ClubRequestData({required this.allowedActions, required this.isJoined});

  factory ClubRequestData.fromJson(Map<String, dynamic> json) {
    return ClubRequestData(
        allowedActions: ClubAllowedActions.formJson(json['allowed_actions']),
        isJoined: json['is_joined'] ?? false);
  }
}
