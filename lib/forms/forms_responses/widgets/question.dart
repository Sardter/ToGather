import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

class ResponseQuestion extends StatelessWidget {
  const ResponseQuestion(
      {Key? key, required this.questionRequired, required this.question})
      : super(key: key);
  final bool questionRequired;
  final String question;

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