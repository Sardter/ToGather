import 'package:flutter/material.dart';
import 'package:ToGather/category/category.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreateClubDescriptionData {
  final Category category;
  final String title;
  final String about;
  final ImageData? logo;
  final ImageData? banner;
  final List<LinkData> links;
  final List<String> tags;
  final bool postPolicy;

  const CreateClubDescriptionData(
      {required this.category,
      required this.title,
      required this.about,
      required this.banner,
      required this.postPolicy,
      required this.logo,
      required this.links,
      required this.tags});
}

class CreateClubDescriptionController
    extends BuilderSegmentController<CreateClubDescriptionData> {
  CreateClubDescriptionController(
      {required this.warningsController,
      this.initalLinks,
      this.initialAbout,
      this.initialTitle,
      this.initialPostPolicy,
      this.initialBanner,
      this.initialLogo,
      this.initialSelectedCategory,
      this.intialTags});

  factory CreateClubDescriptionController.fromClub(
      Club club, BuilderWarningsController warningsController) {
    return CreateClubDescriptionController(
        warningsController: warningsController,
        initalLinks: club.links,
        initialTitle: club.title,
        intialTags: club.tags);
  }

  final BuilderWarningsController warningsController;

  final String? initialTitle;
  final String? initialAbout;
  final List<LinkData>? initalLinks;
  final List<String>? intialTags;
  final Category? initialSelectedCategory;
  final ImageData? initialLogo;
  final ImageData? initialBanner;
  final bool? initialPostPolicy;

  late final selectedCategory =
      ValueNotifier<Category?>(initialSelectedCategory);
  late final selectedLogo = ValueNotifier<ImageData?>(initialLogo);    
  late final selectedBanner = ValueNotifier<ImageData?>(initialBanner);    

  late final titleController = TextEditingController(text: initialTitle);
  late final aboutControlller = TextEditingController(text: initialAbout);
  late final tagsController = EditableTagsController(intialTags: intialTags);
  late final postPolicyController = SylvestCheckBoxController(toggled: initialPostPolicy ?? false);
  late final linksController = LinkBuilderController(
      warningsController: warningsController,
      links: initalLinks == null
          ? []
          : List.generate(
              initalLinks!.length,
              (index) => EditableLink.fromType(initalLinks![index].type, index,
                  url: initalLinks![index].url)));

  @override
  CreateClubDescriptionData? get data => isValid
      ? CreateClubDescriptionData(
          category: selectedCategory.value!,
          title: titleController.text,
          about: aboutControlller.text,
          links: linksController.linksData,
          postPolicy: postPolicyController.toggled.value,
          logo: selectedLogo.value,
          banner: selectedBanner.value,
          tags: tagsController.tags)
      : null;

  @override
  List<String> get errorMesseges => [
    if (selectedCategory.value == null) "Kategory boş kalamaz",
    if (titleController.text.isEmpty) "Başlık boş kalamaz",
  ];
}
