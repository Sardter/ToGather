import 'package:ToGather/category/category.dart';
import 'package:ToGather/utilities/services/services.dart';

class TagAPIModelService extends APIModelService<Tag> {
  @override
  String get url => URLManager.tags;
  
  @override
  String get modelType => "Tag";
}