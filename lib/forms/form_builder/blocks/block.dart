import 'package:flutter/material.dart';
import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/forms/form_builder/blocks/blocks.dart';

abstract class FormBuilderBlockController<K, T extends FormBlockData<K>> {
  final T? initialData;

  late final questionController =
      TextEditingController(text: initialData?.question);
  late final isRequired = ValueNotifier<bool>(initialData?.isRequired ?? false);
  late final data = ValueNotifier<K>(initData());

  FormBuilderBlockController({required this.initialData});

  K initData();

  List<String> get errorMesseges;

  bool get valid => errorMesseges.isNotEmpty;

  T get getBlockData;

  Widget get widget;

  factory FormBuilderBlockController.fromData(T data) {
    if (T is ShortTextFormBlockData)
      return ShortTextFormBuilderController(
              initialData: data as ShortTextFormBlockData)
          as FormBuilderBlockController<K, T>;
    else if (T is LongTextFormBlockData)
      return LongTextFormBuilderController(
              initialData: data as LongTextFormBlockData)
          as FormBuilderBlockController<K, T>;
    else if (T is MultipleChoicesFormBlockData)
      return MultipleChoicesFormBuilderController(
              initialData: data as MultipleChoicesFormBlockData)
          as FormBuilderBlockController<K, T>;
    else if (T is CheckBoxFormBlockData)
      return CheckBoxFormBuilderController(
              initialData: data as CheckBoxFormBlockData)
          as FormBuilderBlockController<K, T>;
    throw UnimplementedError(data.runtimeType.toString());
  }
}
