import 'package:flutter/material.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/events/widgets/event.dart';
import 'package:ToGather/utilities/utilities.dart';

import 'componets.dart';

class EventContent extends StatelessWidget {
  const EventContent({
    super.key,
    required this.widget,
  });

  final EventWidget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          EventDescription(widget: widget),
          TagsWidget(tags: widget.event.tags),
          Attendees(event: widget.event),
          EventTimeWidget(widget: widget),
          if (widget.event.location != null)
            LocationDetailWidget(marker: MapEventMarker.fromEvent(widget.event)),
          EventHostWidget(event: widget.event),
        ],
      ),
    );
  }
}
