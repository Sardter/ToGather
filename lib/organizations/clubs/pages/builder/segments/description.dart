import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreateClubDescriptionSegment extends StatefulWidget
    implements CreatePageSegment {
  const CreateClubDescriptionSegment(
      {super.key, required this.descriptionController});
  final CreateClubDescriptionController descriptionController;

  @override
  State<CreateClubDescriptionSegment> createState() =>
      _CreateClubDescriptionSegmentState();

  @override
  IconData get icon => Icons.article;

  @override
  String get label => "Detaylar";
}

class _CreateClubDescriptionSegmentState
    extends State<CreateClubDescriptionSegment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          SelectedBanner(
              notifier: widget.descriptionController.selectedBanner,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, color: ThemeService.unusedColor),
                  SizedBox(width: 10),
                  Text(
                    "Kapak",
                    style: TextStyle(color: ThemeService.unusedColor),
                  )
                ],
              )),
          const SizedBox(height: 15),
          SelectedLogo(
              notifier: widget.descriptionController.selectedLogo,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.image, color: ThemeService.unusedColor),
                  SizedBox(width: 10),
                  Text(
                    "Logo",
                    style: TextStyle(color: ThemeService.unusedColor),
                  )
                ],
              )),
          const SizedBox(height: 15),
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
          SylvestCheckBox(children: const [
            Icon(Icons.post_add),
            SizedBox(width: 10),
            Text("Üyeler gönderi paylaşabilir")
          ], controller: widget.descriptionController.postPolicyController),
          const SizedBox(height: 15),
          EdittableTags(
              controller: widget.descriptionController.tagsController,
              showTitle: false),
          LinkBuilder(controller: widget.descriptionController.linksController)
        ],
      ),
    );
  }
}
