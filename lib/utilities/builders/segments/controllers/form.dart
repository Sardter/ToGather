import 'package:ToGather/events/events.dart';
import 'package:ToGather/forms/form_builder/from_builder.dart';
import 'package:ToGather/utilities/utilities.dart';

class BuilderFormController
    extends BuilderSegmentController<List<FormBuilderBlockController>?> {
  BuilderFormController({this.formData, required this.warningsController});

  factory BuilderFormController.fromEvent(
      Event event, BuilderWarningsController builderWarningsController) {
    return BuilderFormController(
        formData: event.formData
            ?.map((e) => FormBuilderBlockController.fromData(e))
            .toList(),
        warningsController: builderWarningsController);
  }

  final BuilderWarningsController warningsController;
  final List<FormBuilderBlockController>? formData;

  late final formBuilderController = FormBuilderController(
      warningsController: warningsController, questionItems: formData);

  late final hasFromCheckBoxController =
      SylvestCheckBoxController(toggled: formData != null);

  @override
  List<FormBuilderBlockController>? get data =>
      isValid ? formBuilderController.questionItems : null;

  @override
  List<String> get errorMesseges => hasFromCheckBoxController.toggled.value
      ? formBuilderController.questionItems
          .expand((element) => element.errorMesseges)
          .toList()
      : [];

  @override
  bool get isValid => hasFromCheckBoxController.toggled.value
      ? formBuilderController.valid
      : true;
}
