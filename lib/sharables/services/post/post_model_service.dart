import 'package:ToGather/sharables/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';

abstract class PostModelService extends ModelService<Post> {
  Future<double?> rate({required ItemParameters itemParameters, required double? score});
}