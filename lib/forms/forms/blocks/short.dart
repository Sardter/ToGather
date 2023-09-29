import 'package:flutter/material.dart';
import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/forms/forms/forms.dart';
import 'package:ToGather/utilities/utilities.dart';

class ShortTextFormBlockController
    extends FormBlockController<String?, ShortTextFormBlockData> {
  late final textController = TextEditingController(text: data.data);

  ShortTextFormBlockController({required super.data});

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
  Widget get widget => ShortTextFormBlock(controller: this);
}

class ShortTextFormBlock extends StatefulWidget {
  const ShortTextFormBlock({Key? key, required this.controller})
      : super(key: key);

  final ShortTextFormBlockController controller;

  @override
  State<ShortTextFormBlock> createState() => _ShortTextFormBlockState();
}

class _ShortTextFormBlockState extends State<ShortTextFormBlock> {
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
              type: TextInputType.text,
              controller: widget.controller.textController,
              hint: LanguageService().data.form.short)
        ],
      ),
    );
  }
}
