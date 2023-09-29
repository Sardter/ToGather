import 'package:ToGather/events/models/models.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreatePostController extends BuilderPublisher<Post> {
  final CreatePostDescriptionController descriptionController;
  final BuilderMediaController mediaController;
  final BuilderLocationController locationController;
  final BuilderWarningsController warningsController;
  final ModelService<Post> modelService;
  final ItemParameters? itemParameters;
  final bool isUpdating;

  CreatePostController(
      {required this.descriptionController,
      required this.mediaController,
      required this.modelService,
      required this.isUpdating,
      required this.itemParameters,
      required this.warningsController,
      required this.locationController});

  factory CreatePostController.fromPost(
      Post post, ModelService<Post> modelService) {
    final warningsController = BuilderWarningsController();
    return CreatePostController(
        warningsController: warningsController,
        modelService: modelService,
        isUpdating: true,
        itemParameters: ItemParameters(id: post.id),
        descriptionController:
            CreatePostDescriptionController.fromPost(post, warningsController),
        mediaController: BuilderMediaController.fromPost(post),
        locationController: BuilderLocationController.fromLocationModel(post));
  }

  factory CreatePostController.newPost(ModelService<Post> modelService,
      {Event? initialSelectedEvent}) {
    final warningsController = BuilderWarningsController();
    return CreatePostController(
        warningsController: warningsController,
        modelService: modelService,
        itemParameters: null,
        isUpdating: false,
        descriptionController: CreatePostDescriptionController(
            initialSelectedEvent: initialSelectedEvent,
            warningsController: warningsController),
        mediaController: BuilderMediaController(),
        locationController: BuilderLocationController());
  }

  Post get post {
    return Post(
        media: mediaController.selectedMedia,
        content: descriptionController.contentControlller.text,
        club: descriptionController.selectedClub.value,
        event: descriptionController.selectedEvent.value,
        requestData: null,
        id: -1,
        title: descriptionController.titleController.text,
        locationDescription: locationController.locationDescription.text,
        commentCount: 0,
        datePosted: DateTime.now(),
        isPrivate:
            descriptionController.isPrivateCheckBoxController.toggled.value,
        tags: descriptionController.tagsController.tags,
        location: locationController.selectedLocation,
        isAnonymous:
            descriptionController.isAonymousCheckBoxController.toggled.value,
        ratingAverage: 0,
        author: PostAnonymousAuthor(),
        rateCount: 0);
  }

  @override
  Post? get data => isValid ? post : null;

  @override
  List<String> get errorMesseges => [
        ...descriptionController.errorMesseges,
        ...locationController.errorMesseges,
        ...mediaController.errorMesseges,
      ];

  @override
  List<MediaData> get media => mediaController.selectedMedia;
}
