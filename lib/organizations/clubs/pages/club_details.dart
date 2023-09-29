import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/events/widgets/components/componets.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';

class ClubDetails extends StatefulWidget implements PageData {
  const ClubDetails({super.key, required this.club});
  final Club club;

  @override
  State<ClubDetails> createState() => _ClubDetailsState();

  @override
  IconData get icon => LineIcons.users;

  @override
  String get title => "Topluluk";
}

class _ClubDetailsState extends State<ClubDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OrganizationDescription(data: widget.club),
        if (widget.club.reviewAverage != null)
          Container(
            alignment: Alignment.center,
            child: Rating(
              rating: widget.club.reviewAverage!,
              ratingCount: null,
              size: 25,
            ),
          ),
        TagsWidget(tags: widget.club.tags),
        OrganizationAdmins(organization: widget.club),
        FutureBuilder<Profile?>(
          future: ModelServiceFactory.PROFILE
              .getCurrentUser(context, launchLogin: false),
          builder: (context, snapshot) => ClubMembers(
            club: widget.club,
            me: snapshot.data,
          ),
        ),
        if (widget.club.location != null)
          LocationDetailWidget(marker: MapClubMarker.fromClub(widget.club)),
      ],
    );
  }
}
