import 'package:flutter/material.dart';
import 'package:ToGather/utilities/models/media.dart';
import 'package:ToGather/utilities/widgets/image_widgets.dart';

class PostMediaImage extends StatelessWidget {
  const PostMediaImage({super.key, required this.imageData});
  final ImageData imageData;

  @override
  Widget build(BuildContext context) {
    return SylvestImage(
      image: imageData,
      defaultImage: null,
      useDefault: false,
    );
  }
}
