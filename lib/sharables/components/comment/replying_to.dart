import 'package:flutter/material.dart';
import 'package:ToGather/utilities/services/language.dart';
import 'package:ToGather/utilities/services/theme.dart';

class ReplyingTo extends StatelessWidget {
  final String user;
  const ReplyingTo(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        margin: const EdgeInsets.only(bottom: 10, left: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: ThemeService.menuBackground,
        ),
        child: RichText(
          text: TextSpan(
              text: LanguageService().data.builder.replyingTo,
              style: const TextStyle(fontSize: 11, color: ThemeService.secondaryText),
              children: [
                TextSpan(
                  text: '@$user',
                  style: const TextStyle(color: ThemeService.eventColor),
                )
              ]),
        ));
  }
}