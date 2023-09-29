import 'package:flutter/material.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/utilities/utilities.dart';

class EventMediaWidget extends StatefulWidget {
  const EventMediaWidget({super.key, required this.event});
  final Event event;

  @override
  State<EventMediaWidget> createState() => _EventMediaWidgetState();
}

class _EventMediaWidgetState extends State<EventMediaWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 100,
      child: SylvestMediaCarousal(media: widget.event.media),
    );
  }
}
