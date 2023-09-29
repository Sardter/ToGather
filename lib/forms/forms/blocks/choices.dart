import 'package:flutter/material.dart';
import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/forms/forms/forms.dart';
import 'package:ToGather/utilities/utilities.dart';

class MultipleChoiceFormBlockOption extends StatelessWidget {
  final ChoiceData data;

  const MultipleChoiceFormBlockOption({required this.data});

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 0.5)
          ],
          borderRadius: BorderRadius.circular(20),
          color: data.selected
              ? ThemeService.eventColor
              : ThemeService.textField),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      width: double.maxFinite,
      child: Text(
        data.text,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class MultipleChoiceFormBlockController extends FormBlockController<
    List<ChoiceData>?, MultipleChoicesFormBlockData> {
  late final selectedIndex = ValueNotifier<int>(
      data.data?.indexWhere((element) => element.selected) ?? -1);

  MultipleChoiceFormBlockController({required super.data});

  @override
  List<String> get errorMesseges => [
        if (data.isRequired) ...[
          if (selectedIndex.value == -1)
            LanguageService().data.errors.noOptionSelected
        ]
      ];

  @override
  Widget get widget => MultipleChoiceFormBlock(controller: this);
}

class MultipleChoiceFormBlock extends StatefulWidget {
  final MultipleChoiceFormBlockController controller;

  @override
  State<MultipleChoiceFormBlock> createState() =>
      MultipleChoiceFormBlockState();

  const MultipleChoiceFormBlock({
    Key? key,
    required this.controller,
  }) : super(key: key);
}

class MultipleChoiceFormBlockState extends State<MultipleChoiceFormBlock> {
  void _onSelect(int index) {
    for (int i = 0; i < widget.controller.data.data!.length; i++) {
      widget.controller.data.data![i] =
          widget.controller.data.data![i].copyWith(selected: i == index);
    }
    widget.controller.selectedIndex.value = index;
    setState(() {});
  }

  @override
  Widget build(context) {
    return ValueListenableBuilder(
        valueListenable: widget.controller.selectedIndex,
        builder: (context, value, child) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                QuestionWidget(
                    question: widget.controller.data.question,
                    questionRequired: widget.controller.data.isRequired),
                const SizedBox(height: 5),
                for (String error in widget.controller.errorMesseges)
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  ),
                if (widget.controller.data.data != null)
                  ...List.generate(
                      widget.controller.data.data!.length,
                      (index) => GestureDetector(
                            onTap: () => _onSelect(index),
                            child: MultipleChoiceFormBlockOption(
                                data: widget.controller.data.data![index]),
                          ))
              ],
            ),
          );
        });
  }
}
