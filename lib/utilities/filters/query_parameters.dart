import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';

class QueryParameters<T extends Model> {
  final String? searchQuery;
  final int pageSize;
  final bool notHidden;

  const QueryParameters(
      {required this.searchQuery,
      this.pageSize = 10,
      this.notHidden = false});

  String fieldStringify<K>(K? field, String Function(K field) toStr) {
    if (field == null) return "";
    return toStr(field);
  }

  List<String?> get defaultFieldsToStr => [
        fieldStringify<String>(searchQuery, (field) => "search_text=$field"),
        fieldStringify<int>(pageSize, (field) => "page_size=$field"),
        fieldStringify<bool>(notHidden,
            (field) => "filter_mode=${!field ? 'regular' : 'hidden'}"),
        ...fieldsToStr
      ];

  @protected
  List<String?> get fieldsToStr => [];

  String toString() {
    return defaultFieldsToStr.where((element) => element != null && element.isNotEmpty).join('&');
  }
}

abstract class LocationModelQueryParameters<T extends LocationModel>
    extends QueryParameters<T> {
  final MapController? mapController;

  const LocationModelQueryParameters(
      {required super.searchQuery,
      required this.mapController,
      int? pageSize,
      super.notHidden})
      : super(pageSize: mapController == null ? pageSize ?? 10 : 1000);

  String? calculateCorners() {
    LatLngBounds? bounds = mapController?.bounds;

    if (bounds == null) return null;

    return "latitude__gte=${bounds.south}&latitude__lte=${bounds.north}&longitude__gte=${bounds.west}&longitude__lte=${bounds.east}";
  }

  List<String?> get defaultFieldsToStr => [
        fieldStringify<String>(calculateCorners(), (field) => field),
        ...super.defaultFieldsToStr
      ];
}
