import 'package:flutter/material.dart';
import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/forms/form_builder/from_builder.dart';
import 'package:ToGather/utilities/utilities.dart';

class Check extends StatelessWidget {
  const Check({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  String getData() {
    return controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: null, onChanged: null, tristate: true),
        Expanded(
            child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: LanguageService().data.form.question,
                    isCollapsed: true,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none)))
      ],
    );
  }
}

class CheckBoxFormBuilderController extends FormBuilderBlockController<
    List<CheckData>?, CheckBoxFormBlockData> {
  final List<TextEditingController> controllers = [];

  CheckBoxFormBuilderController({required super.initialData});

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
  CheckBoxFormBlockData get getBlockData => CheckBoxFormBlockData(
      question: questionController.text,
      isRequired: isRequired.value,
      data: controllers
          .map((e) => CheckData(text: e.text, selected: false))
          .toList());

  @override
  List<CheckData>? initData() {
    final result = initialData?.data ??
        [
          CheckData(text: "1. Kutu", selected: false),
          CheckData(text: "2. Kutu", selected: false),
        ];
    controllers.clear();
    controllers.addAll(result.map((e) => TextEditingController(text: e.text)));
    return result;
  }

  @override
  Widget get widget => CheckBoxQuestionBlock(controller: this);
}

class CheckBoxQuestionBlock extends StatefulWidget {
  const CheckBoxQuestionBlock({Key? key, required this.controller})
      : super(key: key);

  final CheckBoxFormBuilderController controller;

  @override
  State<CheckBoxQuestionBlock> createState() => _CheckBoxQuestionBlockState();
}

class _CheckBoxQuestionBlockState extends State<CheckBoxQuestionBlock> {
  void _onAdd() {
    setState(() {
      final text = "${widget.controller.data.value!.length + 1}. Kutu";
      widget.controller.controllers.add(TextEditingController(text: text));
      widget.controller.data.value!.add(CheckData(text: text, selected: false));
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onAdd();
      _onRemove();
    });
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
        SizedBox(
          height: 10,
        ),
        Column(
          children: widget.controller.controllers
              .map((e) => Check(controller: e))
              .toList(),
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
