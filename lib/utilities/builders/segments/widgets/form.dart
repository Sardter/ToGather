import 'package:flutter/material.dart';
import 'package:ToGather/forms/form_builder/from_builder.dart';
import 'package:ToGather/utilities/utilities.dart';

class BuilderFormSegment extends StatefulWidget implements CreatePageSegment {
  const BuilderFormSegment({super.key, required this.formController});
  final BuilderFormController formController;

  @override
  State<BuilderFormSegment> createState() => _BuilderFormSegmentState();

  @override
  IconData get icon => Icons.assignment;

  @override
  String get label => "Form";
}

class _BuilderFormSegmentState extends State<BuilderFormSegment> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.formController.hasFromCheckBoxController.toggled,
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SylvestCheckBox(
                children: [Text("Form")],
                controller: widget.formController.hasFromCheckBoxController),
            if (value) ...[
              FormBuilder(
                  controller: widget.formController.formBuilderController)
            ]
          ],
        ),
      ),
    );
  }
}
