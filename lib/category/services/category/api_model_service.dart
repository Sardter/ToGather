import 'package:ToGather/category/models/category.dart';
import 'package:ToGather/utilities/services/services.dart';

class CategoryAPIModelService extends APIModelService<Category> {
  @override
  String get url => URLManager.categories;
  
  @override
  String get modelType => "Category";
}