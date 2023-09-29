import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class UniversityAPIModelService extends APIModelService<University> {
  @override
  String get url => URLManager.universities;
  
  @override
  String get modelType => "University";
}