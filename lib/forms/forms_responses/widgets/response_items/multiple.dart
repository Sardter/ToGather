import 'package:flutter/material.dart';
import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/forms/forms/forms.dart';
import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:ToGather/utilities/utilities.dart';

class MultipleChoiceFormResponse extends StatelessWidget implements Response {
  const MultipleChoiceFormResponse(
      {Key? key,
      required this.name,
      required this.question,
      required this.questionRequired,
      required this.data})
      : super(key: key);

  @override
  final String name, question;
  final bool questionRequired;
  final List<ChoiceData> data;

  Widget _option(ChoiceData data) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 3)
        ],
        borderRadius: BorderRadius.circular(30),
        color: data.selected
            ? ThemeService.eventColor
            : ThemeService.textField,
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.maxFinite,
      padding: const EdgeInsets.all(5),
      child: Text(
        data.text,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        QuestionWidget(question: question, questionRequired: questionRequired),
        Divider(),
        ...data.map<Widget>((e) => _option(e)).toList()
      ]),
    );
  }
}