import 'package:ToGather/sharables/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';

abstract class CommentModelService extends ModelService<Comment> {
  Future<double?> rate({required ItemParameters itemParameters, required double? score});
}