import 'package:ToGather/utilities/utilities.dart';

class Category extends Model {
  final String title;
  final ImageData? image;
  const Category({required super.id, required this.title, required this.image});

  factory Category.fromJson(Map json) {
    return Category(
        id: json['id'],
        title: json['name'],
        image: json['picture'] == null ? null : NetworkMediaData.fromURL(json['picture']) as NetworkImageData);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': title, 'picture': image};
  }
}
