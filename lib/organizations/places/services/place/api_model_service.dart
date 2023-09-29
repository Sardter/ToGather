import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/utilities/utilities.dart';

class PlaceAPIModelService extends APIModelService<Place> {
  @override
  String get url => URLManager.places;
  
  @override
  String get modelType => "Place";
}
