import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/forms/form_builder/from_builder.dart';
import 'package:ToGather/utilities/utilities.dart';

class FormBuilder extends StatefulWidget {
  const FormBuilder({Key? key, required this.controller}) : super(key: key);

  @override
  State<FormBuilder> createState() => _FormBuilderState();

  final FormBuilderController controller;
}

class _FormBuilderState extends State<FormBuilder> {
  int id = 0;

  void _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = widget.controller.questionItems.removeAt(oldItemIndex);
      widget.controller.questionItems.insert(newItemIndex, movedItem);
    });
  }

  void _onDismis(int index) {
    widget.controller.questionItems.removeAt(index);
    setState(() {});
  }

  void _onAdd(FormBuilderBlockController questionBlock) {
    setState(() {
      widget.controller.questionItems.add(questionBlock);
    });
  }

  @override
  void initState() {
    if (widget.controller.questionItems.isEmpty) {
      if (widget.controller.questionItems.isEmpty) {
        widget.controller.questionItems
            .add(ShortTextFormBuilderController(initialData: null));
      }
    }

    super.initState();
  }

  Widget _button(IconData icon, String title, void Function() onAdd) {
    return Expanded(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: onAdd,
            icon: Icon(icon, color: ThemeService.secondaryText)),
        Text(
          title,
          style: TextStyle(
              color: ThemeService.secondaryText,
              fontSize: 10,
              fontFamily: ThemeService.headlineFont),
        )
      ],
    ));
  }

  late final _buttons = <Widget>[
    _button(LineIcons.font, LanguageService().data.form.short,
        () => _onAdd(ShortTextFormBuilderController(initialData: null))),
    _button(LineIcons.alignLeft, LanguageService().data.form.long,
        () => _onAdd(LongTextFormBuilderController(initialData: null))),
    _button(LineIcons.checkCircle, LanguageService().data.form.choice,
        () => _onAdd(MultipleChoicesFormBuilderController(initialData: null))),
    _button(LineIcons.list, LanguageService().data.form.checkbox,
        () => _onAdd(CheckBoxFormBuilderController(initialData: null)))
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        DragAndDropLists(
            disableScrolling: true,
            itemDivider: const SizedBox(
              height: 5,
            ),
            //listPadding: const EdgeInsets.symmetric(horizontal: 10),
            listDividerOnLastChild: false,
            lastListTargetSize: 0,
            children: [
              DragAndDropList(
                  contentsWhenEmpty: SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          LanguageService().data.form.emptyForm,
                          style: TextStyle(color: ThemeService.secondaryText),
                        ),
                      )),
                  children: List.generate(
                      widget.controller.questionItems.length,
                      (index) => DragAndDropItem(
                            child: DismissableFromBlock(
                              child:
                                  widget.controller.questionItems[index].widget,
                              id: index,
                              onDismiss: _onDismis,
                            ),
                          )),
                  canDrag: false)
            ],
            onItemReorder: _onItemReorder,
            onListReorder: (value, value2) {}),
        Row(
          children: _buttons,
        )
      ],
    ));
  }
}
