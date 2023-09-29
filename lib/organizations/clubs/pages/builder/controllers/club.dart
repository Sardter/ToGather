import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreateClubController extends BuilderPublisher<Club> {
  final CreateClubDescriptionController descriptionController;
  final BuilderLocationController locationController;
  final BuilderWarningsController warningsController;
  final ModelService<Club> modelService;
  final ItemParameters? itemParameters;
  final bool isUpdating;

  CreateClubController(
      {required this.descriptionController,
      required this.warningsController,
      required this.modelService,
      required this.isUpdating,
      required this.itemParameters,
      required this.locationController});

  factory CreateClubController.fromClub(
      Club club, ModelService<Club> modelService) {
    final warningsController = BuilderWarningsController();
    return CreateClubController(
        warningsController: warningsController,
        modelService: modelService,
        itemParameters: ItemParameters(id: club.id),
        isUpdating: true,
        descriptionController:
            CreateClubDescriptionController.fromClub(club, warningsController),
        locationController: BuilderLocationController.fromLocationModel(club));
  }

  factory CreateClubController.newClub(ModelService<Club> modelService) {
    final warningsController = BuilderWarningsController();
    return CreateClubController(
        modelService: modelService,
        itemParameters: null,
        isUpdating: false,
        warningsController: warningsController,
        descriptionController: CreateClubDescriptionController(
            warningsController: warningsController),
        locationController: BuilderLocationController());
  }

  Club get club => Club(
      id: 0,
      title: descriptionController.titleController.text,
      about: descriptionController.aboutControlller.text,
      image: descriptionController.selectedLogo.value,
      reviewAverage: 0,
      postPolicy: descriptionController.postPolicyController.toggled.value,
      ratingCount: 0,
      banner: descriptionController.selectedBanner.value,
      events: 0,
      verified: false,
      locationDescription: locationController.locationDescription.text,
      links: descriptionController.linksController.linksData,
      eventAttends: 0,
      posts: 0,
      tags: descriptionController.tagsController.tags,
      members: 0,
      category: descriptionController.selectedCategory.value!,
      requestData: ClubRequestData(
          allowedActions: ClubAllowedActions(
              canUpdate: false,
              canDelete: false,
              canHide: false,
              canReport: false,
              canJoin: false,
              canEdit: false,
              canModerate: false,
              canPost: false,
              canEvent: false),
          isJoined: false),
      location: locationController.selectedLocation);

  @override
  Club? get data => isValid ? club : null;

  @override
  List<String> get errorMesseges => [
        ...descriptionController.errorMesseges,
        ...locationController.errorMesseges,
      ];

  @override
  List<MediaData?> get media => [
    descriptionController.selectedLogo.value,
    descriptionController.selectedBanner.value
  ];
}
