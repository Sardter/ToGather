import 'package:flutter/material.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/utilities/utilities.dart';

class TabData<T extends LocationModel> {
  final String title;
  final IconData icon;
  final ModelService<T> service;
  final QueryParameters? params;
  final Widget Function(T) mapper;
  final dynamic Function(int, T) onPageChanged;

  Widget get horizantalNavigator => HorizantalItemNavigator<T>(
      modelService: service,
      label: null,
      onPageChanged: onPageChanged,
      mapper: mapper);

  Widget get verticalNavigator => ListView(
    
  );

  TabData(
      {required this.title,
      required this.icon,
      this.params,
      required this.mapper,
      required this.onPageChanged,
      required this.service});
}