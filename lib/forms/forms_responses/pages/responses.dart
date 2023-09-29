import 'package:ToGather/events/models/models.dart';
import 'package:ToGather/forms/forms_responses/filters/query_params.dart';
import 'package:ToGather/users/users.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:ToGather/utilities/utilities.dart';

class FormResponsesPage extends StatefulWidget {
  const FormResponsesPage({Key? key, required this.event, required this.profile}) : super(key: key);
  final Event? event;
  final Profile? profile;

  @override
  State<FormResponsesPage> createState() => _FormResponsesPageState();
}

class _FormResponsesPageState extends State<FormResponsesPage> {
  @override
  Widget build(context) {
    return FilteredPage<FormResponse>(
      manager: ModelServiceFactory.FORMRESPONSE,
      queryParameters: FormResponseQueryParameters(
        event: widget.event,
        user: widget.profile
      ),
      mapper: (response) => FormResponseWidget(formResponse: response),
    );
  }
}
