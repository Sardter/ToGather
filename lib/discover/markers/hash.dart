import 'package:ToGather/discover/discover.dart';

class MarkerHash {
  final int id;
  final MarkerType type;

  MarkerHash({required this.id, required this.type});

  @override
  String toString() {
    return "id: $id, type: $type";
  }

  bool operator ==(Object other) {
    return other is MarkerHash && other.id == id && other.type == type;
  }

  int get hashCode => (type.index + 1) * id;
}
