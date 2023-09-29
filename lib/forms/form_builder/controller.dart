import 'package:ToGather/forms/form_builder/from_builder.dart';
import 'package:ToGather/utilities/utilities.dart';

class FormBuilderController {
  final BuilderWarningsController warningsController;
  late final List<FormBuilderBlockController> questionItems;

  FormBuilderController(
      {required this.warningsController,
      List<FormBuilderBlockController>? questionItems}) {
    this.questionItems = questionItems ?? [];
  }

  bool get valid {
    if (questionItems.isEmpty) return false;
    final errors = questionItems.expand((element) => element.errorMesseges);

    errors.forEach((element) {
      warningsController.onError!(element);
    });
    
    return errors.isEmpty;
  }

  List<Map<String, dynamic>> getFormData() {
    return questionItems.map((e) => e.getBlockData.toJson()).toList();
  }
}
