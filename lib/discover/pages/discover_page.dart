import 'dart:async';

import 'package:ToGather/events/filters/query_params.dart';
import 'package:ToGather/organizations/clubs/filters/query_params.dart';
import 'package:ToGather/organizations/places/filters/query_params.dart';
import 'package:ToGather/users/filters/query_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:latlong2/latlong.dart';
import 'package:ToGather/discover/discover.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with TickerProviderStateMixin {
  late final _controller = DiscoverFilterController(onChanged: _getItems);

  final _clubManager = ModelServiceFactory.CLUB;
  final _eventManager = ModelServiceFactory.EVENT;
  final _placeManager = ModelServiceFactory.PLACE;
  final _postManager = ModelServiceFactory.POST;
  final _userManager = ModelServiceFactory.PROFILE;

  final _mapController = MapController();
  late final _mapItemController = MapItemController(items: _items);

  final _pageKey = GlobalKey<MapPageState>();

  final double HALF_SCREEN = 360;
  late final double FULL_SCREEN = MediaQuery.of(context).size.height;
  final double MINIMIZED = 90;

  Map<MarkerHash, MapMarker> _markers = {};

  List<MapMarker> get _items => _markers.values.toList();

  bool _isMoving = false;
  final _isRefreshing = ValueNotifier<bool>(false);

  late double _modalState = HALF_SCREEN;

  bool get isSearchFocused => _pageKey.currentState?.isFocused ?? false;

  Future<void> _getEvents() async {
    if (!_controller.showEvents) return;
    final _events = ((await _eventManager.getList(
                queryParameters:
                    EventQueryParameters(mapController: _mapController))) ??
            [])
        .where((element) => element.location != null)
        .map((e) => MapEventMarker.fromEvent(e))
        .toList();
    _markers.addEntries(_events.map((e) => MapEntry(e.hash!, e)));
    if (mounted) setState(() {});
  }

  Future<void> _getClubs() async {
    if (!_controller.showClubs) return;
    final _clubs = ((await _clubManager.getList(
                queryParameters:
                    ClubQueryParameters(mapController: _mapController))) ??
            [])
        .where((element) => element.location != null)
        .map((e) => MapClubMarker.fromClub(e))
        .toList();
    _markers.addEntries(_clubs.map((e) => MapEntry(e.hash!, e)));
    if (mounted) setState(() {});
  }

  Future<void> _getPlaces() async {
    if (!_controller.showPlaces) return;
    final _places = ((await _placeManager.getList(
                queryParameters:
                    PlaceQueryParameters(mapController: _mapController))) ??
            [])
        .where((element) => element.location != null)
        .map((e) => MapPlaceMarker(place: e))
        .toList();
    _markers.addEntries(_places.map((e) => MapEntry(e.hash!, e)));
    if (mounted) setState(() {});
  }

  Future<void> _getPosts() async {
    if (!_controller.showPosts) return;
    final _posts = ((await _postManager.getList(
                queryParameters:
                    PostQueryParameters(mapController: _mapController))) ??
            [])
        .where((element) => element.location != null)
        .map((e) => MapPostMarker(post: e))
        .toList();
    _markers.addEntries(_posts.map((e) => MapEntry(e.hash!, e)));
    if (mounted) setState(() {});
  }

  Future<void> _getUsers() async {
    if (!_controller.showUsers) return;
    final _users = ((await _userManager.getList(
                queryParameters:
                    ProfileQueryParameters(mapController: _mapController))) ??
            [])
        .where((element) => element.location != null)
        .map((e) => MapUserMarker(user: e))
        .toList();
    _markers.addEntries(_users.map((e) => MapEntry(e.hash!, e)));
    if (mounted) setState(() {});
  }

  Future<void> _getMarkers() async {
    await Future.wait(
        [_getClubs(), _getEvents(), _getPlaces(), _getPosts(), _getUsers()]);
    if (mounted)
      setState(() {
        _mapItemController.items = _items;
      });
  }

  Future<bool> _getItems() async {
    if (_isRefreshing.value) return false;
    _isRefreshing.value = true;

    await _getMarkers();

    _isRefreshing.value = false;
    return true;
  }

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getItems();
      /* _timer = Timer.periodic(Duration(seconds: 15), (Timer timer) async {
        await _getItems();
      }); */
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final _screenError = _modalState == HALF_SCREEN ? 0.0006 : 0;
    if (!_isMoving)
      setState(() {
        _isMoving = true;
      });

    final edittedDestLocation =
        LatLng(destLocation.latitude - _screenError, destLocation.longitude);
    final latTween = Tween<double>(
        begin: _mapController.center.latitude,
        end: edittedDestLocation.latitude);
    final lngTween = Tween<double>(
        begin: _mapController.center.longitude,
        end: edittedDestLocation.longitude);
    final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
        _isMoving = false;
        setState(() {});
        _onPositionChanged(_mapController);
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
        _isMoving = false;
        setState(() {});
        _onPositionChanged(_mapController);
      }
    });

    controller.forward();
  }

  void zoom(double zoomValue) {
    if (_mapController.zoom + zoomValue >= 18) return;
    _animatedMapMove(_mapController.center, _mapController.zoom + zoomValue);
  }

  void _onPageChanged(int index, LocationModel model) {
    if (model.location == null) return;

    MapMarker? mapItem =
        _markers[MarkerHash(id: model.id, type: model.markerType)];

    if (mapItem != null) {
      mapItem = MapMarker.fromModel(model);
    } else {
      _markers[MarkerHash(id: model.id, type: model.markerType)] = MapMarker.fromModel(model);
    }

    if (mapItem != null) _animatedMapMove(mapItem.location, 20);
  }

  late double _prevZoom = _mapController.zoom;
  late LatLng _prevCenter = _mapController.center;

  bool _haveCenterOrZoomChangedSignificantly(MapController controller) {
    if (_isMoving) return false;
    double centerThreshold = 0.5; // Threshold for center change (in degrees)
    double zoomThreshold = 0.5; // Threshold for zoom change

    LatLng newCenter = controller.center;
    double newZoom = controller.zoom;

    bool centerChanged =
        Distance().distance(newCenter, _prevCenter) >= centerThreshold;

    bool zoomChanged = newZoom >= _prevZoom + zoomThreshold ||
        newZoom <= _prevZoom - zoomThreshold;

    return centerChanged || zoomChanged;
  }

  void _onPositionChanged(MapController? mapController) async {
    if (mapController == null) return;

    if (!_haveCenterOrZoomChangedSignificantly(mapController)) return;
    _prevZoom = mapController.zoom;
    _prevCenter = mapController.center;

    await _getItems();
  }

  Widget _bottomSlider() {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) {
        setState(() {
          _modalState =
              MediaQuery.of(context).size.height - details.globalPosition.dy;

          if (_modalState < MINIMIZED) {
            _modalState = MINIMIZED;
          } else if (_modalState > MediaQuery.of(context).size.height) {
            _modalState = MediaQuery.of(context).size.height;
          }
        });
      },
      onVerticalDragEnd: (DragEndDetails details) {
        setState(() {
          if (_modalState < MediaQuery.of(context).size.height * 0.25) {
            _modalState = 90;
            _modalState = MINIMIZED;
          } else if (_modalState < MediaQuery.of(context).size.height * 0.75) {
            _modalState = 350;
            _modalState = HALF_SCREEN;
          } else {
            _modalState = MediaQuery.of(context).size.height - 100;
            _modalState = FULL_SCREEN;
          }
        });
      },
      child: ItemNavigator(
          height: _modalState,
          fullScreen: FULL_SCREEN,
          halfScreen: HALF_SCREEN,
          filterController: _controller,
          setPageHeight: (height) {
            _modalState = height;
            setState(() {});
          },
          minimized: MINIMIZED,
          onPageChanged: _onPageChanged),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MapPage(
            key: _pageKey,
            canPop: false,
            filterController: _controller,
            getItems: _getItems,
            onPositionChanged: _onPositionChanged,
            onFocus: () => setState(() {}),
            controller: _mapItemController,
            mapController: _mapController),
        if (!isSearchFocused) ...[
          Positioned(
              top: MediaQuery.of(context).size.height * 0.18,
              right: 10,
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
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.32,
            right: 15,
            child: InkWell(
              onTap: () {
                if (_mapItemController.meMarker != null) {
                  _animatedMapMove(_mapItemController.meMarker!.location, 20);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ThemeService.textField,
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.location_pin),
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
              valueListenable: _isRefreshing,
              builder: (context, value, child) => value
                  ? Positioned(top: 0, child: PulsatingLinearProgress())
                  : SizedBox()),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.13,
              child: DiscoverCategories(controller: _controller)),
          Positioned(child: _bottomSlider(), bottom: 0),
        ],
      ],
    );
  }
}
