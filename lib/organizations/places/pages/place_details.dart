import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/events/widgets/components/componets.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/organizations/places/places.dart';

class PlaceDetails extends StatefulWidget implements PageData {
  const PlaceDetails({super.key, required this.place});
  final Place place;

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();

  @override
  IconData get icon => LineIcons.users;

  @override
  String get title => "Mekan";
}

class _PlaceDetailsState extends State<PlaceDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OrganizationDescription(data: widget.place),
        if (widget.place.reviewAverage != null)
          Container(
            alignment: Alignment.center,
            child: Rating(
              rating: widget.place.reviewAverage!,
              ratingCount: null,
              size: 25,
            ),
          ),
        TagsWidget(tags: widget.place.tags),
        OrganizationAdmins(organization: widget.place),
        AdvertismentsWidget(),
        if (widget.place.location != null)
          LocationDetailWidget(marker: MapPlaceMarker(place: widget.place))
      ],
    );
  }
}
