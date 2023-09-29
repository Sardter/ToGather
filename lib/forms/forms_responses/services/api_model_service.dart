import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:ToGather/utilities/utilities.dart';

class FormResponseAPIModelService extends APIModelService<FormResponse> {
  @override
  String get url => URLManager.formResponses;
  
  @override
  String get modelType => "Attendee";
}