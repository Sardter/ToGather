import 'package:flutter/material.dart';
import 'package:ToGather/utilities/services/storage.dart';
import 'package:ToGather/tutorial/models/tutorial_data.dart';
import 'package:ToGather/utilities/util_functions.dart';
import 'package:ToGather/tutorial/pages/tutorials_page.dart';

class TutorialService {
  final _storage = StorageService();
  final _storageKey = "tutorial_data";

  SylvestTutorialData? _tutorialData;

  bool get isTutorialCompleted => _tutorialData != null;

  Future<SylvestTutorialData?> get tutorialData async {
    if (this._tutorialData != null) {
      return this._tutorialData;
    }
    final stored = await _storage.getItem(_storageKey);
    if (stored == null) return null;
    _tutorialData = SylvestTutorialData.fromJson(stored);
    return _tutorialData;
  }

  Future<bool> get _mustLaunch async =>
      (await tutorialData) == null ||
      !ifNullThenFalseElse((await tutorialData)?.kvkkAgreed) ||
      !ifNullThenFalseElse((await tutorialData)?.eulaAgreed) ||
      !ifNullThenFalseElse((await tutorialData)?.introCompleted);

  Future<void> launchIntroductionTutorial(BuildContext context,
      {bool launchIfCompleted = false}) async {
    if (!await _mustLaunch && !launchIfCompleted) return;
    _tutorialData = await launchPage<SylvestTutorialData?>(
        context,
        TutorialsPage(
            kvkkToggled: _tutorialData?.kvkkAgreed ?? false,
            eulaToggled: _tutorialData?.eulaAgreed ?? false));

    if (_tutorialData != null)
      await _storage.setItem(_storageKey, _tutorialData!.toJson());
  }

  void clear() async => _storage.deleteItem(_storageKey);
}
