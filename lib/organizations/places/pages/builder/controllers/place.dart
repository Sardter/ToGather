import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreatePlaceController extends BuilderPublisher<Place> {
  final CreatePlaceDescriptionController descriptionController;
  final BuilderLocationController locationController;
  final BuilderWarningsController warningsController;
  final ModelService<Place> modelService;
  final bool isUpdating;
  final ItemParameters? itemParameters;

  CreatePlaceController(
      {required this.descriptionController,
      required this.warningsController,
      required this.isUpdating,
      required this.modelService,
      required this.itemParameters,
      required this.locationController});

  factory CreatePlaceController.fromPlace(Place club, ModelService<Place> modelService) {
    final warningsController = BuilderWarningsController();
    return CreatePlaceController(
        warningsController: warningsController,
        itemParameters: ItemParameters(id: club.id),
        modelService: modelService,
        isUpdating: true,
        descriptionController:
            CreatePlaceDescriptionController.fromPlace(club, warningsController),
        locationController: BuilderLocationController.fromLocationModel(club));
  }

  factory CreatePlaceController.newPlace(ModelService<Place> modelService) {
    final warningsController = BuilderWarningsController();
    return CreatePlaceController(
        warningsController: warningsController,
        modelService: modelService,
        itemParameters: null,
        isUpdating: false,
        descriptionController: CreatePlaceDescriptionController(
            warningsController: warningsController),
        locationController: BuilderLocationController());
  }

  Place get place => Place(
      id: 0,
      title: descriptionController.titleController.text,
      about: descriptionController.aboutControlller.text,
      image: descriptionController.selectedLogo.value,
      ratingCount: 0,
      reviewAverage: 0,
      banner: descriptionController.selectedBanner.value,
      events: 0,
      verified: false,
      locationDescription: locationController.locationDescription.text,
      links: descriptionController.linksController.linksData,
      eventAttends: 0,
      posts: 0,
      tags: descriptionController.tagsController.tags,
      category: descriptionController.selectedCategory.value!,
      requestData: PlaceRequestData(
          allowedActions: PlaceAllowedActions(
              canUpdate: false,
              canDelete: false,
              canHide: false,
              canReport: false,
              canPost: false)),
      location: locationController.selectedLocation);

  @override
  Place? get data => isValid ? place : null;

  @override
  List<String> get errorMesseges => [
        ...descriptionController.errorMesseges,
        ...locationController.errorMesseges,
      ];

  Future<Place?> publish() async {
    if (errorMesseges.isNotEmpty) {
      if (warningsController.onError != null)
        errorMesseges.forEach((e) => warningsController.onError!(e));

      return null;
    }
    
    return ModelServiceFactory.PLACE.postItem(item: place);
  }

  @override
  List<MediaData?> get media => [
    descriptionController.selectedLogo.value,
    descriptionController.selectedBanner.value
  ];
}
