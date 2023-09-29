import 'package:ToGather/utilities/utilities.dart';

class PlaceAllowedActions extends AllowedActions {
  final bool canPost;

  const PlaceAllowedActions(
      {required super.canUpdate,
      required super.canDelete,
      required super.canHide,
      required super.canReport,
      required this.canPost});

  factory PlaceAllowedActions.formJson(Map<String, dynamic> json) {
    return PlaceAllowedActions(
        canUpdate: json['can_update'] ?? false, 
        canDelete: json['can_delete'] ?? false, 
        canHide: json['can_hide'] ?? false, 
        canReport: json['can_report'] ?? false, 
        canPost: json['can_post'] ?? false); 
  }
}

class PlaceRequestData {
  final PlaceAllowedActions allowedActions;

  const PlaceRequestData({required this.allowedActions});

  factory PlaceRequestData.fromJson(Map<String, dynamic> json) {
    return PlaceRequestData(
        allowedActions: PlaceAllowedActions.formJson(json['allowed_actions']));
  }
}
