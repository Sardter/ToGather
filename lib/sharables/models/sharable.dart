import 'package:ToGather/utilities/utilities.dart';

import 'models.dart';

abstract class Sharable extends Model implements ModelWithMedia {
  final PostAuthor author;
  final int rateCount;
  final double ratingAverage;
  final int commentCount;
  final DateTime datePosted;
  final SharableRequestData? requestData;
  final List<MediaData> media;
  final String? content;
  final bool isAnonymous;

  bool get hasReplies => commentCount != 0;

  const Sharable(
      {required this.author,
      required this.ratingAverage,
      required this.rateCount,
      required this.commentCount,
      required this.requestData,
      required this.media,
      required this.isAnonymous,
      required this.content,
      required this.datePosted,
      required super.id});
}
