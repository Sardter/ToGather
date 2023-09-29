import 'package:ToGather/utilities/utilities.dart';

class Tag extends Model {
  final String name;

  const Tag({required super.id, required this.name});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(id: json['id'] ?? -1, name: json['name']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name
    };
  }
}