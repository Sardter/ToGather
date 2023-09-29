import 'package:ToGather/utilities/utilities.dart';

import 'models.dart';

class Comment extends Sharable {
  final RelatedData relatedData;

  const Comment(
      {required super.media,
      required super.content,
      required super.id,
      required super.commentCount,
      required super.datePosted,
      required super.ratingAverage,
      required super.author,
      required super.isAnonymous,
      required this.relatedData,
      required super.rateCount,
      required super.requestData});

  factory Comment.fromJson(Map<String, dynamic> json) {
    print("comment json: $json");
    return Comment(
        media: List<String>.from(json['media'] ?? [])
            .map((e) => NetworkMediaData.fromURL(e))
            .toList(),
        content: json['content'],
        id: json['id'],
        relatedData: RelatedData(
            postId: json['post_id'], commentId: json['reply_to_id']),
        commentCount: json['comments'] ?? 0,
        datePosted: DateTime.parse(json['created_at']),
        ratingAverage: json['rate'] ?? 0,
        isAnonymous: json['is_anon'] ?? false,
        author: PostAuthor.fromJson(json),
        rateCount: json['rate_count'] ?? 0,
        requestData: json['request_data'] == null
            ? null
            : SharableRequestData.fromJson(json['request_data']));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'media': media.map((e) => e.toJson()).toList(),
      'is_anon': isAnonymous,
      'post_id': relatedData.postId,
      'reply_to_id': relatedData.commentId
    };
  }
}
