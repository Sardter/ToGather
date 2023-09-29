import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

class SelectedLogo extends StatefulWidget {
  const SelectedLogo(
      {super.key,
      required this.notifier,
      required this.child,
      this.radius = 50});
  final ValueNotifier<ImageData?> notifier;
  final Widget child;
  final double radius;

  @override
  State<SelectedLogo> createState() => _SelectedLogoState();
}

class _SelectedLogoState extends State<SelectedLogo> {
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
                CircleAvatar(
                  foregroundImage: widget.notifier.value == null
                      ? null
                      : widget.notifier.value is NetworkImageData
                          ? NetworkImage(widget.notifier.value!.url)
                          : FileImage(
                                  (widget.notifier.value as ImageFileData).file)
                              as ImageProvider,
                  //backgroundImage: AssetImage("assets/images/defaultP.png"),
                  backgroundColor: Colors.black12,
                  radius: widget.radius,
                  child: widget.child,
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
