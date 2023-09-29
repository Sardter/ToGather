import 'package:flutter/material.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class ProfileAbout extends StatelessWidget {
  const ProfileAbout({super.key, required this.profile});
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: HighlightedText(text: profile.about),
    );
  }
}