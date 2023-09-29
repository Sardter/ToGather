import 'package:flutter/material.dart';
import 'package:ToGather/category/category.dart';
import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreatePlaceDescriptionData {
  final Category category;
  final String title;
  final String about;
  final ImageData? logo;
  final ImageData? banner;
  final List<LinkData> links;
  final List<String> tags;

  const CreatePlaceDescriptionData(
      {required this.category,
      required this.title,
      required this.about,
      required this.banner,
      required this.logo,
      required this.links,
      required this.tags});
}

class CreatePlaceDescriptionController
    extends BuilderSegmentController<CreatePlaceDescriptionData> {
  CreatePlaceDescriptionController(
      {required this.warningsController,
      this.initalLinks,
      this.initialAbout,
      this.initialTitle,
      this.initialBanner,
      this.initialLogo,
      this.initialSelectedCategory,
      this.intialTags});

  factory CreatePlaceDescriptionController.fromPlace(
      Place place, BuilderWarningsController warningsController) {
    return CreatePlaceDescriptionController(
        warningsController: warningsController,
        initalLinks: place.links,
        initialTitle: place.title,
        intialTags: place.tags);
  }

  final BuilderWarningsController warningsController;

  final String? initialTitle;
  final String? initialAbout;
  final List<LinkData>? initalLinks;
  final List<String>? intialTags;
  final Category? initialSelectedCategory;
  final ImageData? initialLogo;
  final ImageData? initialBanner;

  late final selectedCategory =
      ValueNotifier<Category?>(initialSelectedCategory);
  late final selectedLogo = ValueNotifier<ImageData?>(initialLogo);    
  late final selectedBanner = ValueNotifier<ImageData?>(initialBanner);    

  late final titleController = TextEditingController(text: initialTitle);
  late final aboutControlller = TextEditingController(text: initialAbout);
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
  CreatePlaceDescriptionData? get data => isValid
      ? CreatePlaceDescriptionData(
          category: selectedCategory.value!,
          title: titleController.text,
          about: aboutControlller.text,
          links: linksController.linksData,
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
