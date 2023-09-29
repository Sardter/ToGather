import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

import '../event.dart';

class EventDescription extends StatelessWidget {
  const EventDescription({
    super.key,
    required this.widget,
  });

  final EventWidget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: HighlightedText(text: widget.event.description!),
    );
  }
}
