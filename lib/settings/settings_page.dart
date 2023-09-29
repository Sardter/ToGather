import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/utilities/utilities.dart';

class SettingsPage extends StatelessWidget {
  final void Function(int page) setPage;

  const SettingsPage({required this.setPage});

  @override
  Widget build(BuildContext context) {
    return AppPage(
        title: LanguageService().data.pages.settings,
        body: ListView(
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          children: <Widget>[
            SettingOption(
                title: LanguageService().data.user.logout,
                iconData: Icons.logout,
                onTap: () async {
                  //await APIService().getLogoutResponse(context);
                  Navigator.pop(context);
                  setPage(0);
                }),
            SettingOption(
                title: "Hesabını sil",
                iconData: LineIcons.userSlash,
                onTap: () async {
                  final _confirmed = await launchConfirmationDialog(context,
                  "Hesabını silmek istediğine emin misin?");
                  if (_confirmed == null || !_confirmed)
                    return;
                  //await APIService().deleteAccount(context);
                  Navigator.pop(context);
                  setPage(0);
                }),
            SettingOption(
                title: "Uygulama Tanıtım Sayfası",
                iconData: LineIcons.question,
                onTap: () async {
                  //await APIService().showIntroTutorial(context, launchAnyway: true);
                })
          ],
        ));
  }
}

class SettingOption extends StatelessWidget {
  const SettingOption(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.onTap})
      : super(key: key);
  final String title;
  final IconData iconData;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: SylvestCard(
          padding: const EdgeInsets.all(15),
          child: IntrinsicHeight(
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Icon(iconData, color: ThemeService.eventColor),
                const VerticalDivider(
                  width: 30,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          )),
    );
  }
}
