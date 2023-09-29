import 'package:flutter/material.dart';
import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/forms/forms/forms.dart';
import 'package:ToGather/forms/forms_responses/form_responses.dart';

class CheckBoxFormResponse extends StatelessWidget implements Response {
  const CheckBoxFormResponse(
      {Key? key,
      required this.name,
      required this.question,
      required this.questionRequired,
      required this.data})
      : super(key: key);

  @override
  final String name, question;
  final bool questionRequired;
  final List<CheckData> data;

  Widget _option(CheckData data) {
    return Row(
      children: [
        Checkbox(value: data.selected, onChanged: null),
        Text(data.text)
      ],
    );
  }

  List<Widget> _options() {
    return data.map<Widget>((e) => _option(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        QuestionWidget(question: question, questionRequired: questionRequired),
        Divider(),
        ..._options()
      ]),
    );
  }
}