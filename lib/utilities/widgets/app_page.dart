import 'package:flutter/material.dart';
import 'package:ToGather/utilities/services/theme.dart';

class AppPage extends StatelessWidget {
  const AppPage(
      {Key? key,
      required this.title,
      required this.body,
      this.canPrev = true,
      this.actions = const [],
      this.canPop})
      : super(key: key);
  final String title;
  final Widget body;
  final bool canPrev;
  final Future<bool> Function()? canPop;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: !canPrev
                ? null
                : IconButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      color: ThemeService.unusedColor,
                    ),
                    onPressed: () async {
                      if ((canPop != null && (await canPop!())) ||
                          canPop == null) {
                        Navigator.pop(context);
                      }
                    },
                  ),
            actions: actions,
            centerTitle: true,
            title: Text(title,
                style: TextStyle(
                  color: ThemeService.primaryText,
                  fontFamily: ThemeService.headlineFont,
                )),
          ),
          body: body,
        ),
        onWillPop: canPop);
  }
}
