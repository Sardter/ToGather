import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/utilities/services/theme.dart';
import 'package:ToGather/sharables/widgets/comment.dart';

class CommentReplies extends StatelessWidget {
  const CommentReplies(
      {Key? key,
      required this.comments,
      required this.commentId,
      required this.controller,
      required this.hasReplies,
      required this.onCommentSelected})
      : super(key: key);
  final List<CommentWidget> comments;
  final int commentId;
  final void Function(int? id, String? name) onCommentSelected;
  final bool hasReplies;
  final ExpandableController controller;

  Widget _smallDot() {
    return Container(
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: ThemeService.unusedColor),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: 10,
      width: 10,
    );
  }

  Widget _showRepliesIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _smallDot(),
        _smallDot(),
        _smallDot(),
        const Text(
          "Cevapları Göster",
          style: TextStyle(
              color: ThemeService.unusedColor, fontFamily: 'Quicksand'),
        ),
        _smallDot(),
        _smallDot(),
        _smallDot(),
      ],
    );
  }

  Widget _expandable() {
    return ExpandablePanel(
      controller: controller,
      collapsed: hasReplies ? _showRepliesIndicator() : SizedBox(),
      expanded: IntrinsicHeight(
          child: Row(
        children: [
          VerticalDivider(),
          Expanded(
              child: Column(
            children: comments,
          ))
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!hasReplies) return SizedBox();
    return GestureDetector(child: _expandable());
  }
}
