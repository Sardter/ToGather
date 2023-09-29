import 'package:ToGather/users/users.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/utilities/utilities.dart';

export 'segments/segments.dart';
export 'controllers/controllers.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key, required this.controller});
  final CreateEventController controller;

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  List<CreatePageSegment> _segments(Profile user) => <CreatePageSegment>[
        CreateEventDescriptionSegment(
          user: user,
          descriptionController: widget.controller.descriptionController,
        ),
        BuilderMediaSegment(mediaController: widget.controller.mediaController),
        CreateEventDateSegment(
            dateController: widget.controller.dateController),
        BuilderLocationSegment(
            locationController: widget.controller.locationController),
        BuilderFormSegment(formController: widget.controller.formController)
      ];

  @override
  Widget build(BuildContext context) {
    return CreateModelPage<Event>(
        pageTitle: "Etkinlik Oluştur",
        controller: widget.controller,
        detailPage: (item) => EventPage(id: item.id),
        segments: _segments,
        warningsController: widget.controller.warningsController,
        buttonChildren: const [
          Icon(
            Icons.share,
            color: ThemeService.onContrastColor,
          ),
          SizedBox(width: 10),
          Text(
            "Etkinliği Paylaş",
            style: TextStyle(color: ThemeService.onContrastColor),
          )
        ]);
  }
}
