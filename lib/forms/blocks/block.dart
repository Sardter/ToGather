import 'package:ToGather/forms/blocks/blocks.dart';

abstract class FormBlockData<T> {
  final String question;
  final bool isRequired;
  final T? data;

  const FormBlockData(
      {required this.question, required this.isRequired, this.data});

  FormBlockData<T> copyWith({T? data});

  factory FormBlockData.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'short':
        return ShortTextFormBlockData.fromJson(json) as FormBlockData<T>;
      case 'long':
        return LongTextFormBlockData.fromJson(json) as FormBlockData<T>;
      case 'choices':
        return MultipleChoicesFormBlockData.fromJson(json) as FormBlockData<T>;
      case 'check_box':
        return CheckBoxFormBlockData.fromJson(json) as FormBlockData<T>;
    }
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'required': isRequired,
      'type': type,
      'data': dataToJson
    };
  }

  String get type;

  Map<String, dynamic>? get dataToJson;
}
