import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

class TextContent extends StatelessWidget {
  const TextContent(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: HighlightedText(text: text),
    );
  }
}
