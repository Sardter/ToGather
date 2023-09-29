import 'package:ToGather/utilities/services/services.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../markers/markers.dart';

class MapItemController {
  List<AbstractMapMarker> items;
  MapMarker? _locationMarker;
  MapCreateMenu? _createMenu;
  MeMarker? _meMarker;
  void Function()? setState;
  final _createMenuKey = GlobalKey<MapCreateMenuState>();

  void setSetState(void Function() setState) {
    this.setState = setState;
  }

  MapItemController({required this.items});

  MapMarker? get locationMarker => _locationMarker;
  MapCreateMenu? get createMenu => _createMenu;
  MeMarker? get meMarker => _meMarker;

  void setMarker(LatLng? location) {
    if (location == null) {
      removeMarker();
      return;
    }
    _locationMarker = MapMarker(
      id: -1,
      image: null,
      location: location,
      locationDescription: null,
      model: null,
      category: null,
      title: "",
    );
    if (setState != null) setState!();
  }

  Future<bool> openCreateMenu(LatLng location) async {
    if (_createMenu != null) {
      await closeCreateMenu();
      return false;
    } else {
      _createMenu = MapCreateMenu(
        location: location,
        onClose: closeCreateMenu,
        key: _createMenuKey,
      );
      if (setState != null) setState!();
      return true;
    }
  }

  Future<void> getMeMarker() async {
    final location = await LocationService().currentLocation.value;
    print(location);
    if (location != null) _meMarker = MeMarker(location: location);
  }

  Future<void> closeCreateMenu() async {
    await _createMenuKey.currentState?.onClose();
    _createMenu = null;
    if (setState != null) setState!();
  }

  void removeMarker() {
    _locationMarker = null;
    if (setState != null) setState!();
  }
}
