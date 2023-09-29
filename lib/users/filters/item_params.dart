import 'package:ToGather/utilities/filters/item_paremeters.dart';

class UserItemParameters extends ItemParameters {
  final String? username;

  const UserItemParameters({this.username, super.id});

  String toString() {
    return id == null ? "$username/" : "$id/";
  }
}
