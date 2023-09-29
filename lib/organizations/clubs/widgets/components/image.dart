import 'package:flutter/material.dart';
import 'package:ToGather/organizations/models/organization.dart';
import 'package:ToGather/utilities/utilities.dart';

class OrganizationImage extends StatelessWidget {
  const OrganizationImage({
    super.key,
    required Organization data,
  }) : _data = data;

  final Organization _data;

  @override
  Widget build(BuildContext context) {
    return SylvestImageProvider(
      defaultImage: /*DefaultImageManager.clubLogo*/ null,
      radius: 70,
      image: _data.image,
    );
  }
}
