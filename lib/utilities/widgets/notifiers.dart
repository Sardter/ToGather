import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

enum DisplayMessageType { Default, Success, Danger }

Future<void> showSylvestSnackbar(
    {required BuildContext context,
    required String message,
    DisplayMessageType type = DisplayMessageType.Default}) async {
  Color _color() {
    switch (type) {
      case DisplayMessageType.Default:
        return ThemeService.menuBackground;
      case DisplayMessageType.Danger:
        return Colors.red;
      case DisplayMessageType.Success:
        return Colors.green;
    }
  }

  final flushbar = Flushbar(
    margin: const EdgeInsets.all(10),
    borderRadius: ThemeService.allAroundBorderRadius,
    backgroundColor: ThemeService.menuBackground,
    backgroundGradient: LinearGradient(colors: [_color(), _color().withOpacity(0.9)]),
    message: message,
    duration: Duration(seconds: 3),
  );

  await flushbar.show(context);

  /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message, style: TextStyle(color: ThemeService.primaryText)),
    backgroundColor: _color(),
  )); */
}

Future<bool?> launchConfirmationDialog(
    BuildContext context, String message) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: ThemeService.allAroundBorderRadius),
            backgroundColor: ThemeService.menuBackground,
            title: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: ThemeService.secondaryText),
                  )),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: ThemeService.eventColor),
                  )),
            ],
          ));
}

Future<bool?> launchTextConfirmationDialog(BuildContext context, String message,
    TextEditingController controller, String hint) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: ThemeService.allAroundBorderRadius),
            backgroundColor: ThemeService.menuBackground,
            title: Text(message),
            content: Container(
              height: 200,
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              child: RoundedTextField(
                  type: TextInputType.multiline,
                  isMultiLine: true,
                  controller: controller,
                  hint: hint,
                  minLines: 2),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: ThemeService.secondaryText),
                  )),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: ThemeService.eventColor),
                  )),
            ],
          ));
}
