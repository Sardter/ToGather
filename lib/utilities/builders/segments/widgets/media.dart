import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:ToGather/utilities/utilities.dart';

class BuilderMediaSegment<T extends MediaData> extends StatefulWidget
    implements CreatePageSegment {
  const BuilderMediaSegment({super.key, required this.mediaController});
  final BuilderMediaController<T> mediaController;

  @override
  State<BuilderMediaSegment<T>> createState() => _BuilderMediaSegmentState<T>();

  @override
  IconData get icon => Icons.photo_camera;

  @override
  String get label => "Medya";
}

class _BuilderMediaSegmentState<T extends MediaData>
    extends State<BuilderMediaSegment<T>> {
  final _picker = ImagePickerService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.81,
      child: ReorderableGridView.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        dragWidgetBuilder: (index, child) {
          return SylvestCard(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.width * 0.35,
            padding: EdgeInsets.zero,
            child: child,
            margin: EdgeInsets.zero,
          );
        },
        children: List.generate(
          widget.mediaController.selectedMedia.length,
          (index) {
            final media = widget.mediaController.selectedMedia[index];
            return Stack(
              alignment: Alignment.topRight,
              key: UniqueKey(),
              children: [
                SylvestCard(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.width * 0.35,
                  padding: EdgeInsets.zero,
                  child: ClipRRect(
                    borderRadius: ThemeService.allAroundBorderRadius,
                    child: media is VideoData
                        ? SylvestVideoThumbnail(url: media.url)
                        : SylvestImage(
                            image: media as ImageData,
                            useDefault: false,
                            defaultImage: null),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.mediaController.selectedMedia.removeAt(index);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(2),
                    child: Icon(
                      Icons.close,
                      size: 15,
                    ),
                  ),
                )
              ],
            );
          },
        ),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            final element =
                widget.mediaController.selectedMedia.removeAt(oldIndex);
            widget.mediaController.selectedMedia.insert(newIndex, element);
          });
        },
        footer: [
          GestureDetector(
            onTap: () async {
              widget.mediaController.selectedMedia +=
                  (await _picker.pickMultipleMedia(imageOnly: T is ImageData))
                      .map((e) => FileMediaData.fromFile(File(e.path)))
                      .cast<T>()
                      .toList();
              setState(() {});
            },
            child: SylvestCard(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.width * 0.35,
              padding: EdgeInsets.zero,
              child: Icon(Icons.add_a_photo),
            ),
          ),
        ],
      ),
    );
  }
}
