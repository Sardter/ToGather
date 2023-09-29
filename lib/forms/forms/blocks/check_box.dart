import 'package:flutter/material.dart';
import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/forms/forms/forms.dart';
import 'package:ToGather/utilities/utilities.dart';

class CheckBoxFormBlockController
    extends FormBlockController<List<CheckData>?, CheckBoxFormBlockData> {
  CheckBoxFormBlockController({required super.data});

  @override
  List<String> get errorMesseges => [];

  @override
  Widget get widget => CheckBoxFormBlock(controller: this);
}

class CheckBoxFormBlock extends StatefulWidget {
  final CheckBoxFormBlockController controller;

  const CheckBoxFormBlock({Key? key, required this.controller})
      : super(key: key);

  @override
  State<CheckBoxFormBlock> createState() => CheckBoxFormBlockState();
}

class CheckBoxFormBlockState extends State<CheckBoxFormBlock> {
  Widget _option(CheckData data, int index) {
    return Row(
      children: [
        Checkbox(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            activeColor: ThemeService.eventColor,
            value: data.selected,
            onChanged: (isSelected) {
              setState(() {
                widget.controller.data.data![index] =
                    widget.controller.data.data![index].copyWith(
                        selected:
                            !widget.controller.data.data![index].selected);
              });
            }),
        Text(data.text)
      ],
    );
  }

  List<Widget> get _options {
    return widget.controller.data.data == null
        ? []
        : List.generate(widget.controller.data.data!.length,
            (index) => _option(widget.controller.data.data![index], index));
  }

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            QuestionWidget(
                question: widget.controller.data.question,
                questionRequired: widget.controller.data.isRequired),
            ..._options
          ]),
    );
  }
}
