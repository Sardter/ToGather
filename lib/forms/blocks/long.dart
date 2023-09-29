import 'package:ToGather/forms/blocks/block.dart';

class LongTextFormBlockData extends FormBlockData<String?> {
  const LongTextFormBlockData(
      {required super.question, required super.isRequired, super.data});

  factory LongTextFormBlockData.fromJson(Map<String, dynamic> json) {
    return LongTextFormBlockData(
        question: json['question'],
        isRequired: json['required'],
        data: json['data']['long']);
  }

  @override
  LongTextFormBlockData copyWith({String? data}) {
    return LongTextFormBlockData(
        question: question, isRequired: isRequired, data: data ?? this.data);
  }
  
  @override
  Map<String, dynamic>? get dataToJson => {'text': data};
  
  @override
  String get type => 'long';
}
