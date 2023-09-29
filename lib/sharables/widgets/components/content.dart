import 'package:ToGather/users/filters/query_params.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/sharables/sharables.dart';

class SharableContentWidget extends StatelessWidget {
  final Sharable sharable;

  const SharableContentWidget({Key? key, required this.sharable})
      : super(key: key);

  Widget build(context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Rating(
            rating: sharable.ratingAverage,
            ratingCount: sharable.rateCount,
            queryParameters: ProfileQueryParameters(
                postRaters: sharable is Post ? sharable as Post : null,
                commentRates: sharable is Comment ? sharable as Comment : null),
          ),
          const SizedBox(height: 5),
          if (sharable.content != null) TextContent(sharable.content!),
          if (sharable.media.isNotEmpty)
            SylvestMediaCarousal(media: sharable.media),
        ],
      ),
    );
  }
}
