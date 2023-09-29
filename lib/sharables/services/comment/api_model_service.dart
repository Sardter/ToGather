import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';

class CommentAPIModelService extends APIModelService<Comment>
    implements CommentModelService {
  @override
  String get url => URLManager.comments;

  @override
  String get modelType => "Comment";

  Future<Map?> _rate(
      {required ItemParameters itemParameters, required double? score}) async {
    return await api.actionAndGetResponseItems(
        url: URLManager.commenRate(itemParameters.id!),
        action: APIAction.Post,
        body: {'rate': score});
  }

  @override
  Future<double?> rate(
      {required ItemParameters itemParameters, required double? score}) async {
    return (await _rate(itemParameters: itemParameters, score: score))?['rate'];
  }
}
