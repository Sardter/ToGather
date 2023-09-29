import 'package:ToGather/events/filters/query_params.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/organizations/models/organization.dart';

class OrganizationEvents extends StatefulWidget implements PageData {
  const OrganizationEvents({super.key, required this.club});
  final Organization club;

  @override
  State<OrganizationEvents> createState() => _OrganizationEventsState();

  @override
  IconData get icon => LineIcons.calendar;

  @override
  String get title => "Etkinlikler";
}

class _OrganizationEventsState extends State<OrganizationEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizantalItemNavigator<Event>(
            modelService: ModelServiceFactory.EVENT,
            label: "Yeni Etkinlikler",
            queryParameters: EventQueryParameters(club: widget.club as Club),
            mapper: (event) => SearchEvent(event: event)),
        HorizantalItemNavigator<Event>(
            modelService: ModelServiceFactory.EVENT,
            label: "Popüler Etkinlikler",
            queryParameters:
                EventQueryParameters(trend: true, club: widget.club as Club),
            mapper: (event) => SearchEvent(event: event)),
      ],
    );
  }
}
