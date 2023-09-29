import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/utilities/utilities.dart';

import 'search.dart';

class ClubSearch extends Searchable<Club> {
  final _manager = ModelServiceFactory.CLUB;

  @override
  List<Widget> get getWidgets => data.map((e) => SearchClub(club: e)).toList();

  @override
  String get title => LanguageService().data.titles.clubs;

  @override
  Future<void> search(BuildContext context, String searchToken) async {
    isSearching = true;
    data = (await _manager.getList(
        queryParameters: QueryParameters(searchQuery: searchToken)))!;
    super.search(context, searchToken);
    isSearching = false;
  }

  @override
  IconData get icon => LineIcons.users;
}
