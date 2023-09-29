import 'package:ToGather/events/events.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/users/pages/builder/controllers/user.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

abstract class BuilderPublisher<T extends Model>
    extends BuilderSegmentController<T> {
  BuilderWarningsController get warningsController;
  ModelService<T> get modelService;

  T? get data;

  bool get isUpdating;
  ItemParameters? get itemParameters;

  BuilderPublisher();

  factory BuilderPublisher.fromModel(T model, ModelService<T> modelService) {
    if (model is Event)
      return CreateEventController.fromEvent(
          model, modelService as ModelService<Event>) as BuilderPublisher<T>;
    else if (model is Club)
      return CreateClubController.fromClub(
          model, modelService as ModelService<Club>) as BuilderPublisher<T>;
    else if (model is Place)
      return CreatePlaceController.fromPlace(
          model, modelService as ModelService<Place>) as BuilderPublisher<T>;
    else if (model is Post)
      return CreatePostController.fromPost(
          model, modelService as ModelService<Post>) as BuilderPublisher<T>;
    else if (model is Profile)
      return CreateProfileController.fromProfile(
          model, modelService as ProfileModelService) as BuilderPublisher<T>;
    throw UnimplementedError();
  }

  Future<T?> publish() async {
    if (errorMesseges.isNotEmpty) {
      if (warningsController.onError != null)
        errorMesseges.forEach((e) => warningsController.onError!(e));

      return null;
    }

    return modelService.postItem(item: data!);
  }

  Future<T?> update() async {
    if (errorMesseges.isNotEmpty) {
      if (warningsController.onError != null)
        errorMesseges.forEach((e) => warningsController.onError!(e));

      return null;
    }

    return modelService.updateItem(
        updatedItem: data!, itemParameters: itemParameters!);
  }

  List<MediaData?> get media;

  Future<T?> onDone() async {
    return isUpdating ? await update() : await publish();
  }
}
