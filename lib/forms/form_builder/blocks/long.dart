import 'package:flutter/material.dart';
import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/forms/form_builder/from_builder.dart';
import 'package:ToGather/utilities/utilities.dart';

class LongTextFormBuilderController
    extends FormBuilderBlockController<String?, LongTextFormBlockData> {
  LongTextFormBuilderController({required super.initialData});

  @override
  List<String> get errorMesseges => [
        if (questionController.text.isEmpty)
          LanguageService().data.errors.questionEmpty
      ];

  @override
  LongTextFormBlockData get getBlockData => LongTextFormBlockData(
      question: questionController.text, isRequired: isRequired.value);

  @override
  String? initData() => null;

  @override
  Widget get widget => LongTextQuestionBlock(controller: this);
}

class LongTextQuestionBlock extends StatefulWidget {
  const LongTextQuestionBlock({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LongTextFormBuilderController controller;

  @override
  State<LongTextQuestionBlock> createState() => _LongTextQuestionBlockState();
}

class _LongTextQuestionBlockState extends State<LongTextQuestionBlock> {
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
              borderRadius: BorderRadius.circular(10)),
          width: double.maxFinite,
          height: 100,
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            "Uzun Cevap",
            style: TextStyle(color: ThemeService.secondaryText),
          ),
        )
      ],
    );
  }
}
