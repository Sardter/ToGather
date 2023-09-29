import 'package:ToGather/events/events.dart';
import 'package:ToGather/forms/forms_responses/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';

class EventAPIModelService extends APIModelService<Event>
    implements EventModelService {
  @override
  String get url => URLManager.events;

  Future<bool?> _attend(
      {required ItemParameters itemParameters,
      required FormResponse? formResponse}) async {
    return await api.actionAndGetResponseItems(
            url: URLManager.eventAttend(itemParameters.id!),
            body: {
              'form_data': formResponse?.toJson()
            },
            action: APIAction.Post);
  }

  Future<Map?> _getQRData({required ItemParameters itemParameters}) async {
    return await api.actionAndGetResponseItems(
        url: URLManager.eventVerify(itemParameters.id!));
  }

  Future<Map?> _rate(
      {required ItemParameters itemParameters, required double? score}) async {
    return await api.actionAndGetResponseItems(
        url: URLManager.eventRate(itemParameters.id!),
        action: APIAction.Post,
        body: {'rate': score});
  }

  Future<Map?> _verifyAttendeeStatus(
      {required ItemParameters eventParameters,
      required ItemParameters userParameters}) async {
    return await api.actionAndGetResponseItems(
        url:
            URLManager.eventVerifyUser(eventParameters.id!, userParameters.id!),
        action: APIAction.Post);
  }

  @override
  String get modelType => "Event";

  @override
  Future<bool?> attend(
      {required ItemParameters itemParameters,
      required FormResponse? formResponse}) async {
    return await _attend(itemParameters: itemParameters, formResponse: formResponse);
  }

  @override
  Future<String?> getQRData({required ItemParameters itemParameters}) async {
    return (await _getQRData(
        itemParameters: itemParameters))?['verification_link'];
  }

  @override
  Future<double?> rate(
      {required ItemParameters itemParameters, required double? score}) async {
    return (await _rate(itemParameters: itemParameters, score: score))?['rate'];
  }

  @override
  Future<bool?> verifyAttendeeStatus(
      {required ItemParameters eventParameters,
      required ItemParameters userParameters}) async {
    return (await _verifyAttendeeStatus(
        eventParameters: eventParameters,
        userParameters: userParameters))?['verification status'];
  }
}
