import 'package:ToGather/utilities/utilities.dart';

class EventAllowedActions extends AllowedActions {
  final bool canAttend;
  final bool canPost;
  final bool canForm;
  final bool canRate;
  const EventAllowedActions(
      {required super.canUpdate,
      required super.canDelete,
      required this.canAttend,
      required this.canPost,
      required this.canRate,
      required this.canForm,
      required super.canHide,
      required super.canReport});

  factory EventAllowedActions.fromJson(Map<String, dynamic> json) {
    print("event allowed actions: $json");
    return EventAllowedActions(
        canUpdate: json['can_update'] ?? false,
        canDelete: json['can_delete'] ?? false,
        canAttend: json['can_attend'] ?? false,
        canPost: json['can_post'] ?? false,
        canForm: json['can_from'] ?? false,
        canRate: json['can_rate'] ?? false,
        canHide: json['can_hide'] ?? false,
        canReport: json['can_report'] ?? false);
  }
}

class EventRequestData {
  final bool isAttending;
  final bool isHosting;
  final double? userRate;
  final EventAllowedActions allowedActions;

  const EventRequestData(
      {required this.isAttending,
      required this.allowedActions,
      required this.userRate,
      required this.isHosting});

  bool get isRated => userRate != null && userRate != 0;

  factory EventRequestData.fromJson(Map<String, dynamic> json) {
    return EventRequestData(
        isAttending: json['is_attending'] ?? false,
        userRate: json['rate'],
        allowedActions: EventAllowedActions.fromJson(json['allowed_actions']),
        isHosting: json['is_hosting'] ?? false);
  }
}
