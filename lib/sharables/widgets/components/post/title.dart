import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/utilities/utilities.dart';

class PostTitle extends StatelessWidget {
  PostTitle({required this.title, required this.hasMedia});
  final String title;
  final bool hasMedia;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: [
            Icon(LineIcons.hashtag),
            const SizedBox(width: 10),
            Expanded(
                child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: hasMedia ? ThemeService.onContrastColor : null,
              ),
            ))
          ],
        ));
  }
}
