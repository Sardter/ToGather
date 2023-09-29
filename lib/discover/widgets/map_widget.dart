import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:ToGather/config/env.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/utilities/utilities.dart';

class MapWidget extends StatefulWidget {
  const MapWidget(
      {Key? key,
      required this.mapItemController,
      this.mapController,
      this.markTapLocation = true,
      this.isInteractive = true,
      this.defaultLocation,
      this.showMeMarker = false,
      this.defaultZoom = 16,
      this.openCreateMenu = false,
      this.onPositionChanged})
      : super(key: key);
  final MapItemController mapItemController;
  final MapController? mapController;
  final bool markTapLocation;
  final bool openCreateMenu;
  final bool isInteractive;
  final bool showMeMarker;
  final LatLng? defaultLocation;
  final double defaultZoom;
  final void Function(MapController? controller)? onPositionChanged;

  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> with TickerProviderStateMixin {
  late final _defaultLocation =
      widget.defaultLocation ?? LatLng(39.867864, 32.748689);

  @override
  void initState() {
    super.initState();
    //if (widget.mapController != null) _mapEventStream(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.mapItemController.setSetState(() => setState(() {}));

      if (widget.showMeMarker) {
        widget.mapItemController.getMeMarker();
      }
      if (widget.markTapLocation) {
        widget.mapItemController.setMarker(_defaultLocation);
      }
    });
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final edittedDestLocation =
        LatLng(destLocation.latitude, destLocation.longitude);
    final latTween = Tween<double>(
        begin: widget.mapController?.center.latitude,
        end: edittedDestLocation.latitude);
    final lngTween = Tween<double>(
        begin: widget.mapController?.center.longitude,
        end: edittedDestLocation.longitude);
    final zoomTween =
        Tween<double>(begin: widget.mapController?.zoom, end: destZoom);

    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      widget.mapController?.move(
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

  Timer? _debounce;

  List<AbstractMapMarker> get _unclusteredMarkers => [
        if (widget.mapItemController.locationMarker != null)
          widget.mapItemController.locationMarker!,
        if (widget.mapItemController.createMenu != null)
          widget.mapItemController.createMenu!,
        if (widget.showMeMarker && widget.mapItemController.meMarker != null)
          widget.mapItemController.meMarker!
      ];

  List<MapMarker> get _clusteredMarkers =>
      widget.mapItemController.items.cast<MapMarker>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: widget.mapController,
          options: MapOptions(
              keepAlive: true,
              minZoom: 5,
              maxZoom: 18,
              onTap: (tapPosition, point) async {
                if (widget.markTapLocation) {
                  if (widget.mapController != null) _animatedMapMove(point, 20);
                }

                if (widget.openCreateMenu) {
                  if (await widget.mapItemController.openCreateMenu(point) &&
                      widget.mapController != null) ;
                  //_animatedMapMove((event as MapEventTap).tapPosition, 20);
                }
              },
              onPositionChanged: (postion, hasGesture) async {
                if (_debounce?.isActive ?? false) _debounce?.cancel();

                if (widget.markTapLocation)
                  widget.mapItemController.setMarker(postion.center);

                if (widget.onPositionChanged == null) return;

                _debounce = Timer(const Duration(milliseconds: 300), () {
                  widget.onPositionChanged!(widget.mapController);
                });
              },
              interactiveFlags: widget.isInteractive
                  ? InteractiveFlag.all
                  : InteractiveFlag.none,
              zoom: widget.defaultZoom,
              center: _defaultLocation),
          children: [
            TileLayer(
              urlTemplate: Env.MAP_BOX,
              backgroundColor: ThemeService.menuBackground,
              additionalOptions: {
                'mapStyleId': Env.MAP_BOX_STYLE,
                'accessToken': Env.MAP_BOX_ACCESS,
              },
            ),
            if (widget.mapItemController.createMenu != null)
              Container(
                color: Colors.black45,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                circleSpiralSwitchover: 10,
                fitBoundsOptions: FitBoundsOptions(inside: true),
                showPolygon: false,
                maxClusterRadius: 20,
                //spiderfyCluster: false,
                size: const Size(90, 75),
                anchor: AnchorPos.align(AnchorAlign.center),
                markers: _clusteredMarkers
                    .map<ClusterMarker>((item) => ClusterMarker(
                        height: item.height,
                        width: item.width,
                        marker: item,
                        point: item.location,
                        builder: (context) => item))
                    .toList(),

                builder: (BuildContext context, List<Marker> markers) {
                  final clusterMarkers = uniqueBy<ClusterMarker, MarkerHash>(
                      markers.cast<ClusterMarker>(), (marker) => marker.hash);
                  double postion = 0;
                  return GestureDetector(
                    onTap: () {
                      launchPage(
                          context,
                          ClusterPage(
                              markers: clusterMarkers
                                  .map((e) => e.marker.copyWith(
                                      showTitle: false, canLaunchPage: false))
                                  .toList()));
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Stack(
                          alignment: Alignment.centerLeft,
                          children: clusterMarkers
                              .take(3)
                              .map(
                                (e) => AbsorbPointer(
                                  child: Positioned(
                                    left: postion += 5,
                                    child: e.builder(context),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        Positioned(
                          right: 15,
                          child: Badge(
                            label: Text(
                              "${clusterMarkers.length}",
                              style: TextStyle(
                                  color: ThemeService.onContrastColor),
                            ),
                            backgroundColor: ThemeService.eventColor,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            ValueListenableBuilder<LatLng?>(
                valueListenable: LocationService().currentLocation,
                builder: (context, value, child) => MarkerLayer(
                      markers: _unclusteredMarkers
                          .map((e) => Marker(
                              height: e.height,
                              width: e.width,
                              point: e.location,
                              builder: (context) => e))
                          .toList(),
                    )),
          ],
        ),
      ],
    );
  }
}
