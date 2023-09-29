import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:ToGather/sharables/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';

class AllowedActionsWidget<T extends AllowedActions, K extends Model>
    extends StatefulWidget {
  const AllowedActionsWidget(
      {super.key,
      required this.actions,
      required this.modelService,
      required this.model});
  final T actions;
  final K model;
  final ModelService<K> modelService;

  List<ActionData> actionMapper(T actions, BuildContext context) {
    return [
      if (actions.canUpdate && !(model is Comment) && !(model is FormResponse))
        ActionData(
            icon: Icons.edit,
            title: "Düzenle",
            onTap: () async {
              await launchPage(context, CreatePageFactory(model, modelService));

              closePage(context);
            }),
      if (actions.canDelete)
        ActionData(
            icon: Icons.delete,
            title: "Sil",
            onTap: () async {
              final willDelete = await launchConfirmationDialog(
                  context, "Bunu silmek istediğine emin misin?");

              if (willDelete == null || !willDelete) return;

              final deleted = await modelService.deleteItem(
                  itemParameters: ItemParameters(id: model.id));

              await showSylvestSnackbar(
                  context: context,
                  message:
                      deleted == null ? "Bir şeyler ters gitti" : "Öge silindi",
                  type: deleted == null
                      ? DisplayMessageType.Danger
                      : DisplayMessageType.Default);

              closePage(context);
            }),
      if (actions.canHide)
        ActionData(
            icon: Icons.visibility,
            title: "Gizle",
            onTap: () async {
              final hidden = await modelService.hideItem(
                  itemParameters: ItemParameters(id: model.id));

              await showSylvestSnackbar(
                  context: context,
                  type: hidden == null
                      ? DisplayMessageType.Danger
                      : DisplayMessageType.Default,
                  message: hidden == null
                      ? "Bir şeyler ters gitti"
                      : hidden
                          ? "Öge gizlendi. Bir sonraki yenilemede gözükmeyecek. Eğer gözükmesini istersen tekrar gizle düğmesine bas."
                          : "Öge gizllikten çıkarıldı.");

              closePage(context);
            }),
      if (actions.canReport)
        ActionData(
            icon: Icons.report,
            title: "Bildir",
            onTap: () async {
              final text = TextEditingController();

              final willReport = await launchTextConfirmationDialog(
                  context, "Buradaki problem nedir?", text, "Buraya yaz");

              if (willReport == null || !willReport) return;

              final reported = await modelService.reportItem(
                  itemParameters: ItemParameters(id: model.id),
                  reason: text.text);

              await showSylvestSnackbar(
                  context: context,
                  type: reported == null
                      ? DisplayMessageType.Danger
                      : DisplayMessageType.Default,
                  message: reported == null
                      ? "Öge bildirilemedi"
                      : "Gerekli yetkililere bildirdi");

              closePage(context);
            })
    ];
  }

  @override
  State<AllowedActionsWidget> createState() => AllowedActionsWidgetState();
}

class AllowedActionsWidgetState extends State<AllowedActionsWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.actionMapper(widget.actions, context).isEmpty
        ? const SizedBox()
        : PopupMenuButton(
            icon: Icon(
              Icons.more_horiz_outlined,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            itemBuilder: (context) => widget
                .actionMapper(widget.actions, context)
                .map(
                  (e) => PopupMenuItem(
                    //onTap: e.onTap,
                    child: GestureDetector(
                      onTap: e.onTap,
                      child: Row(
                      children: [
                        Icon(e.icon),
                        const SizedBox(width: 10),
                        Text(e.title)
                      ],
                    ),
                    )
                  ),
                )
                .toList(),
          );
  }
}
