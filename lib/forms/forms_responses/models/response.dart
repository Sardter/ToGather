import 'package:ToGather/events/events.dart';
import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class FormResponse extends Model {
  final Profile author;
  final Event event;
  final DateTime date;
  final List<FormBlockData> data;
  final AllowedActions? allowedActions;

  FormResponse(
      {required super.id,
      required this.author,
      required this.event,
      required this.date,
      required this.allowedActions,
      required this.data});

  factory FormResponse.fromJson(Map json) {
    return FormResponse(
        id: json['id'],
        author: Profile.fromJson(json['user']),
        event: json['event'],
        date: DateTime.parse(json['created_at']),
        data: List<Map<String, dynamic>>.from(json['form_data'])
            .map((e) => FormBlockData.fromJson(e))
            .toList(),
        allowedActions: AllowedActions.fromJson(json['allowed_actions']));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': author.id,
      'event_id': event.id,
      'form_data': data.map((e) => e.toJson()).toList()
    };
  }
}
