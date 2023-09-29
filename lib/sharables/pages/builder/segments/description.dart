import 'package:ToGather/users/users.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';

class CreatePostDescriptionSegment extends StatefulWidget
    implements CreatePageSegment {
  const CreatePostDescriptionSegment(
      {super.key, required this.descriptionController, required this.user});
  final CreatePostDescriptionController descriptionController;
  final Profile user;

  @override
  State<CreatePostDescriptionSegment> createState() =>
      _CreatePostDescriptionSegmentState();

  @override
  IconData get icon => Icons.article;

  @override
  String get label => "Detaylar";
}

class _CreatePostDescriptionSegmentState
    extends State<CreatePostDescriptionSegment> {
  final _userSearchKey = GlobalKey<UserTagSearchState>();
  late final UserTagSearchController _userSearchController =
      UserTagSearchController(onSelect: (user) {
    final index = contentController.text.lastIndexOf('@');
    contentController.text =
        "${contentController.text.substring(0, index)}@${user.username} ";
    contentController.selection = TextSelection.fromPosition(
        TextPosition(offset: contentController.text.length));
    _userSearchController.query.value = null;
    setState(() {});
  });

  bool get searchForUsers =>
      contentController.text.isNotEmpty &&
      contentController.text.split(' ').last.startsWith('@');

  String? get userSearchQuery =>
      searchForUsers ? contentController.text.split('@').last : null;

  TextEditingController get contentController =>
      widget.descriptionController.contentControlller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          RoundedTextField(
              type: TextInputType.text,
              controller: widget.descriptionController.titleController,
              hint: "Başlık"),
          const SizedBox(height: 15),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              RoundedTextField(
                type: TextInputType.multiline,
                controller: widget.descriptionController.contentControlller,
                hint: "İçerik",
                isMultiLine: true,
                onChanged: (value) {
                  print(_userSearchKey.currentState);
                  _userSearchController.query.value = userSearchQuery;
                  _userSearchKey.currentState?.onSearch();
                },
                minLines: 10,
              ),
              ValueListenableBuilder<String?>(
                  valueListenable: _userSearchController.query,
                  builder: (context, value, _) => value == null
                      ? SizedBox()
                      : UserTagSearch(
                          key: _userSearchKey,
                          controller: _userSearchController,
                          height: 100,
                        ))
            ],
          ),
          const SizedBox(height: 15),
          BuilderSelectedClub(
              user: widget.user,
              state: BuilderSelectedClubState.Post,
              notifier: widget.descriptionController.selectedClub),
          const SizedBox(height: 15),
          BuilderSelectedEvent(
              user: widget.user,
              notifier: widget.descriptionController.selectedEvent),
          const SizedBox(height: 15),
          SylvestCheckBox(
              children: [
                Icon(Icons.people),
                const SizedBox(width: 10),
                Text("Arkadaşlara Özel")
              ],
              controller:
                  widget.descriptionController.isPrivateCheckBoxController),
          const SizedBox(height: 15),
          SylvestCheckBox(
              children: [
                Icon(Icons.visibility_off),
                const SizedBox(width: 10),
                Text("Anonim Paylaşım")
              ],
              controller:
                  widget.descriptionController.isAonymousCheckBoxController),
          EdittableTags(controller: EditableTagsController(), showTitle: false),
        ],
      ),
    );
  }
}
