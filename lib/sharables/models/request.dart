import 'package:ToGather/utilities/utilities.dart';

class SharableAllowedActions extends AllowedActions {
  final bool canComment;
  final bool canRate;
  const SharableAllowedActions(
      {required super.canUpdate,
      required super.canDelete,
      required this.canComment,
      required this.canRate,
      required super.canHide,
      required super.canReport});

  factory SharableAllowedActions.fromJson(Map<String, dynamic> json) {
    return SharableAllowedActions(
        canUpdate: json['can_update'] ?? false,
        canDelete: json['can_delete'] ?? false,
        canComment: json['can_comment'] ?? false,
        canRate: json['can_rate'] ?? false,
        canHide: json['can_hide'] ?? false,
        canReport: json['can_report'] ?? false);
  }
}

class SharableRequestData {
  final SharableAllowedActions allowedActions;
  final double? rateOfUser;
  final bool sharedByClubAdmin;
  final bool isAuthor;

  const SharableRequestData(
      {required this.allowedActions,
      required this.rateOfUser,
      required this.sharedByClubAdmin,
      required this.isAuthor});

  factory SharableRequestData.fromJson(Map<String, dynamic> json) {
    return SharableRequestData(
        allowedActions:
            SharableAllowedActions.fromJson(json['allowed_actions']),
        rateOfUser: json['user_rate'],
        sharedByClubAdmin: json['shareb_by_admin'] ?? false,
        isAuthor: json['is_author'] ?? false);
  }
}
