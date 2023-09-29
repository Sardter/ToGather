import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';

class PostAPIModelService extends APIModelService<Post>
    implements PostModelService {
  @override
  String get url => URLManager.posts;

  @override
  String get modelType => "Post";

  Future<Map?> _rate(
      {required ItemParameters itemParameters, required double? score}) async {
    return await api.actionAndGetResponseItems(
        url: URLManager.posRate(itemParameters.id!),
        action: APIAction.Post,
        body: {'rate': score});
  }

  @override
  Future<double?> rate(
      {required ItemParameters itemParameters, required double? score}) async {
    return (await _rate(itemParameters: itemParameters, score: score))?['rate'];
  }
}
