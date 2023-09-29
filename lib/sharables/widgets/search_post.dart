import 'package:flutter/material.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';

class SearchPost extends StatefulWidget {
  const SearchPost({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  State<SearchPost> createState() => _SearchPostState();
}

class _SearchPostState extends State<SearchPost> {
  bool get hasMedia => widget.post.media.where((element) => element is NetworkImageData).isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return SylvestCard(
      onTap: () => launchPage(context, PostDetailPage(id: widget.post.id)),
      height: 170,
      backgroundImage: !hasMedia
              ? null
              : NetworkImage(widget.post.media
                  .firstWhere((element) => element is NetworkImageData)
                  .url),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: ThemeService.allAroundBorderRadius,
            color: widget.post.media
                    .where((element) => element is NetworkImageData)
                    .isEmpty
                ? null
                : Colors.black26),
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SharableHeader(data: widget.post),
            PostTitle(title: widget.post.title, hasMedia: hasMedia),
            if (widget.post.content != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  widget.post.content!,
                  maxLines: 2,
                  style: TextStyle(color: hasMedia ? ThemeService.onContrastColor : null,),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Rating(rating: widget.post.ratingAverage, ratingCount: null,),
                const SizedBox(width: 10),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: hasMedia ? ThemeService.onContrastColor : ThemeService.primaryText,),
                    children: [
                    TextSpan(text: "${widget.post.rateCount}"),
                    TextSpan(text: " değerlenidrme , ", style: TextStyle(color: ThemeService.secondaryText, fontSize: 10)),
                    TextSpan(text: "${widget.post.commentCount}"),
                    TextSpan(text: " Yorum", style: TextStyle(color: ThemeService.secondaryText, fontSize: 10))
                  ]),
                )
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
