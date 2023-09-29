import 'package:flutter/material.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';

class PostContainer extends StatelessWidget {
  const PostContainer(
      {required this.id,
      required this.isDetail,
      required this.post,
      required this.onCommentSelected});

  final Post post;
  final void Function(int? commendId, String? author) onCommentSelected;
  final int id;
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        //future: APIService().isHidden('post', id),
        builder: (c, s) {
      if (s.hasData && s.data!) {
        return HiddenItem(type: 'post', id: id);
      }
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SharableHeader(data: post),
            PostTitle(title: post.title, hasMedia: false),
            SharableContentWidget(sharable: post),
            SharableButtons(
                sharable: post, onCommentSelected: onCommentSelected),
          ],
        ),
      );
    });
  }
}
