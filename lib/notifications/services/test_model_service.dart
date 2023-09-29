import 'package:ToGather/notifications/models/models.dart';
import 'package:ToGather/notifications/services/notifcation_model_service.dart';
import 'package:ToGather/notifications/types/type.dart';
import 'package:ToGather/utilities/utilities.dart';

class NotificationTestModelService extends NotificationModelService {
  @override
  Future<bool> deleteItem({required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return true;
  }

  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return true;
  }

  @override
  Future<bool?> hideItem({required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return true;
  }

  @override
  Future<PushNotificationData?> getItem(
      {required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return PushNotificationData(
        type: PushNotificationType.fromType('like'),
        content: PushNotificationContent(
            largeIcon: null,
            id: 1,
            body: PushNotificationBody(
                user: 'sardter', event: null, startDate: null, club: null)),
        time: DateTime.now(),
        itemId: 1,
        id: 1);
  }

  @override
  Future<List<PushNotificationData>?> getList(
      {QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return [
      PushNotificationData(
          type: PushNotificationType.fromType('like'),
          content: PushNotificationContent(
              largeIcon: null,
              id: 1,
              body: PushNotificationBody(
                  user: 'sardter', event: null, startDate: null, club: null)),
          time: DateTime.now(),
          itemId: 1,
          id: 1),
      PushNotificationData(
          type: PushNotificationType.fromType('like'),
          content: PushNotificationContent(
              largeIcon: null,
              id: 1,
              body: PushNotificationBody(
                  user: 'sardter', event: null, startDate: null, club: null)),
          time: DateTime.now(),
          itemId: 1,
          id: 1),
      PushNotificationData(
          type: PushNotificationType.fromType('like'),
          content: PushNotificationContent(
              largeIcon: null,
              id: 1,
              body: PushNotificationBody(
                  user: 'sardter', event: null, startDate: null, club: null)),
          time: DateTime.now(),
          itemId: 1,
          id: 1),
      PushNotificationData(
          type: PushNotificationType.fromType('like'),
          content: PushNotificationContent(
              largeIcon: null,
              id: 1,
              body: PushNotificationBody(
                  user: 'sardter', event: null, startDate: null, club: null)),
          time: DateTime.now(),
          itemId: 1,
          id: 1),
      PushNotificationData(
          type: PushNotificationType.fromType('like'),
          content: PushNotificationContent(
              largeIcon: null,
              id: 1,
              body: PushNotificationBody(
                  user: 'sardter', event: null, startDate: null, club: null)),
          time: DateTime.now(),
          itemId: 1,
          id: 1),
    ];
  }

  @override
  Future<int?> getListCount({QueryParameters? queryParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return 5;
  }

  @override
  Future<int?> getUnreadNotificationCount() async {
        await Future.delayed(Duration(milliseconds: 750));


    return 5;
  }

  @override
  Future<PushNotificationData?> updateItem(
      {required PushNotificationData updatedItem,
      required ItemParameters itemParameters}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return updatedItem;
  }

  @override
  Future<PushNotificationData?> postItem(
      {required PushNotificationData item}) async {
        await Future.delayed(Duration(milliseconds: 750));


    return item;
  }

  @override
  Future<bool?> resetUnreadNotifcations() async {
        await Future.delayed(Duration(milliseconds: 750));


    return true;
  }
}
