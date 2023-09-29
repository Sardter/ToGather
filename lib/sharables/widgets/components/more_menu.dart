import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/utilities/services/language.dart' as ls;
import 'package:ToGather/utilities/services/theme.dart';
import 'package:ToGather/sharables/models/models.dart';



class MoreMenu extends StatelessWidget {
  MoreMenu(
      {Key? key,
      required this.actions,
      required this.sharable})
      : super(key: key);
  final List<String> actions;
  final Sharable sharable;
  final textEditingController = TextEditingController();

  Widget _action(String action, context) {
    switch (action) {
      case 'delete':
        return GestureDetector(
          onTap: () async {
            /* if (sharable is Comment) {
              final _confirmed = await launchConfirmationDialog(context,
                  LanguageService().data.sharable.deleteCommentConfirmation);
              if (_confirmed != null && _confirmed)
                API().deleteComment(context, commentId!);
            } else {
              final _confirmed = await launchConfirmationDialog(context,
                  LanguageService().data.sharable.deletePostConfirmation);
              if (_confirmed != null && _confirmed)
                API().deletePost(context, postId);
            } */
          },
          child: Row(
            children: [
              Icon(
                LineIcons.trash,
                color: ThemeService.eventColor,
              ),
              SizedBox(width: 10),
              Text(ls.LanguageService().data.sharable.delete)
            ],
          ),
        );
      case 'report':
        return GestureDetector(
          onTap: () async {
            /* if (sharable == SharableType.Comment) {
              final _confirmed = await launchTextConfirmationDialog(
                  context,
                  "Yorumu adminlere şikayet et",
                  textEditingController,
                  "Problem nedir?");
              if (_confirmed != null && _confirmed)
                API().reportComment(
                    context, commentId!, textEditingController.text);
            } else {
              final _confirmed = await launchTextConfirmationDialog(
                  context,
                  "Gönderiyi adminlere şikayet et",
                  textEditingController,
                  "Problem nedir?");
              if (_confirmed != null && _confirmed)
                API().reportPost(context, postId, textEditingController.text);
            } */
          },
          child: Row(
            children: [
              Icon(
                Icons.report,
                color: ThemeService.eventColor,
              ),
              SizedBox(width: 10),
              Text("Şikayet et")
            ],
          ),
        );
      case 'hide':
        return GestureDetector(
         /*  onTap: () => API().toggleHidden(
              sharable == SharableType.Post ? 'post' : 'comment',
              sharable == SharableType.Post ? postId : commentId!), */
          child: Row(
            children: [
              Icon(
                LineIcons.eyeSlash,
                color: ThemeService.eventColor,
              ),
              SizedBox(width: 10),
              Text("Gizle")
            ],
          ),
        );
      case 'update':
        return SizedBox();
      // return Row(
      //   children: const [
      //     Icon(
      //       LineIcons.pen,
      //       color: ThemeService.primaryAppColor,
      //     ),
      //     SizedBox(width: 10),
      //     Text("Update post")
      //   ],
      // );
      default:
        throw Exception("Unexpected action: $action");
    }
  }

  @override
  Widget build(BuildContext context) {
    actions.removeWhere((element) => element == "update");
    actions.add('hide');
    return actions.isEmpty
        ? SizedBox(
            height: 50,
          )
        : PopupMenuButton(
            icon: Icon(
              Icons.more_horiz_outlined,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            itemBuilder: (context) => actions
                .map<PopupMenuItem>(
                    (e) => PopupMenuItem(child: _action(e, context)))
                .toList(),
          );
  }
}
