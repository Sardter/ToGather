import 'package:ToGather/utilities/builders/builders.dart';

class BuilderWarningsController {
  List<BuilderWarning> warnings = [];
  void Function(String errorMessage)? onError;
}
