import 'package:flutter/material.dart';
import 'package:ToGather/events/widgets/event.dart';

import 'time.dart';

class EventTimeWidget extends StatelessWidget {
  const EventTimeWidget({
    super.key,
    required this.widget,
  });

  final EventWidget widget;

  @override
  Widget build(BuildContext context) {
    return EventTime(
        date: widget.event.startDate,
        duration: widget.event.endDate.difference(widget.event.startDate));
  }
}