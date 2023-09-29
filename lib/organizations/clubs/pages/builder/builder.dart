import 'package:ToGather/users/users.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/organizations/clubs/pages/builder/segments/description.dart';
import 'package:ToGather/utilities/utilities.dart';

export 'controllers/controllers.dart';
export 'segments/segments.dart';

class CreateClubPage extends StatefulWidget {
  const CreateClubPage({super.key, required this.controller});
  final CreateClubController controller;

  @override
  State<CreateClubPage> createState() => _CreateClubPageState();
}

class _CreateClubPageState extends State<CreateClubPage> {
  List<CreatePageSegment> _segments(Profile user) => [
    CreateClubDescriptionSegment(
      descriptionController: widget.controller.descriptionController,
    ),
    BuilderLocationSegment(
        locationController: widget.controller.locationController),
  ];

  @override
  Widget build(BuildContext context) {
    return CreateModelPage<Club>(
        pageTitle: "Topluluk Oluştur",
        controller: widget.controller,
        detailPage: (item) => ClubPage(id: item.id),
        segments: _segments,
        warningsController: widget.controller.warningsController,
        buttonChildren: const [
          Icon(Icons.share, color: ThemeService.onContrastColor,),
          SizedBox(width: 10),
          Text("Topluluğu Paylaş", style: TextStyle(color: ThemeService.onContrastColor,),)
        ]);
  }
}