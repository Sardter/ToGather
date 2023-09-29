import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

List<ActionData> defaultProfileActionMapper(
    ValueNotifier<Profile?> user, BuildContext context) {
  return user.value == null
      ? []
      : [
          ActionData(
              icon: LineIcons.user,
              title: "Profili görüntüle",
              onTap: () => launchPage(
                  context,
                  UserPage(
                    setPage: (i) {},
                    id: user.value!.id,
                  ))),
          if (user.value!.requestData?.allowedActions.canConnect ?? false)
            if (user.value!.requestData!.connectionStatus ==
                ConnectionStatus.NotConnected)
              ActionData(
                  icon: LineIcons.userPlus,
                  title: "İstek Gönder",
                  onTap: () async {
                    final status = await ModelServiceFactory.PROFILE.connect(
                      itemParameters: ItemParameters(id: (user.value)?.id),
                    );

                    await showSylvestSnackbar(
                        context: context,
                        message: status == ConnectionStatus.NotConnected
                            ? "Takip isteği gönderildi"
                            : "Bir şeyler ters gitti",
                        type: status != ConnectionStatus.NotConnected
                            ? DisplayMessageType.Danger
                            : DisplayMessageType.Success);

                    closePage(context);
                  })
            else if (user.value!.requestData!.connectionStatus ==
                ConnectionStatus.Connected)
              ActionData(
                  icon: LineIcons.userMinus,
                  title: "Arkadaşlardan Çıkar",
                  onTap: () async {
                    final status = await ModelServiceFactory.PROFILE.disconnect(
                      itemParameters: ItemParameters(id: (user.value)?.id),
                    );

                    await showSylvestSnackbar(
                        context: context,
                        message: status == ConnectionStatus.NotConnected
                            ? "Takipten çıkarıldı"
                            : "Bir şeyler ters gitti",
                        type: status != ConnectionStatus.NotConnected
                            ? DisplayMessageType.Danger
                            : DisplayMessageType.Success);

                    closePage(context);
                  }),
          if (user.value!.requestData?.allowedActions.canBlock ?? false)
            if (!user.value!.requestData!.isBlocked)
              ActionData(
                  icon: LineIcons.userSlash,
                  title: "Engelle",
                  onTap: () async {
                    final status = await ModelServiceFactory.PROFILE.blockUser(
                      itemParameters: ItemParameters(id: (user.value)?.id),
                    );

                    await showSylvestSnackbar(
                        context: context,
                        message: status == null
                            ? "Bir şeyler ters gitti"
                            : status
                                ? "Engellendi"
                                : "Engelden çıkarıldı",
                        type: status == null
                            ? DisplayMessageType.Danger
                            : DisplayMessageType.Success);

                    closePage(context);
                  })
            else
              ActionData(
                  icon: LineIcons.userSlash,
                  title: "Engelli Kaldır",
                  onTap: () async {
                    final status = await ModelServiceFactory.PROFILE.blockUser(
                      itemParameters: ItemParameters(id: (user.value)?.id),
                    );

                    await showSylvestSnackbar(
                        context: context,
                        message: status == null
                            ? "Bir şeyler ters gitti"
                            : status
                                ? "Engellendi"
                                : "Engelden çıkarıldı",
                        type: status == null
                            ? DisplayMessageType.Danger
                            : DisplayMessageType.Success);

                    closePage(context);
                  })
        ];
}

class ListedUserWidget<T extends Profile?> extends StatelessWidget {
  ListedUserWidget(
      {super.key,
      required T user,
      this.suffix = const [],
      this.actionMapper = defaultProfileActionMapper}) {
    this.user = ValueNotifier<T>(user);
  }
  late final ValueNotifier<T?> user;
  final List<Widget> suffix;
  final List<ActionData> Function(ValueNotifier<T?> user, BuildContext context)
      actionMapper;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T?>(
        valueListenable: user,
        builder: (context, value, child) => value == null
            ? SizedBox()
            : ExpandablePanel(
                theme: ExpandableThemeData(
                    hasIcon: false, tapHeaderToExpand: true),
                header: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SylvestImageProvider(
                          image: value.profileImage,
                          defaultImage: /*DefaultImageManager.user*/ null),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${value.firstName.isEmpty ? value.username : value.firstName} ${value.firstName.isEmpty ? "" : value.lastName}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 20)),
                          Text("@${value.username}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: ThemeService.secondaryText))
                        ],
                      )),
                      ...suffix
                    ],
                  ),
                ),
                collapsed: const SizedBox(),
                expanded: Column(
                  children: actionMapper(user, context)
                      .map(
                        (e) => GestureDetector(
                          onTap: e.onTap,
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Icon(e.icon),
                                const SizedBox(width: 5),
                                Text(e.title)
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ));
  }
}
