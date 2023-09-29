import 'package:flutter/material.dart';
import 'package:ToGather/forms/blocks/choices.dart';
import 'package:ToGather/forms/form_builder/from_builder.dart';
import 'package:ToGather/utilities/utilities.dart';

class Choice extends StatelessWidget {
  final TextEditingController controller;

  const Choice({required this.controller});

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
          color: ThemeService.textField, borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: ThemeService.primaryText),
        decoration: InputDecoration(
            hintText: LanguageService().data.form.choice,
            hintStyle: TextStyle(color: ThemeService.secondaryText),
            isCollapsed: true,
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none),
      ),
    );
  }
}

class MultipleChoicesFormBuilderController extends FormBuilderBlockController<
    List<ChoiceData>?, MultipleChoicesFormBlockData> {
  final List<TextEditingController> controllers = [];

  MultipleChoicesFormBuilderController({required super.initialData});

  @override
  List<String> get errorMesseges => [
        if (questionController.text.isEmpty)
          LanguageService().data.errors.questionEmpty,
        if ((data.value?.length ?? 0) < 2) "En az iki seçenek belirtmelisin",
        if (data.value?.where((element) => element.text.isEmpty).isNotEmpty ??
            false)
          "Seçenek boş kalamaz"
      ];

  @override
  MultipleChoicesFormBlockData get getBlockData => MultipleChoicesFormBlockData(
      question: questionController.text,
      isRequired: isRequired.value,
      data: controllers
          .map((e) => ChoiceData(text: e.text, selected: false))
          .toList());

  @override
  List<ChoiceData>? initData() {
    final result = initialData?.data ??
        [
          ChoiceData(text: "1. Seçenek", selected: false),
          ChoiceData(text: "2. Seçenek", selected: false),
        ];
    controllers.clear();
    controllers.addAll(result.map((e) => TextEditingController()));
    return result;
  }

  @override
  Widget get widget => MultipleChoiceQuestionBlock(controller: this);
}

class MultipleChoiceQuestionBlock extends StatefulWidget {
  const MultipleChoiceQuestionBlock({Key? key, required this.controller})
      : super(key: key);

  @override
  State<MultipleChoiceQuestionBlock> createState() =>
      _MultipleChoiceQuestionBlockState();

  final MultipleChoicesFormBuilderController controller;
}

class _MultipleChoiceQuestionBlockState
    extends State<MultipleChoiceQuestionBlock> {
  void _onAdd() {
    setState(() {
      final text = "${widget.controller.data.value!.length + 1}. Seçenek";
      widget.controller.controllers.add(TextEditingController(text: text));
      widget.controller.data.value!
          .add(ChoiceData(text: text, selected: false));
    });
  }

  void _onRemove() {
    if (widget.controller.data.value!.length <= 2) {
      return;
    }
    setState(() {
      widget.controller.data.value!.removeLast();
      widget.controller.controllers.removeLast();
    });
  }

  @override
  void initState() {
    super.initState();
  }

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
        const SizedBox(height: 10),
        Column(
          children: List.generate(
              widget.controller.data.value!.length,
              (index) =>
                  Choice(controller: widget.controller.controllers[index])),
        ),
        Row(
          children: [
            IconButton(
                onPressed: _onAdd,
                icon: Icon(
                  Icons.add,
                  color: ThemeService.secondaryText,
                )),
            IconButton(
                onPressed: _onRemove,
                icon: Icon(
                  Icons.remove,
                  color: ThemeService.secondaryText,
                )),
          ],
        )
      ],
    );
  }
}
