import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/utilities/utilities.dart';

import 'search/search.dart';
import 'search_bar.dart';
import 'map_widget.dart';
import '../services/services.dart';


class LocationPicker extends StatefulWidget {
  LocationPicker({Key? key, required this.mapItemController}) : super(key: key);
  final _mapController = MapController();
  final MapItemController mapItemController;

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker>
    with TickerProviderStateMixin {

  void _onLocationTap(LatLng location) {
    if (mounted)
      setState(() {
        _animatedMapMove(location, 16);
        _searchFor.forEach((element) {
          element.clearResults();
        });
      });
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final edittedDestLocation =
        LatLng(destLocation.latitude, destLocation.longitude);
    final latTween = Tween<double>(
        begin: widget._mapController.center.latitude,
        end: edittedDestLocation.latitude);
    final lngTween = Tween<double>(
        begin: widget._mapController.center.longitude,
        end: edittedDestLocation.longitude);
    final zoomTween =
        Tween<double>(begin: widget._mapController.zoom, end: destZoom);

    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      widget._mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  void zoom(double zoomValue) {
    if (widget._mapController.zoom + zoomValue >= 18) return;
    _animatedMapMove(
        widget._mapController.center, widget._mapController.zoom + zoomValue);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.mapItemController.setMarker(widget._mapController.center);
      widget._mapController.move(widget._mapController.center, 16);
    });
  }

  late final _searchFor = <Searchable>[
    LocationSearch(onLocationResultTap: _onLocationTap),
  ];

  @override
  Widget build(BuildContext context) {
    return SylvestCard(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: ThemeService.allAroundBorderRadius,
              child: MapWidget(
                  mapItemController: widget.mapItemController,
                  mapController: widget._mapController),
            ),
            MapSearchBar(searchFor: _searchFor),
            Positioned(
                top: 60,
                left: 10,
                child: SylvestCard(
                  background: ThemeService.textField,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => zoom(1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(LineIcons.plus),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                        child: Divider(),
                      ),
                      InkWell(
                        onTap: () => zoom(-1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(LineIcons.minus),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
