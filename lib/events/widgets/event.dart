import 'package:flutter/material.dart';
import 'package:ToGather/events/pages/event_page.dart';
import 'package:ToGather/events/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';

import 'components/componets.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({Key? key, required this.event, this.isFullScreen = true})
      : super(key: key);
  final Event event;
  final bool isFullScreen;

  @override
  EventWidgetState createState() => EventWidgetState();
}

class EventWidgetState extends State<EventWidget> {
  Column _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.event.media.isNotEmpty)
          EventMediaWidget(event: widget.event),
        EventHeader(event: widget.event),
        const SizedBox(height: 10),
        //_location(),
        EventContent(widget: widget),

        EventButtons(event: widget.event)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isFullScreen) return;
        launchPage(context, EventPage(id: widget.event.id));
      },
      child: FutureBuilder<bool>(
          // future: APIService().isHidden('event', widget.event.id),
          builder: (c, s) {
        if (s.hasData && s.data!) {
          return HiddenItem(type: 'event', id: widget.event.id);
        }
        return _body();
      }),
    );
  }
}
