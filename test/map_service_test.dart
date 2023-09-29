import 'package:ToGather/discover/services/search_service.dart';

void main() async {
  final service = MapSearchService();

  final result = await service.search("Bilkent");

  print(result);
}