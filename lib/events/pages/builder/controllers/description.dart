import 'package:flutter/material.dart';
import 'package:ToGather/category/category.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreateEventDescriptionData {
  final Category category;
  final Club? club;
  final String title;
  final String about;
  final bool isOnline;
  final bool isPrivate;
  final List<LinkData> links;
  final List<String> tags;

  const CreateEventDescriptionData(
      {required this.category,
      required this.club,
      required this.title,
      required this.about,
      required this.isOnline,
      required this.isPrivate,
      required this.links,
      required this.tags});
}

class CreateEventDescriptionController
    extends BuilderSegmentController<CreateEventDescriptionData> {
  CreateEventDescriptionController(
      {required this.warningsController,
      this.initalLinks,
      this.initialAbout,
      this.initialIsOnline,
      this.initialIsPrivate,
      this.initialTitle,
      this.initialSelectedCategory,
      this.initialSelectedClub,
      this.intialTags});

  factory CreateEventDescriptionController.fromEvent(
      Event event, BuilderWarningsController warningsController) {
    return CreateEventDescriptionController(
        warningsController: warningsController,
        initalLinks: event.links,
        initialAbout: event.description,
        initialIsOnline: event.isOnline,
        initialIsPrivate: event.isPrivate,
        initialTitle: event.title,
        intialTags: event.tags);
  }

  final BuilderWarningsController warningsController;

  final String? initialTitle;
  final String? initialAbout;
  final bool? initialIsOnline;
  final bool? initialIsPrivate;
  final List<LinkData>? initalLinks;
  final List<String>? intialTags;
  final Category? initialSelectedCategory;
  final Club? initialSelectedClub;

  late final selectedCategory =
      ValueNotifier<Category?>(initialSelectedCategory);
  late final selectedClub = ValueNotifier<Club?>(initialSelectedClub);

  late final titleController = TextEditingController(text: initialTitle);
  late final aboutControlller = TextEditingController(text: initialAbout);
  late final isOnlineCheckBoxController =
      SylvestCheckBoxController(toggled: initialIsOnline ?? false);
  late final isPrivateCheckBoxController =
      SylvestCheckBoxController(toggled: initialIsPrivate ?? false);
  late final tagsController = EditableTagsController(intialTags: intialTags);
  late final linksController = LinkBuilderController(
      warningsController: warningsController,
      links: initalLinks == null
          ? []
          : List.generate(
              initalLinks!.length,
              (index) => EditableLink.fromType(initalLinks![index].type, index,
                  url: initalLinks![index].url)));

  @override
  CreateEventDescriptionData? get data => isValid
      ? CreateEventDescriptionData(
          category: selectedCategory.value!,
          club: selectedClub.value,
          title: titleController.text,
          about: aboutControlller.text,
          isOnline: isOnlineCheckBoxController.toggled.value,
          isPrivate: isPrivateCheckBoxController.toggled.value,
          links: linksController.linksData,
          tags: tagsController.tags)
      : null;

  @override
  List<String> get errorMesseges => [
    if (selectedCategory.value == null) "Kategory boş kalamaz",
    if (titleController.text.isEmpty) "Başlık boş kalamaz",
  ];
}
