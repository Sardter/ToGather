import 'package:flutter/material.dart';
import 'package:ToGather/organizations/models/organization.dart';
import 'package:ToGather/utilities/utilities.dart';

class OrganizationTitle extends StatelessWidget {
  const OrganizationTitle({super.key, required this.club});
  final Organization club;

  @override
  Widget build(BuildContext context) {
    return Text(
      club.title,
      style: TextStyle(
        fontFamily: ThemeService.headlineFont,
        fontSize: 25,
      ),
    );
  }
}
