import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:ToGather/discover/discover.dart';

class MapPage extends StatefulWidget {
  MapPage(
      {Key? key,
      this.canPop = true,
      required this.controller,
      MapController? mapController,
      this.getItems,
      this.filterController,
      this.onFocus,
      this.onPositionChanged})
      : super(key: key) {
    this.mapController = mapController ?? MapController();
  }
  final MapItemController controller;
  late final MapController mapController;
  final bool canPop;
  final Future<bool> Function()? getItems;
  final DiscoverFilterController? filterController;
  final void Function()? onFocus;
  final void Function(MapController? mapController)? onPositionChanged;

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final _searchKey = GlobalKey<MapSearchBarState>();
  late final _searchFor = <Searchable>[
    EventSearch(),
    ClubSearch(),
    ProfileSearch(),
    PostSearch(),
    PlaceSearch(),
    //LocationSearch(onLocationResultTap: _onLocationTap),
  ];


  bool get isSearchEmpty => _searchKey.currentState?.isSearchEmpty ?? false;

  bool get isFocused => _searchKey.currentState?.isFocused ?? false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapWidget(
            markTapLocation: false,
            openCreateMenu: true,
            showMeMarker: true,
            onPositionChanged: widget.onPositionChanged,
            mapItemController: widget.controller,
            mapController: widget.mapController),
        MapSearchBar(
          onFocus: widget.onFocus,
          searchFor: _searchFor,
          key: _searchKey,
          filterController: widget.filterController,
          getItems: widget.getItems,
        )
      ],
    );
  }
}
