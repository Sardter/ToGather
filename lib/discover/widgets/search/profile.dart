import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

import 'search.dart';

class ProfileSearch extends Searchable<Profile> {
  final _manager = ModelServiceFactory.PROFILE;

  @override
  List<Widget> get getWidgets =>
      data.map((e) => SearchUser(profileData: e)).toList();

  @override
  String get title => LanguageService().data.titles.profiles;

  @override
  Future<void> search(BuildContext context, String searchToken) async {
    isSearching = true;
    data = (await _manager.getList(queryParameters: QueryParameters(searchQuery: searchToken)))!;
    super.search(context, searchToken);
    isSearching = false;
  }
  
  @override
  IconData get icon => LineIcons.user;
}