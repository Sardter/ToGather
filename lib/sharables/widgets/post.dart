import 'package:flutter/material.dart';
import 'package:ToGather/sharables/pages/detail_page.dart';
import 'package:ToGather/utilities/utilities.dart';

import '../models/models.dart';
import 'components/components.dart';

class PostWidget extends StatelessWidget {
  final Post data;
  final bool isDetail;
  final void Function(int? commendId, String? author) onCommentSelected;

  const PostWidget(
      {required this.data,
      required this.isDetail,
      required this.onCommentSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDetail
          ? null
          : () => launchPage(context, PostDetailPage(id: data.id)),
      child: PostContainer(
        onCommentSelected: onCommentSelected,
        post: data,
        isDetail: isDetail,
        id: data.id,
      ),
    );
  }
}
