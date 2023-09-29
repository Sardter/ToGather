import 'package:ToGather/forms/blocks/block.dart';

class ChoiceData {
  final String text;
  final bool selected;

  const ChoiceData({required this.text, required this.selected});

  factory ChoiceData.fromJson(Map<String, dynamic> json) {
    return ChoiceData(text: json['text'], selected: json['selected']);
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'selected': selected};
  }

  ChoiceData copyWith({bool? selected}) {
    return ChoiceData(text: text, selected: selected ?? this.selected);
  }
}

class MultipleChoicesFormBlockData extends FormBlockData<List<ChoiceData>?> {
  const MultipleChoicesFormBlockData(
      {required super.question, required super.isRequired, super.data});

  factory MultipleChoicesFormBlockData.fromJson(Map<String, dynamic> json) {
    return MultipleChoicesFormBlockData(
        question: json['question'],
        isRequired: json['required'],
        data: List<Map<String, dynamic>>.from(json['data'] ?? [])
            .map((e) => ChoiceData.fromJson(e))
            .toList());
  }

  @override
  MultipleChoicesFormBlockData copyWith({List<ChoiceData>? data}) {
    return MultipleChoicesFormBlockData(
        question: question, isRequired: isRequired, data: data ?? this.data);
  }

  @override
  Map<String, dynamic>? get dataToJson =>
      {'choices': data?.map((e) => e.toJson()).toList()};

  @override
  String get type => 'choices';
}
