import 'package:flutter/material.dart';

import 'package:ToGather/category/category.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/utilities/utilities.dart';

class SearchEvent extends StatefulWidget {
  const SearchEvent({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  State<SearchEvent> createState() => _SearchEventState();
}

class _SearchEventState extends State<SearchEvent> {
  bool get hasMedia => widget.event.media
      .where((element) => element is NetworkImageData)
      .isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return SylvestCard(
        backgroundImage: !hasMedia
            ? null
            : NetworkImage((widget.event.media
                        .firstWhere((element) => element is NetworkImageData)
                    as NetworkImageData)
                .url),
        height: 170,
        padding: EdgeInsets.zero,
        //width: MediaQuery.of(context).size.width * 0.8,
        onTap: () => launchPage(context, EventPage(id: widget.event.id)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: ThemeService.allAroundBorderRadius,
              color: widget.event.media.isEmpty ? null : Colors.black12),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(widget.event.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 22,
                              color: hasMedia
                                  ? ThemeService.onContrastColor
                                  : null,
                              fontFamily: ThemeService.headlineFont))),
                  if (widget.event.reviewsAverage != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Rating(
                            rating: widget.event.reviewsAverage!,
                            ratingCount: null),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.timer,
                              size: 15,
                              color: hasMedia
                                  ? ThemeService.onContrastColor
                                  : null,
                            ),
                            SizedBox(width: 10),
                            Text(
                              dateTimeToStr(widget.event.startDate),
                              style: TextStyle(
                                fontSize: 13,
                                color: hasMedia
                                    ? ThemeService.onContrastColor
                                    : null,
                              ),
                            )
                          ].reversed.toList(),
                        ),
                      ],
                    ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmallCategoryWidget(category: widget.event.category),
                      if (widget.event.description != null)
                        Text(
                          widget.event.description!,
                          maxLines: 2,
                          style: TextStyle(
                            color:
                                hasMedia ? ThemeService.onContrastColor : null,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  )),
                  if (widget.event.host != null)
                    Row(
                      children: [
                        SylvestImageProvider(
                            image: widget.event.host!.image,
                            defaultImage: null),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            Text(widget.event.host!.title,
                                style: TextStyle(
                                  fontFamily: ThemeService.headlineFont,
                                  color: hasMedia
                                      ? ThemeService.onContrastColor
                                      : null,
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                if (widget.event.host!.verified)
                                  Icon(
                                    Icons.verified,
                                    size: 13,
                                    color: hasMedia
                                        ? ThemeService.onContrastColor
                                        : null,
                                  ),
                                if (widget.event.host is EventClubHost)
                                  Icon(
                                    Icons.people,
                                    size: 15,
                                    color: hasMedia
                                        ? ThemeService.onContrastColor
                                        : null,
                                  )
                              ],
                            )
                          ],
                        ),
                      ].reversed.toList(),
                    )
                ],
              ),
              const Spacer(),
              Text(
                "${widget.event.attendees} kişi katılıyor",
                style: TextStyle(
                  color: hasMedia ? ThemeService.onContrastColor : null,
                ),
              )
            ],
          ),
        ));
  }
}
