import 'package:flutter/material.dart';

class ProfileStatusItem extends StatelessWidget {
  final String attriburte;
  final int stat;
  final IconData icon;

  const ProfileStatusItem(this.attriburte, this.stat, this.icon);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          size: 18,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "$stat $attriburte",
          style: TextStyle(fontFamily: '', fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}