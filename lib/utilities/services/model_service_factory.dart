import 'package:ToGather/category/category.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:ToGather/notifications/services/api_model_service.dart';
import 'package:ToGather/notifications/services/notifcation_model_service.dart';
import 'package:ToGather/notifications/services/test_model_service.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/users/services/user/connection_service.dart';
import 'package:ToGather/users/services/user/rated_user_service.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

enum ModelServiceFactoryMode { Test, API }

class ModelServiceFactory {
  static ModelServiceFactoryMode get mode => ModelServiceFactoryMode.API;

  static EventModelService get EVENT => mode == ModelServiceFactoryMode.Test
      ? EventTestModelService()
      : EventAPIModelService();

  static ModelService<Place> get PLACE => mode == ModelServiceFactoryMode.Test
      ? PlaceTestModelService()
      : PlaceAPIModelService();

  static ProfileModelService get PROFILE => mode == ModelServiceFactoryMode.Test
      ? ModelServiceFactory.PROFILE
      : ProfileAPIModelService();

  static PostModelService get POST => mode == ModelServiceFactoryMode.Test
      ? PostTestModelService()
      : PostAPIModelService();

  static CommentModelService get COMMENT => mode == ModelServiceFactoryMode.Test
      ? CommentTestModelService()
      : CommentAPIModelService();

  static ClubModelService get CLUB => mode == ModelServiceFactoryMode.Test
      ? ClubTestModelService()
      : ClubAPIModelService();

  static ModelService<Category> get CATEGORY =>
      mode == ModelServiceFactoryMode.Test
          ? CategoryTestModelService()
          : CategoryAPIModelService();

  static ModelService<Tag> get TAG => mode == ModelServiceFactoryMode.Test
      ? TagTestModelService()
      : TagAPIModelService();

  static ModelService<University> get UNIVERSITY =>
      mode == ModelServiceFactoryMode.Test
          ? UniversityTestModelService()
          : UniversityAPIModelService();

  static NotificationModelService get NOTIFICATION =>
      mode == ModelServiceFactoryMode.Test
          ? NotificationTestModelService()
          : NotitificationAPIModelService();

  static ModelService<FormResponse> get FORMRESPONSE =>
      mode == ModelServiceFactoryMode.Test
          ? FormResponseTestModelService()
          : FormResponseAPIModelService();

  static ModelService<RatedUser> get RATEDPROFILE =>
      mode == ModelServiceFactoryMode.Test
          ? ModelServiceFactory.RATEDPROFILE
          : RatedProfileAPIModelService();

  static ProfileModelService get RECIVED_CONNECTIONS =>
      mode == ModelServiceFactoryMode.Test
          ? ModelServiceFactory.PROFILE
          : ProfileRecievedConnectionsAPIModelService();

  static ProfileModelService get SENT_CONNECTIONS =>
      mode == ModelServiceFactoryMode.Test
          ? ModelServiceFactory.PROFILE
          : ProfileSentConnectionsAPIModelService();
}
