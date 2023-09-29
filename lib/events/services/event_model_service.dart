import 'package:ToGather/events/models/models.dart';
import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:ToGather/utilities/utilities.dart';

abstract class EventModelService extends ModelService<Event> {
  Future<double?> rate({required ItemParameters itemParameters, required double? score});

  Future<bool?> attend({required ItemParameters itemParameters, required FormResponse? formResponse});

  Future<bool?> verifyAttendeeStatus(
      {required ItemParameters eventParameters,
      required ItemParameters userParameters});

  Future<String?> getQRData({required ItemParameters itemParameters});
}
