import 'package:flutter/material.dart';
import 'package:ToGather/users/pages/builder/widgets/selected_categories.dart';
import 'package:ToGather/users/pages/builder/widgets/selected_gender.dart';
import 'package:ToGather/users/pages/builder/widgets/selected_university.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreateProfileDescriptionSegment extends StatefulWidget
    implements CreatePageSegment {
  const CreateProfileDescriptionSegment(
      {super.key, required this.descriptionController});
  final CreateProfileDescriptionController descriptionController;

  @override
  State<CreateProfileDescriptionSegment> createState() =>
      _CreateProfileDescriptionSegmentState();

  @override
  IconData get icon => Icons.article;

  @override
  String get label => "Detaylar";
}

class _CreateProfileDescriptionSegmentState
    extends State<CreateProfileDescriptionSegment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          RoundedTextField(
              type: TextInputType.text,
              controller: widget.descriptionController.usernameController,
              hint: "Kullanıcı Adı"),
          const SizedBox(height: 15),
          RoundedTextField(
              type: TextInputType.emailAddress,
              controller: widget.descriptionController.emailControlller,
              hint: "Email"),
          const SizedBox(height: 15),
          RoundedTextField(
              type: TextInputType.text,
              controller: widget.descriptionController.firstnameControlller,
              hint: "İsim"),
          const SizedBox(height: 15),
          RoundedTextField(
              type: TextInputType.text,
              controller: widget.descriptionController.lastnameControlller,
              hint: "Soy İsim"),
          const SizedBox(height: 15),
          RoundedTextField(
            type: TextInputType.multiline,
            controller: widget.descriptionController.aboutControlller,
            hint: "Hakkında",
            isMultiLine: true,
            minLines: 10,
          ),
          const SizedBox(height: 15),
          SelectedCategories(selectedCategories: widget.descriptionController.selectedCategories),
          const SizedBox(height: 15),
          SelectedGender(gender: widget.descriptionController.selectedGender),
          const SizedBox(height: 15),
          SelectedUniversity(notifier: widget.descriptionController.selectedEducationData),
          const SizedBox(height: 15),
          SylvestCheckBox(
              children: [
                Icon(Icons.people),
                const SizedBox(width: 10),
                Text("Gizli Profil")
              ],
              controller:
                  widget.descriptionController.isPrivateCheckBoxController),
          const SizedBox(height: 15),
          LinkBuilder(controller: widget.descriptionController.linksController)
        ],
      ),
    );
  }
}
