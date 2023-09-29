import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/modals/modals.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/organizations/models/organization.dart';
import 'package:ToGather/utilities/utilities.dart';

class OrganizationStats extends StatelessWidget {
  const OrganizationStats({
    super.key,
    required this.context,
    required Organization data,
    required ModelService<Event> eventManager,
    required this.hasMedia,
  })  : _data = data,
        _eventManager = eventManager;

  final BuildContext context;
  final Organization _data;
  final ModelService<Event> _eventManager;
  final bool hasMedia;

  @override
  Widget build(BuildContext context) {
    return Stats(items: [
      if (_data is Club)
        StatsItem(
            icon: LineIcons.user,
            name: "Üye",
            hasMedia: hasMedia,
            count: (_data as Club).members,
            onTap: () async =>
                launchModal(context, ClubMembersPage(club: (_data as Club)))),
      StatsItem(
          icon: LineIcons.calendar,
          name: "Etkinlik",
          count: _data.events,
          hasMedia: hasMedia,
          onTap: () async => launchModal(
                context,
                FilteredPage<Event>(
                  manager: _eventManager,
                  mapper: (post) => SearchEvent(
                    event: post,
                  ),
                  mode: FilteredPageMode.Modal,
                ),
              )),
      StatsItem(
          icon: LineIcons.star,
          name: "Katılım",
          hasMedia: hasMedia,
          count: _data.eventAttends,
          onTap: () {}),
    ]);
  }
}
