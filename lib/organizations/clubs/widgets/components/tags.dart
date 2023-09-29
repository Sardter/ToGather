import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';

class ClubTags extends StatelessWidget {
  const ClubTags({
    super.key,
    required this.widget,
  });

  final ClubWidget widget;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.club.tags
          .map((tag) => Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Chip(label: Text(tag)),
              ))
          .toList(),
    );
  }
}
