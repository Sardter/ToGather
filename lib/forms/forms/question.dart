import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {Key? key, required this.question, required this.questionRequired})
      : super(key: key);
  final String question;
  final bool questionRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        if (questionRequired)
          Text('⬤', style: TextStyle(color: ThemeService.eventColor)),
        if (questionRequired) const SizedBox(width: 8),
        Text(question, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}