import 'package:ToGather/notifications/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';

abstract class NotificationModelService extends ModelService<PushNotificationData> {
  Future<int?> getUnreadNotificationCount();

  Future<bool?> resetUnreadNotifcations();
}