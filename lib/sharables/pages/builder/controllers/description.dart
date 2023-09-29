import 'package:ToGather/events/events.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/sharables/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreatePostDescriptionData {
  final Club? club;
  final String title;
  final String text;
  final bool isPrivate;
  final bool isAnonymous;
  final Event? event;
  final List<String> tags;

  const CreatePostDescriptionData(
      {required this.text,
      required this.club,
      required this.title,
      required this.isAnonymous,
      required this.event,
      required this.isPrivate,
      required this.tags});
}

class CreatePostDescriptionController
    extends BuilderSegmentController<CreatePostDescriptionData> {
  CreatePostDescriptionController(
      {required this.warningsController,
      this.initialText,
      this.initialTitle,
      this.initialSelectedClub,
      this.initialIsPrivate,
      this.initialIsAnonymous,
      this.initialSelectedEvent,
      this.intialTags});

  factory CreatePostDescriptionController.fromPost(
      Post post, BuilderWarningsController warningsController) {
    return CreatePostDescriptionController(
        warningsController: warningsController,
        initialTitle: post.title,
        initialText: post.content,
        initialIsAnonymous: post.isAnonymous,
        initialIsPrivate: post.isPrivate,
        initialSelectedClub: post.club,
        initialSelectedEvent: post.event,
        intialTags: post.tags);
  }

  final BuilderWarningsController warningsController;

  final String? initialTitle;
  final String? initialText;
  final List<String>? intialTags;
  final bool? initialIsPrivate;
  final bool? initialIsAnonymous;
  final Event? initialSelectedEvent;
  final Club? initialSelectedClub;

  late final selectedClub = ValueNotifier<Club?>(initialSelectedClub);
  late final selectedEvent = ValueNotifier<Event?>(initialSelectedEvent);

  late final titleController = TextEditingController(text: initialTitle);
  late final contentControlller = TextEditingController(text: initialText);
  late final isPrivateCheckBoxController =
      SylvestCheckBoxController(toggled: initialIsPrivate ?? false);
      late final isAonymousCheckBoxController =
      SylvestCheckBoxController(toggled: initialIsAnonymous ?? false);
  late final tagsController = EditableTagsController(intialTags: intialTags);

  @override
  CreatePostDescriptionData? get data => isValid
      ? CreatePostDescriptionData(
          club: selectedClub.value,
          title: titleController.text,
          text: contentControlller.text,
          event: selectedEvent.value,
          isAnonymous: isAonymousCheckBoxController.toggled.value,
          isPrivate: isPrivateCheckBoxController.toggled.value,
          tags: tagsController.tags)
      : null;

  @override
  List<String> get errorMesseges => [
    if (titleController.text.isEmpty) "Başlık boş kalamaz",
  ];
}