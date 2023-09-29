import 'package:ToGather/events/events.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreateEventController extends BuilderPublisher<Event> {
  final CreateEventDescriptionController descriptionController;
  final BuilderDateController dateController;
  final BuilderFormController formController;
  final BuilderMediaController mediaController;
  final BuilderLocationController locationController;
  final BuilderWarningsController warningsController;
  final ModelService<Event> modelService;
  final ItemParameters? itemParameters;
  final bool isUpdating;

  CreateEventController(
      {required this.descriptionController,
      required this.dateController,
      required this.formController,
      required this.mediaController,
      required this.modelService,
      required this.isUpdating,
      required this.itemParameters,
      required this.warningsController,
      required this.locationController});

  factory CreateEventController.fromEvent(
      Event event, ModelService<Event> modelService) {
    final warningsController = BuilderWarningsController();
    return CreateEventController(
        warningsController: warningsController,
        modelService: modelService,
        isUpdating: true,
        itemParameters: ItemParameters(id: event.id),
        descriptionController: CreateEventDescriptionController.fromEvent(
            event, warningsController),
        dateController: BuilderDateController.fromEvent(event),
        formController:
            BuilderFormController.fromEvent(event, warningsController),
        mediaController: BuilderMediaController.fromEvent(event),
        locationController: BuilderLocationController.fromLocationModel(event));
  }

  factory CreateEventController.newEvent(ModelService<Event> modelService) {
    final warningsController = BuilderWarningsController();
    return CreateEventController(
        warningsController: warningsController,
        modelService: modelService,
        itemParameters: null,
        isUpdating: false,
        descriptionController: CreateEventDescriptionController(
            warningsController: warningsController),
        dateController: BuilderDateController(),
        formController:
            BuilderFormController(warningsController: warningsController),
        mediaController: BuilderMediaController(),
        locationController: BuilderLocationController());
  }

  Event get event {
    return Event(
        id: -1,
        ratingCount: 12,
        location: locationController.selectedLocation,
        description: descriptionController.aboutControlller.text,
        links: descriptionController.linksController.linksData,
        requestData: EventRequestData(
            isAttending: false,
            userRate: null,
            allowedActions: EventAllowedActions(
                canUpdate: false,
                canDelete: false,
                canAttend: false,
                canPost: false,
                canRate: false,
                canForm: false,
                canHide: false,
                canReport: false),
            isHosting: false),
        tags: descriptionController.tagsController.tags,
        reviewsAverage: 0,
        startDate: dateController.startDateController.date!,
        formData:
            formController.data?.map((e) => e.getBlockData).toList() ?? [],
        isOnline:
            descriptionController.isOnlineCheckBoxController.toggled.value,
        isPrivate:
            descriptionController.isPrivateCheckBoxController.toggled.value,
        media: mediaController.selectedMedia,
        locationDescription: locationController.locationDescription.text,
        attendees: 0,
        host: null,
        title: descriptionController.titleController.text,
        endDate: dateController.endDateController.date!,
        category: descriptionController.selectedCategory.value!,
        verified: false);
  }

  @override
  Event? get data => isValid ? event : null;

  @override
  List<String> get errorMesseges => [
        ...descriptionController.errorMesseges,
        ...dateController.errorMesseges,
        ...locationController.errorMesseges,
        ...mediaController.errorMesseges,
        ...formController.errorMesseges
      ];

  @override
  List<MediaData> get media => mediaController.selectedMedia;
}
