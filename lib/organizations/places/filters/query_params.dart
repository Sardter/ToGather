import 'package:ToGather/category/category.dart';
import 'package:ToGather/organizations/places/models/place.dart';
import 'package:ToGather/utilities/filters/filters.dart';

class PlaceQueryParameters extends LocationModelQueryParameters<Place> {
  final bool? recommended;
  final bool? trend;
  final Category? category;
  final List<String>? tags;

  const PlaceQueryParameters(
      {super.searchQuery,
      super.mapController,
      this.recommended,
      this.trend,
      this.category,
      this.tags});

  @override
  List<String?> get fieldsToStr => [
        fieldStringify<bool>(
            trend, (field) => 'page_type=${field ? "trend" : "regular"}'),
        fieldStringify<bool>(recommended,
            (field) => 'page_type=${field ? "recommended" : "regular"}'),
        fieldStringify<List<String>>(
            tags, (field) => 'tags__name=' + field.join(',')),
        fieldStringify<Category>(category, (field) => 'category=${field.id}'),
      ];
}
