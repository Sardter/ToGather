import 'package:ToGather/users/users.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';

export 'segments/segments.dart';
export 'controllers/controllers.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key, required this.controller});
  final CreatePostController controller;

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  List<CreatePageSegment> _segments(Profile user) => [
        CreatePostDescriptionSegment(
          user: user,
          descriptionController: widget.controller.descriptionController,
        ),
        BuilderMediaSegment(mediaController: widget.controller.mediaController),
        BuilderLocationSegment(
            locationController: widget.controller.locationController),
      ];

  @override
  Widget build(BuildContext context) {
    return CreateModelPage<Post>(
        pageTitle: "Gönderi Oluştur",
        controller: widget.controller,
        detailPage: (item) => PostDetailPage(id: item.id),
        segments: _segments,
        warningsController: widget.controller.warningsController,
        buttonChildren: const [
          Icon(
            Icons.share,
            color: ThemeService.onContrastColor,
          ),
          SizedBox(width: 10),
          Text(
            "Gönderiyi Paylaş",
            style: TextStyle(
              color: ThemeService.onContrastColor,
            ),
          )
        ]);
  }
}
