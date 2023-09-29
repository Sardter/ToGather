import 'package:flutter/material.dart';
import 'package:ToGather/category/widgets/widgets.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/utilities/utilities.dart';

class SearchPlace extends StatefulWidget {
  const SearchPlace({super.key, required this.place, this.width});
  final Place place;
  final double? width;

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> {
  bool get hasMedia => widget.place.banner != null;

  @override
  Widget build(BuildContext context) {
    return SylvestCard(
        backgroundImage: widget.place.banner == null
            ? null
            : NetworkImage(widget.place.banner!.url),
        onTap: () {
          launchPage(context, PlaceDetailPage(id: widget.place.id));
        },
        padding: EdgeInsets.zero,
        height: 170,
        width: widget.width,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: ThemeService.allAroundBorderRadius,
              color: widget.place.banner == null ? null : Colors.black45),
          padding: const EdgeInsets.all(10),
          height: 170,
          child: Column(
            children: [
              Row(
                children: [
                  SylvestImageProvider(
                    defaultImage: /*DefaultImageManager.clubLogo*/ null,
                    image: widget.place.image,
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
                            if (widget.place.verified) ...[
                              Icon(
                                Icons.verified,
                                color: hasMedia
                                    ? ThemeService.onContrastColor
                                    : null,
                              ),
                              SizedBox(width: 10)
                            ],
                            Expanded(
                                child: Text(
                              widget.place.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: hasMedia
                                      ? ThemeService.onContrastColor
                                      : null,
                                  fontFamily: ThemeService.headlineFont),
                            )),
                          ],
                        ),
                      ),
                      SmallCategoryWidget(category: widget.place.category)
                    ],
                  ),
                ],
              ),
              if (widget.place.reviewAverage != null)
                Rating(
                  rating: widget.place.reviewAverage!,
                  ratingCount: null,
                ),
              const Spacer(),
              OrganizationStats(
                  hasMedia: widget.place.banner != null,
                  context: context,
                  data: widget.place,
                  eventManager: ModelServiceFactory.EVENT),
              const Spacer(),
            ],
          ),
        ));
  }
}
