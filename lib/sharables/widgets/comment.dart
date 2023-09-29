import 'package:ToGather/sharables/filters/comment_query_params.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/sharables/sharables.dart';

class CommentWidget extends StatefulWidget {
  final Comment data;

  final void Function(int? commendId, String? author) onCommentSelected;

  const CommentWidget({required this.data, required this.onCommentSelected});

  @override
  State<CommentWidget> createState() => CommentWidgetState();
}

class CommentWidgetState extends State<CommentWidget> {
  late final _manager = ModelServiceFactory.COMMENT;
  final _controller = ExpandableController();
  bool _loading = false;

  late bool _canCallReplies = widget.data.hasReplies;
  List<CommentWidget> _replies = [];

  Future<List<CommentWidget>> _getComments() async {
    final replies = (await _manager.getList(
      queryParameters: CommentQueryParameters(
        postId: widget.data.relatedData.postId,
        commentId: widget.data.relatedData.commentId,
        pageSize: 100000
      )
    ))!;
    return replies
        .map((e) =>
            CommentWidget(data: e, onCommentSelected: widget.onCommentSelected))
        .toList();
  }

  Future<void> _onMoreReplies() async {
    if (_canCallReplies) {
      _loading = true;
      _canCallReplies = false;
      setState(() {});

      _replies = await _getComments();
      _loading = false;
      setState(() {});
    }
    _controller.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: ThemeService.secondaryText))),
      child: Column(
        children: [
          GestureDetector(
            onTap: _onMoreReplies,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SharableHeader(data: widget.data),
                  SharableContentWidget(sharable: widget.data),
                  SharableButtons(
                      sharable: widget.data,
                      onCommentSelected: widget.onCommentSelected),
                ],
              ),
            ),
          ),
          Container(
            margin: widget.data.relatedData.commentId != null
                ? const EdgeInsets.only(left: 20)
                : EdgeInsets.zero,
            child: _loading
                ? LoadingIndicator()
                : CommentReplies(
                    onCommentSelected: widget.onCommentSelected,
                    commentId: widget.data.relatedData.postId,
                    hasReplies: widget.data.hasReplies,
                    controller: _controller,
                    comments: _replies),
          ),
        ],
      ),
    );
  }
}
