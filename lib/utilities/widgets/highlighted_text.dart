import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class HighlightedText extends StatefulWidget {
  const HighlightedText({super.key, required this.text});
  final String text;

  @override
  State<HighlightedText> createState() => _HighlightedTextState();
}

class _HighlightedTextState extends State<HighlightedText> {
  bool _willBeHighlighted(String e) {
    return e.isNotEmpty && (e[0] == '@' || e[0] == '#');
  }

  Future<void> _onTap(String tagged) async {
    if (!_willBeHighlighted(tagged)) return;
    if (tagged[0] == '@') {
      launchPage(
          context,
          UserPage(
            setPage: (i) {},
            username: tagged.substring(1),
          ));
    }
  }

  List<TextSpan> get _taggedTex {
    final words = widget.text.split(" ");

    return words
        .map((e) => TextSpan(
            text: '$e ',
            style: TextStyle(
                color: _willBeHighlighted(e)
                    ? ThemeService.eventColor
                    : null),
            recognizer: TapGestureRecognizer()..onTap = () => _onTap(e)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(style: TextStyle(color: ThemeService.primaryText), children: _taggedTex));
  }
}
