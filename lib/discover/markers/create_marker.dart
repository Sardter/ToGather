import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/_extra_libs/radial_button/radial_button.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';

import 'abstract_marker.dart';

class MapCreateMenu extends StatefulWidget implements AbstractMapMarker {
  final LatLng location;
  final int? id;
  final double width;
  final double height;
  final void Function() onClose;
  final MarkerType type;

  const MapCreateMenu(
      {super.key,
      required this.location,
      required this.onClose,
      this.id,
      this.type = MarkerType.None,
      this.height = 300,
      this.width = 300});

  @override
  State<MapCreateMenu> createState() => MapCreateMenuState();
}

class MapCreateMenuState extends State<MapCreateMenu> {
  final _key = GlobalKey<CircleFloatingButtonState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _key.currentState?.toggle();
    });
  }

  @override
  void dispose() {
    _key.currentState?.dispose();
    super.dispose();
  }

  Future<void> onClose() async {
    _key.currentState?.close();
    await Future.delayed(Duration(milliseconds: 150));
    widget.onClose();
  }

  Widget _action(
      IconData icon, String label, void Function() onTap, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: label,
          backgroundColor: color,
          onPressed: () => {onTap(), onClose()},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: ThemeService.onContrastColor,
              ),
              Text(label,
                  style: TextStyle(
                      fontSize: 7, color: ThemeService.onContrastColor))
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClose();
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 50, bottom: 10),
        child: CircleFloatingButton(
          key: _key,
          type: CircleType.complete,
          //position: Position.bottom,
          completeCircle: true,
          radius: 75,
          buttonColor: ThemeService.disabledColor,
          buttonIcon: Icons.location_pin,
          curve: Curves.easeInOut,
          child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: GestureDetector(
              child: FloatingActionButton(
                backgroundColor: ThemeService.disabledColor,
                onPressed: onClose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    Text("Ekle", style: TextStyle(fontSize: 8))
                  ],
                ),
              ),
            ),
          ),
          opacity: true,
          items: [
            _action(
                Icons.post_add,
                "Gönderi",
                () => launchPage(
                      context,
                      CreatePostPage(
                          controller: CreatePostController.newPost(ModelServiceFactory.POST)),
                    ),
                ThemeService.postColor),
            _action(
              LineIcons.calendar,
              "Etkinlik",
              () => launchPage(
                context,
                CreateEventPage(
                  controller: CreateEventController.newEvent(ModelServiceFactory.EVENT),
                ),
              ),
              ThemeService.eventColor
            ),
            _action(
                Icons.store,
                "Mekan",
                () => launchPage(
                      context,
                      CreatePlacePage(
                          controller: CreatePlaceController.newPlace(ModelServiceFactory.PLACE)),
                    ),
                ThemeService.placeColor),
            _action(
                Icons.people,
                "Topluluk",
                () => launchPage(
                      context,
                      CreateClubPage(
                        controller: CreateClubController.newClub(ModelServiceFactory.CLUB),
                      ),
                    ),
                ThemeService.clubColor),
          ],
        ),
      ),
    );
  }
}
