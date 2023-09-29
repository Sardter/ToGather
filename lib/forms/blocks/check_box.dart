import 'package:ToGather/forms/blocks/block.dart';

class CheckData {
  final String text;
  final bool selected;

  const CheckData({required this.text, required this.selected});

  factory CheckData.fromJson(Map<String, dynamic> json) {
    return CheckData(text: json['text'], selected: json['selected']);
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'selected': selected};
  }

  CheckData copyWith({bool? selected}) {
    return CheckData(text: text, selected: selected ?? this.selected);
  }
}

class CheckBoxFormBlockData extends FormBlockData<List<CheckData>?> {
  const CheckBoxFormBlockData(
      {required super.question, required super.isRequired, super.data});

  factory CheckBoxFormBlockData.fromJson(Map<String, dynamic> json) {
    return CheckBoxFormBlockData(
        question: json['question'],
        isRequired: json['required'],
        data: List<Map<String, dynamic>>.from(json['data'] ?? [])
            .map((e) => CheckData.fromJson(e))
            .toList());
  }

  @override
  CheckBoxFormBlockData copyWith({List<CheckData>? data}) {
    return CheckBoxFormBlockData(
        question: question, isRequired: isRequired, data: data ?? this.data);
  }
  
  @override
  Map<String, dynamic>? get dataToJson => {'choices': data?.map((e) => e.toJson()).toList()};
  
  @override
  String get type => 'check_box';
}
