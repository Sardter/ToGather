import 'package:ToGather/forms/blocks/blocks.dart';

class ShortTextFormBlockData extends FormBlockData<String?> {
  const ShortTextFormBlockData(
      {required super.question, required super.isRequired, super.data});

  factory ShortTextFormBlockData.fromJson(Map<String, dynamic> json) {
    return ShortTextFormBlockData(
        question: json['question'],
        isRequired: json['required'],
        data: json['data']['text']);
  }

  @override
  ShortTextFormBlockData copyWith({String? data}) {
    return ShortTextFormBlockData(
        question: question, isRequired: isRequired, data: data ?? this.data);
  }

  @override
  Map<String, dynamic>? get dataToJson => {'text': data};

  @override
  String get type => 'short';
}
