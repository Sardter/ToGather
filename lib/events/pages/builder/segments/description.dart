import 'package:flutter/material.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreateEventDescriptionSegment extends StatefulWidget
    implements CreatePageSegment {
  const CreateEventDescriptionSegment(
      {super.key, required this.descriptionController, required this.user});
  final CreateEventDescriptionController descriptionController;
  final Profile user;

  @override
  State<CreateEventDescriptionSegment> createState() =>
      _CreateEventDescriptionSegmentState();

  @override
  IconData get icon => Icons.article;

  @override
  String get label => "Detaylar";
}

class _CreateEventDescriptionSegmentState
    extends State<CreateEventDescriptionSegment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          RoundedTextField(
              type: TextInputType.text,
              controller: widget.descriptionController.titleController,
              hint: "Başlık"),
          const SizedBox(height: 15),
          RoundedTextField(
            type: TextInputType.multiline,
            controller: widget.descriptionController.aboutControlller,
            hint: "Hakkında",
            isMultiLine: true,
            minLines: 10,
          ),
          const SizedBox(height: 15),
          BuilderSelectedCategory(
              notifier: widget.descriptionController.selectedCategory),
          const SizedBox(height: 15),
          BuilderSelectedClub(
              state: BuilderSelectedClubState.Event,
              user: widget.user,
              notifier: widget.descriptionController.selectedClub),
          const SizedBox(height: 15),
          SylvestCheckBox(
              children: [
                Icon(Icons.computer),
                const SizedBox(width: 10),
                Text("Online")
              ],
              controller:
                  widget.descriptionController.isOnlineCheckBoxController),
          const SizedBox(height: 15),
          SylvestCheckBox(
              children: [
                Icon(Icons.people),
                const SizedBox(width: 10),
                Text("Arkadaşlara Özel")
              ],
              controller:
                  widget.descriptionController.isPrivateCheckBoxController),
          EdittableTags(
              controller: widget.descriptionController.tagsController,
              showTitle: false),
          LinkBuilder(controller: widget.descriptionController.linksController)
        ],
      ),
    );
  }
}
