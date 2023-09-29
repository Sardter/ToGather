import 'package:flutter/material.dart';
import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/forms/forms/forms.dart';
import 'package:ToGather/utilities/utilities.dart';

class LongTextFormBlockController
    extends FormBlockController<String?, LongTextFormBlockData> {
  late final textController = TextEditingController(text: data.data);

  LongTextFormBlockController({required super.data});

  @override
  List<String> get errorMesseges => [
        if (data.isRequired) ...[
          if (textController.text.isEmpty)
            LanguageService().data.errors.fieldEmpty,
        ],
        if (textController.text.length >= 255)
          LanguageService().data.errors.fieldMoreThan255
      ];

  @override
  Widget get widget => LongTextFormBlock(controller: this);
}

class LongTextFormBlock extends StatefulWidget {
  const LongTextFormBlock({Key? key, required this.controller})
      : super(key: key);

  final LongTextFormBlockController controller;

  @override
  State<LongTextFormBlock> createState() => _LongTextFormBlockState();
}

class _LongTextFormBlockState extends State<LongTextFormBlock> {
  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionWidget(
              question: widget.controller.data.question,
              questionRequired: widget.controller.data.isRequired),
          const SizedBox(height: 5),
          for (String error in widget.controller.errorMesseges)
            Text(
              error,
              style: TextStyle(color: Colors.red),
            ),
          RoundedTextField(
              onChanged: (value) =>
                  setState(() => widget.controller.onChange(value)),
              minLines: 2,
              type: TextInputType.text,
              controller: widget.controller.textController,
              hint: LanguageService().data.form.short)
        ],
      ),
    );
  }
}
