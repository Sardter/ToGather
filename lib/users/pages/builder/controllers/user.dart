import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreateProfileController extends BuilderPublisher<Profile> {
  final CreateProfileDescriptionController descriptionController;
  final BuilderMediaController<ImageData> mediaController;
  final BuilderWarningsController warningsController;
  final ProfileModelService modelService;
  final bool isUpdating;
  final ItemParameters? itemParameters;

  @override
  List<MediaData> get media => mediaController.selectedMedia;

  CreateProfileController({
    required this.descriptionController,
    required this.mediaController,
    required this.warningsController,
    required this.isUpdating,
    required this.itemParameters,
    required this.modelService,
  });

  factory CreateProfileController.fromProfile(
      Profile profile, ProfileModelService modelService) {
    final warningsController = BuilderWarningsController();
    return CreateProfileController(
        warningsController: warningsController,
        modelService: modelService,
        itemParameters: ItemParameters(id: profile.id),
        isUpdating: true,
        descriptionController: CreateProfileDescriptionController.fromProfile(
            profile, warningsController),
        mediaController: BuilderMediaController.fromProfile(profile));
  }

  Profile get profile {
    return Profile(
        id: -1,
        about: descriptionController.aboutControlller.text,
        posts: 0,
        educationData: descriptionController.selectedEducationData.value,
        locationDescription: null,
        requestData: ProfileRequestData(
            connectionStatus: ConnectionStatus.Me,
            isBlocked: false,
            isBlockedBy: false,
            allowedActions: ProfileAllowedActions(
                canUpdate: false,
                canDelete: false,
                canHide: false,
                canBlock: false,
                canConnect: false,
                canReport: false)),
        username: descriptionController.usernameController.text,
        location: null,
        reviewAverage: 0,
        verified: false,
        connections: 0,
        birth: descriptionController.birthController.date,
        firstName: descriptionController.firstnameControlller.text,
        email: descriptionController.emailControlller.text,
        links: descriptionController.linksController.linksData,
        interestes: descriptionController.selectedCategories.value,
        isPrivate:
            descriptionController.isPrivateCheckBoxController.toggled.value,
        images: mediaController.data ?? [],
        lastName: descriptionController.lastnameControlller.text,
        gender: descriptionController.selectedGender.value);
  }

  @override
  Profile? get data => isValid ? profile : null;

  @override
  List<String> get errorMesseges => [
        ...descriptionController.errorMesseges,
        ...mediaController.errorMesseges,
      ];

  Future<Profile?> update() async {
    if (errorMesseges.isNotEmpty) {
      if (warningsController.onError != null)
        errorMesseges.forEach((e) => warningsController.onError!(e));

      return null;
    }

    return modelService.updateCurrentUser(updatedItem: data!);
  }
}
