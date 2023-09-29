import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/organizations/places/places.dart';

import 'search.dart';

class PlaceSearch extends Searchable<Place> {
  final _manager = ModelServiceFactory.PLACE;

  @override
  List<Widget> get getWidgets =>
      data.map((e) => SearchPlace(place: e)).toList();

  @override
  String get title => "Mekanlar";

  @override
  Future<void> search(BuildContext context, String searchToken) async {
    isSearching = true;
    data = (await _manager.getList(queryParameters: QueryParameters(searchQuery: searchToken))) ?? [];
    super.search(context, searchToken);
    isSearching = false;
  }

  @override
  IconData get icon => LineIcons.store;
}