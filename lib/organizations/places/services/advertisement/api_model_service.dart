import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/utilities/utilities.dart';

class PlaceAdvertisementAPIModelService extends APIModelService<PlaceAdvertisement> {
  final Place place;

  PlaceAdvertisementAPIModelService({required this.place});

  @override
  String get url => URLManager.advertisements(place.id);
  
  @override
  String get modelType => "Advertisment";
}