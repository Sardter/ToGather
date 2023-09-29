import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

class SelectedBanner extends StatefulWidget {
  const SelectedBanner(
      {super.key,
      required this.notifier,
      required this.child,
      this.height = 150,
      this.width = double.maxFinite});
  final ValueNotifier<ImageData?> notifier;
  final Widget child;
  final double height;
  final double width;

  @override
  State<SelectedBanner> createState() => _SelectedBannerState();
}

class _SelectedBannerState extends State<SelectedBanner> {
  final _service = ImagePickerService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await _service.getImage(context);
        if (picked == null) return;
        widget.notifier.value =
            ImageFileData(file: File(picked.path), url: picked.path);
        setState(() {});
      },
      child: ValueListenableBuilder(
          valueListenable: widget.notifier,
          builder: (context, value, child) {
            return Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: ThemeService.menuBackground,
                      image: widget.notifier.value == null
                          ? null
                          : DecorationImage(
                              image: widget.notifier.value is ImageFileData
                                  ? FileImage(
                                      (widget.notifier.value as ImageFileData)
                                          .file)
                                  : NetworkImage(widget.notifier.value!.url)
                                      as ImageProvider),
                      borderRadius: ThemeService.allAroundBorderRadius),
                  height: widget.height,
                  width: widget.width,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ThemeService.menuBackground.withOpacity(0.4),
                        borderRadius: ThemeService.allAroundBorderRadius),
                    height: widget.height,
                    width: widget.width,
                    child: widget.child,
                  ),
                ),
                if (widget.notifier.value != null)
                  GestureDetector(
                    onTap: () {
                      widget.notifier.value = null;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      padding: const EdgeInsets.all(5),
                      child: Icon(Icons.close, size: 15),
                    ),
                  )
              ],
            );
          }),
    );
  }
}
