import 'package:ToGather/organizations/clubs/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';

abstract class ClubModelService extends ModelService<Club> {
  Future<bool?> join({required ItemParameters itemParameters});
}