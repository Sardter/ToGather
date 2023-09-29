import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/category/category.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreateProfileDescriptionData {
  final String username;
  final String about;
  final String firstName;
  final String lastName;
  final String email;
  final String? gender;
  final University? educationData;
  final List<LinkData> links;
  final List<Category> categories;
  final bool isPrivate;
  final DateTime? birth;

  const CreateProfileDescriptionData(
      {required this.categories,
      required this.username,
      required this.email,
      required this.birth,
      required this.firstName,
      required this.gender,
      required this.about,
      required this.lastName,
      required this.isPrivate,
      required this.educationData,
      required this.links});
}

class CreateProfileDescriptionController
    extends BuilderSegmentController<CreateProfileDescriptionData> {
  CreateProfileDescriptionController(
      {required this.warningsController,
      this.initialEducationData,
      this.initialAbout,
      this.initialIsPrivate,
      this.initialUsername,
      this.initialFirstName,
      this.initialCategories,
      this.initialEmail,
      this.initialBirth,
      this.initialGender,
      this.initialLastName,
      this.initialLinks});

  factory CreateProfileDescriptionController.fromProfile(
      Profile profile, BuilderWarningsController warningsController) {
    return CreateProfileDescriptionController(
        warningsController: warningsController,
        initialLinks: profile.links,
        initialAbout: profile.about,
        initialUsername: profile.username,
        initialIsPrivate: profile.isPrivate,
        initialFirstName: profile.firstName,
        initialEducationData: profile.educationData,
        initialLastName: profile.lastName);
  }

  final BuilderWarningsController warningsController;

  final String? initialUsername;
  final String? initialAbout;
  final String? initialFirstName;
  final String? initialLastName;
  final String? initialEmail;
  final bool? initialIsPrivate;
  final University? initialEducationData;
  final List<LinkData>? initialLinks;
  final List<Category>? initialCategories;
  final DateTime? initialBirth;
  final String? initialGender;

  late final usernameController = TextEditingController(text: initialUsername);
  late final aboutControlller = TextEditingController(text: initialAbout);
  late final firstnameControlller = TextEditingController(text: initialFirstName);
  late final lastnameControlller = TextEditingController(text: initialLastName);
  late final emailControlller = TextEditingController(text: initialEmail);
  late final isPrivateCheckBoxController =
      SylvestCheckBoxController(toggled: initialIsPrivate ?? false);
  late final selectedEducationData = ValueNotifier<University?>(initialEducationData);
  late final linksController = LinkBuilderController(
      warningsController: warningsController,
      links: initialLinks == null
          ? []
          : List.generate(
              initialLinks!.length,
              (index) => EditableLink.fromType(initialLinks![index].type, index,
                  url: initialLinks![index].url)));
  late final selectedCategories = ValueNotifier<List<Category>>(initialCategories ?? []);
  late final birthController = DatePickerController(date: initialBirth);
  late final selectedGender = ValueNotifier<String?>(initialGender);

  @override
  CreateProfileDescriptionData? get data => isValid
      ? CreateProfileDescriptionData(
          username: usernameController.text,
          firstName: firstnameControlller.text,
          lastName: lastnameControlller.text,
          about: aboutControlller.text,
          isPrivate: isPrivateCheckBoxController.toggled.value,
          links: linksController.linksData,
          categories: selectedCategories.value,
          email: emailControlller.text,
          birth: birthController.date,
          gender: selectedGender.value,
          educationData: selectedEducationData.value
          )
      : null;

  @override
  List<String> get errorMesseges => [
    if (usernameController.text.isEmpty) "Başlık boş kalamaz",
    if (firstnameControlller.text.isEmpty) "İsim boş kalamaz",
    if (lastnameControlller.text.isEmpty) "Soy isim boş kalamaz",
    if (EmailValidator.validate(emailControlller.text)) "Email doğru formatta değil",
  ];
}