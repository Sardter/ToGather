import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/events/events.dart';

class PlaceEvents extends StatefulWidget implements PageData {
  const PlaceEvents({super.key, required this.club});
  final Club club;

  @override
  State<PlaceEvents> createState() => _PlaceEventsState();

  @override
  IconData get icon => LineIcons.calendar;

  @override
  String get title => "Etkinlikler";
}

class _PlaceEventsState extends State<PlaceEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizantalItemNavigator<Event>(
            modelService: ModelServiceFactory.EVENT,
            label: "Yeni Etkinlikler",
            mapper: (event) => SearchEvent(event: event)),
        HorizantalItemNavigator<Event>(
            modelService: ModelServiceFactory.EVENT,
            label: "Popüler Etkinlikler",
            mapper: (event) => SearchEvent(event: event)),
        HorizantalItemNavigator<Event>(
            modelService: ModelServiceFactory.EVENT,
            label: "En Çok Sevilen Etkinlikler",
            mapper: (event) => SearchEvent(event: event)),
      ],
    );
  }
}
