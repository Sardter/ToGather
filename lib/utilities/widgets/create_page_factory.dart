import 'package:ToGather/events/events.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/users/pages/builder/controllers/user.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';

Widget CreatePageFactory<T extends Model>(T model, ModelService<T> modelService) {
  if (model is Event)
    return CreateEventPage(
        controller: BuilderPublisher.fromModel(model, modelService)
            as CreateEventController);
  else if (model is Club)
    return CreateClubPage(
        controller: BuilderPublisher.fromModel(model, modelService)
            as CreateClubController);
  else if (model is Place)
    return CreatePlacePage(
        controller: BuilderPublisher.fromModel(model, modelService)
            as CreatePlaceController);
  else if (model is Post)
    return CreatePostPage(
        controller: BuilderPublisher.fromModel(model, modelService)
            as CreatePostController);
  else if (model is Profile)
    return CreateUserPage(
        controller: BuilderPublisher.fromModel(model, modelService)
            as CreateProfileController);
  throw UnimplementedError();
}
