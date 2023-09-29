import 'package:ToGather/events/filters/query_params.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/users/users.dart';

class UserEvents extends StatefulWidget implements PageData {
  const UserEvents({super.key, required this.profile});
  final Profile profile;

  @override
  State<UserEvents> createState() => _UserEventsState();

  @override
  IconData get icon => LineIcons.calendar;

  @override
  String get title => "Etkinlikler";
}

class _UserEventsState extends State<UserEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizantalItemNavigator<Event>(
            modelService: ModelServiceFactory.EVENT,
            label: "Düzenlediği etkinlikler",
            queryParameters: EventQueryParameters(
              host: widget.profile
            ),
            mapper: (event) => SearchEvent(event: event)),
        HorizantalItemNavigator<Event>(
            modelService: ModelServiceFactory.EVENT,
            queryParameters: EventQueryParameters(
              attendee: widget.profile
            ),
            label: "Katılınan etkinlilkler",
            mapper: (event) => SearchEvent(event: event)),
      ],
    );
  }
}
