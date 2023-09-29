import 'package:flutter/material.dart';
import 'package:ToGather/forms/forms/forms.dart';
import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:ToGather/utilities/utilities.dart';

class LongFormResponse extends StatelessWidget implements Response {
  const LongFormResponse(
      {Key? key,
      required this.name,
      required this.question,
      required this.questionRequired,
      required this.data})
      : super(key: key);

  @override
  final String name, question;
  final bool questionRequired;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionWidget(
              question: question, questionRequired: questionRequired),
          Divider(),
          data != null
              ? Text(data!)
              : Text(
                  LanguageService().data.sharable.noResponse,
                  style: TextStyle(color: ThemeService.unusedColor),
                )
        ],
      ),
    );
  }
}