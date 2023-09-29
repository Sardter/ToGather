import 'package:ToGather/events/events.dart';
import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/filters/filters.dart';

class FormResponseQueryParameters extends QueryParameters<FormResponse> {
  final Event? event;
  final Profile? user;

  const FormResponseQueryParameters({super.searchQuery, this.event, this.user});

  @override
  List<String?> get fieldsToStr => [
    fieldStringify<Event>(event, (field) => 'event=${field.id}'),
    fieldStringify<Profile>(user, (field) => 'user=${field.id}')
  ];
}
