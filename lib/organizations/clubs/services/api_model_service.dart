import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/utilities/utilities.dart';

class ClubAPIModelService extends APIModelService<Club>
    implements ClubModelService {
  @override
  String get url => URLManager.clubs;

  @override
  String get modelType => "Club";

  Future<bool?> _join({required ItemParameters itemParameters}) async {
    return await api.actionAndGetResponseItems(
        url: URLManager.clubJoin(itemParameters.id!), action: APIAction.Post);
  }

  @override
  Future<bool?> join({required ItemParameters itemParameters}) {
    return _join(itemParameters: itemParameters);
  }
}
