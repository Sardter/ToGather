import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/modals/modals.dart';
import 'package:ToGather/utilities/utilities.dart';

class ShareButton extends StatefulWidget {
  const ShareButton(
      {Key? key,
      this.showTitle = false,
      required this.shareableId,
      this.color,
      required this.type})
      : super(key: key);
  final bool showTitle;
  final int shareableId;
  final LinkType type;
  final Color? color;

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchModal(
          context,
          ShareOptionsModal(
              shareableId: widget.shareableId, type: widget.type)),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Icon(LineIcons.share, size: 25, color: widget.color),
            if (widget.showTitle)
              Text(
                "Paylaş",
                style: TextStyle(fontSize: 9, color: widget.color),
              )
          ],
        ),
      ),
    );
  }
}