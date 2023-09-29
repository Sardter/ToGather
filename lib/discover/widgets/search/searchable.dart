import 'package:flutter/material.dart';
import 'package:ToGather/discover/services/services.dart';

abstract class Searchable<T> {
  @protected
  final mapSearchService = MapSearchService();

  List<T> data = [];

  bool get isEmpty => data.isEmpty;

  List<Widget> get getWidgets;

  String get title;

  IconData get icon;

  bool isSearching = false;

  @mustCallSuper
  Future<void> search(BuildContext context, String searchToken) async {
    if (searchToken.isEmpty) data = [];
  }

  void clearResults() {
    data = [];
  }
}
