import 'package:ToGather/notifications/types/type.dart';
import 'package:ToGather/utilities/utilities.dart';

import 'content.dart';

class PushNotificationData extends Model {
  final PushNotificationType type;
  final PushNotificationContent content;
  final int? itemId;
  final DateTime time;

  const PushNotificationData(
      {required this.type,
      required this.content,
      required this.time,
      required this.itemId,
      required super.id});

  factory PushNotificationData.fromJson(Map data) {
    return PushNotificationData(
        id: data['id'],
        type: PushNotificationType.fromType(data['type']),
        content: PushNotificationContent.fromJson(data),
        time: DateTime.parse(data['time']),
        itemId: int.tryParse(data['item_id']));
  }

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
