import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/utilities/utilities.dart';

import 'search.dart';

class EventSearch extends Searchable<Event> {
  final _manager = ModelServiceFactory.EVENT;

  @override
  List<Widget> get getWidgets =>
      data.map((e) => SearchEvent(event: e)).toList();

  @override
  String get title => LanguageService().data.titles.events;

  @override
  Future<void> search(BuildContext context, String searchToken) async {
    isSearching = true;
    data = (await _manager.getList(queryParameters: QueryParameters(searchQuery: searchToken)))!;
    super.search(context, searchToken);
    isSearching = false;
  }

  @override
  IconData get icon => LineIcons.calendar;
}