import 'package:ToGather/notifications/models/models.dart';
import 'package:ToGather/notifications/services/notifcation_model_service.dart';
import 'package:ToGather/utilities/utilities.dart';

class NotitificationAPIModelService
    extends APIModelService<PushNotificationData>
    implements NotificationModelService {
  @override
  String get url => URLManager.notifications;

  Future<int?> _getUnreadNotificationCount() async {
    try {
      return await api.actionAndGetResponseItems(
        url: URLManager.notificationsCount);
    } catch (e) {
      return null;
    }
  }

  Future<int?> _resetUnreadNotifcations() async {
    return await api.actionAndGetResponseItems(
        url: URLManager.notificationsCount, action: APIAction.Post);
  }

  @override
  Future<int?> getUnreadNotificationCount() async {
    return _getUnreadNotificationCount();
  }

  @override
  String get modelType => "Notification";

  @override
  Future<bool?> resetUnreadNotifcations() async {
    return await _resetUnreadNotifcations() == 0;
  }
}
