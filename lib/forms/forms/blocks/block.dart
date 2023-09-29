import 'package:flutter/material.dart';
import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/forms/forms/forms.dart';

abstract class FormBlockController<K, T extends FormBlockData<K>> {
  T data;

  FormBlockController({required this.data});

  List<String> get errorMesseges;

  bool get isValid => errorMesseges.isEmpty;

  void onChange(K data) => this.data = this.data.copyWith(data: data) as T;

  Widget get widget;

  factory FormBlockController.fromData(T data) {
    if (T is ShortTextFormBlockData)
      return ShortTextFormBlockController(data: data as ShortTextFormBlockData)
          as FormBlockController<K, T>;
    else if (T is LongTextFormBlockData)
      return LongTextFormBlockController(data: data as LongTextFormBlockData)
          as FormBlockController<K, T>;
    else if (T is MultipleChoicesFormBlockData)
      return MultipleChoiceFormBlockController(
              data: data as MultipleChoicesFormBlockData)
          as FormBlockController<K, T>;
    else if (T is CheckBoxFormBlockData)
      return CheckBoxFormBlockController(data: data as CheckBoxFormBlockData)
          as FormBlockController<K, T>;
    throw UnimplementedError(data.runtimeType.toString());
  }
}
