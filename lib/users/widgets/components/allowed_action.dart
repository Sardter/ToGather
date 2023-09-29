import 'package:ToGather/users/models/models.dart';
import 'package:ToGather/users/services/services.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';

class ProfileAllowedActionsWidget
    extends AllowedActionsWidget<ProfileAllowedActions, Profile> {
  const ProfileAllowedActionsWidget(
      {super.key,
      required super.actions,
      required super.modelService,
      required super.model});

  @override
  State<AllowedActionsWidget> createState() => AllowedActionsWidgetState();

  @override
  List<ActionData> actionMapper(
      ProfileAllowedActions actions, BuildContext context) {
    return [
      if (actions.canBlock)
        ActionData(
            icon: Icons.person_remove,
            title: "Engelle",
            onTap: () async {
              final blocked = await (modelService as ProfileModelService)
                  .blockUser(itemParameters: ItemParameters(id: model.id));

              await showSylvestSnackbar(
                  context: context,
                  type: blocked == null
                      ? DisplayMessageType.Danger
                      : DisplayMessageType.Default,
                  message: blocked == null
                      ? "Bir şeyler ters gitti"
                      : blocked
                          ? "Üye engellendi. Artık senin bilgilerine erişemeyecek. Eğer engeli kaldırmak istersen tekrar gizle düğmesine bas."
                          : "Engel kaldırıldı.");
            }),
      ...super.actionMapper(actions, context),
    ];
  }
}
