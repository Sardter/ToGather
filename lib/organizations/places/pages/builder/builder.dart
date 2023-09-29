import 'package:ToGather/users/users.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/utilities/utilities.dart';

export 'controllers/controllers.dart';
export 'segments/segments.dart';

class CreatePlacePage extends StatefulWidget {
  const CreatePlacePage({super.key, required this.controller});
  final CreatePlaceController controller;

  @override
  State<CreatePlacePage> createState() => _CreatePlacePageState();
}

class _CreatePlacePageState extends State<CreatePlacePage> {
  List<CreatePageSegment> _segments(Profile user) => [
        CreatePlaceDescriptionSegment(
          descriptionController: widget.controller.descriptionController,
        ),
        BuilderLocationSegment(
            locationController: widget.controller.locationController),
      ];

  @override
  Widget build(BuildContext context) {
    return CreateModelPage<Place>(
        pageTitle: "Mekan Oluştur",
        detailPage: (item) => PlaceDetailPage(id: item.id),
        controller: widget.controller,
        segments: _segments,
        warningsController: widget.controller.warningsController,
        buttonChildren: const [
          Icon(
            Icons.share,
            color: ThemeService.onContrastColor,
          ),
          SizedBox(width: 10),
          Text(
            "Mekanı Paylaş",
            style: TextStyle(
              color: ThemeService.onContrastColor,
            ),
          )
        ]);
  }
}
