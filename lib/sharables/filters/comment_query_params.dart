import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/filters/filters.dart';

class CommentQueryParameters extends QueryParameters<Comment> {
  final int? postId;
  final int? commentId;

  const CommentQueryParameters({super.searchQuery, this.postId, this.commentId, super.pageSize});
  
  @override
  List<String?> get fieldsToStr => [
    fieldStringify<int>(postId, (field) => 'post=${field}'),
    fieldStringify<int>(commentId, (field) => 'reply_to=${field}'),
  ];
}