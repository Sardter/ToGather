import 'package:flutter/material.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';

import 'search.dart';

class PostSearch extends Searchable<Post> {
  final _manager = ModelServiceFactory.POST;

  @override
  List<Widget> get getWidgets =>
      data.map((e) => SearchPost(post: e)).toList();

  @override
  String get title => LanguageService().data.titles.posts;

  @override
  Future<void> search(BuildContext context, String searchToken) async {
    isSearching = true;
    data = (await _manager.getList(queryParameters: QueryParameters(searchQuery: searchToken)))!;
    super.search(context, searchToken);
    isSearching = false;
  }

  @override
  IconData get icon => Icons.post_add;
}