import 'package:ToGather/category/category.dart';
import 'package:ToGather/events/models/models.dart';
import 'package:ToGather/organizations/clubs/models/models.dart';
import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:ToGather/organizations/places/models/models.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/users/models/models.dart';

abstract class Model {
  final int id;

  const Model({required this.id});

  @override
  bool operator ==(Object other) => other is Model && id == other.id;

  Map<String, dynamic> toJson();

  factory Model.fromJson(Map<String, dynamic> json, Type type) {
    switch (type) {
      case Post:
        return Post.fromJson(json);
      case Comment:
        return Comment.fromJson(json);
      case Event:
        return Event.fromJson(json);
      case Club:
        return Club.fromJson(json);
      case Place:
        return Place.fromJson(json);
      case Profile:
        return Profile.fromJson(json);
      case FormResponse:
        return FormResponse.fromJson(json);
      case University:
        return University.fromJson(json);
      case Category:
        return Category.fromJson(json);
      case RatedUser:
        return RatedUser.fromJson(json);
      case Tag:
        return Tag.fromJson(json);
      default:
        throw UnimplementedError();
    }
  }

  @override
  int get hashCode => id;
}
