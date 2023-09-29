import 'package:ToGather/events/models/models.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:ToGather/utilities/utilities.dart';

class ResponsesButton extends StatelessWidget {
  const ResponsesButton({Key? key, required this.event})
      : super(key: key);
  final Event event;

  Future<bool> _onTap(context) async {
    await launchPage(
        context,
        FormResponsesPage(
          event: event,
          profile: null,
        ));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SylvestButton(
      children: [
        Icon(LineIcons.users),
        SizedBox(
          width: 10,
        ),
        Text(LanguageService().data.titles.responses)
      ],
      onTap: () => _onTap(context),
      maximizeLength: true,
    );
  }
}
