import 'package:flutter/material.dart';
import 'package:ToGather/organizations/models/organization.dart';
import 'package:ToGather/utilities/utilities.dart';

class OrganizationDescription extends StatelessWidget {
  const OrganizationDescription({
    super.key,
    required Organization data,
  }) : _data = data;

  final Organization _data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: HighlightedText(text: _data.about),
    );
  }
}
