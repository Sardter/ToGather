import 'package:flutter/material.dart';
import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/forms/form_builder/from_builder.dart';
import 'package:ToGather/utilities/utilities.dart';

class ShortTextFormBuilderController
    extends FormBuilderBlockController<String?, ShortTextFormBlockData> {
  ShortTextFormBuilderController({required super.initialData});

  @override
  List<String> get errorMesseges => [
        if (questionController.text.isEmpty)
          LanguageService().data.errors.questionEmpty
      ];

  @override
  ShortTextFormBlockData get getBlockData => ShortTextFormBlockData(
      question: questionController.text, isRequired: isRequired.value);

  @override
  String? initData() => null;

  @override
  Widget get widget => ShortTextQuestionBlock(controller: this);
}

class ShortTextQuestionBlock extends StatefulWidget {
  const ShortTextQuestionBlock({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ShortTextFormBuilderController controller;

  @override
  State<ShortTextQuestionBlock> createState() => _ShortTextQuestionBlockState();
}

class _ShortTextQuestionBlockState extends State<ShortTextQuestionBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
                activeColor: ThemeService.eventColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                value: widget.controller.isRequired.value,
                onChanged: (value) {
                  setState(() {
                    widget.controller.isRequired.value = value ?? false;
                  });
                }),
            Expanded(
              child: TextFormField(
                controller: widget.controller.questionController,
                decoration: InputDecoration(
                    hintText: LanguageService().data.form.question,
                    isCollapsed: true,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: ThemeService.textField,
              borderRadius: BorderRadius.circular(30)),
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            "Kısa Cevap",
            style: TextStyle(color: ThemeService.secondaryText),
          ),
        )
      ],
    );
  }
}
