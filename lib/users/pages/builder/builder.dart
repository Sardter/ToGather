import 'package:flutter/material.dart';
import 'package:ToGather/users/pages/builder/controllers/user.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

export 'segments/segments.dart';
export 'controllers/controllers.dart';
export 'widgets/widgets.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key, required this.controller});
  final CreateProfileController controller;

  @override
  State<CreateUserPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateUserPage> {
  List<CreatePageSegment> _segments(Profile user) => [
        CreateProfileDescriptionSegment(
          descriptionController: widget.controller.descriptionController,
        ),
        BuilderMediaSegment(mediaController: widget.controller.mediaController),
      ];

  @override
  Widget build(BuildContext context) {
    return CreateModelPage<Profile>(
        pageTitle: "Profilini Güncelle",
        controller: widget.controller,
        detailPage: (item) => UserPage(setPage: (i) {}, id: item.id),
        segments: _segments,
        warningsController: widget.controller.warningsController,
        buttonChildren: const [
          Icon(
            Icons.share,
            color: ThemeService.onContrastColor,
          ),
          SizedBox(width: 10),
          Text(
            "Profilini Güncelle",
            style: TextStyle(
              color: ThemeService.onContrastColor,
            ),
          )
        ]);
  }
}
