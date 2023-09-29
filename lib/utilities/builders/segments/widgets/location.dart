import 'package:flutter/material.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/utilities/utilities.dart';

class BuilderLocationSegment extends StatefulWidget
    implements CreatePageSegment {
  const BuilderLocationSegment({super.key, required this.locationController});
  final BuilderLocationController locationController;

  @override
  State<BuilderLocationSegment> createState() => _BuilderLocationSegmentState();

  @override
  IconData get icon => Icons.location_pin;

  @override
  String get label => "Mekan";
}

class _BuilderLocationSegmentState extends State<BuilderLocationSegment> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable:
          widget.locationController.hasLocationCheckBoxController.toggled,
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SylvestCheckBox(
                children: [Text("Mekan")],
                controller:
                    widget.locationController.hasLocationCheckBoxController),
            if (value) ...[
              RoundedTextField(
                  type: TextInputType.text,
                  controller: widget.locationController.locationDescription,
                  hint: "Mekan Tarifi"),
              const SizedBox(height: 10),
              LocationPicker(
                  mapItemController:
                      widget.locationController.mapItemController)
            ]
          ],
        ),
      ),
    );
  }
}
