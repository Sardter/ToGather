import 'package:flutter/material.dart';
import 'package:ToGather/category/widgets/widgets.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/utilities/utilities.dart';

enum SearchClubAction { Display, SharePost, ShareActivity, ShareEvent }

class SearchClub extends StatefulWidget {
  const SearchClub(
      {Key? key,
      required this.club,
      this.width,
      this.action = SearchClubAction.Display})
      : super(key: key);
  final Club club;
  final double? width;
  final SearchClubAction action;

  @override
  State<SearchClub> createState() => _SearchClubState();
}

class _SearchClubState extends State<SearchClub> {
  bool get hasMedia => widget.club.banner != null;

  @override
  Widget build(BuildContext context) {
    return SylvestCard(
        backgroundImage: widget.club.banner == null
            ? null
            : NetworkImage(widget.club.banner!.url),
        onTap: () {
          launchPage(context, ClubPage(id: widget.club.id));
        },
        padding: EdgeInsets.zero,
        height: 170,
        width: widget.width,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: ThemeService.allAroundBorderRadius,
              color: widget.club.banner == null ? null : Colors.black26),
          padding: const EdgeInsets.all(10),
          height: 170,
          child: Column(
            children: [
              Row(
                children: [
                  SylvestImageProvider(
                    defaultImage: /*DefaultImageManager.clubLogo*/ null,
                    image: widget.club.image,
                    radius: 35,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.43,
                        child: Row(
                          children: [
                            if (widget.club.verified) ...[
                              Icon(Icons.verified, color: hasMedia ? ThemeService.onContrastColor : null,),
                              SizedBox(width: 10)
                            ],
                            Expanded(
                                child: Text(
                              widget.club.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: hasMedia ? ThemeService.onContrastColor : null,
                                  fontFamily: ThemeService.headlineFont),
                            )),
                          ],
                        ),
                      ),
                      SmallCategoryWidget(category: widget.club.category)
                    ],
                  ),
                ],
              ),
              if (widget.club.reviewAverage != null)
                Rating(rating: widget.club.reviewAverage!, ratingCount: null),
              const Spacer(),
              OrganizationStats(
                  hasMedia: widget.club.banner != null,
                  context: context,
                  data: widget.club,
                  eventManager: ModelServiceFactory.EVENT),
              const Spacer(),
            ],
          ),
        ));
  }
}
