
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/sharables/models/post.dart';
import 'package:ToGather/sharables/widgets/widgets.dart';
import 'package:ToGather/utilities/utilities.dart';

import 'status_item.dart';

class ProfileStatus extends StatefulWidget {
  final int connections;
  final int posts;
  final int id;

  const ProfileStatus(
      {Key? key,
      required this.connections,
      required this.posts,
      required this.id})
      : super(key: key);

  @override
  State<ProfileStatus> createState() => _ProfileStatusState();
}

class _ProfileStatusState extends State<ProfileStatus> {
  final _postManager = ModelServiceFactory.POST;

  _usersModal(context, String title) {
    /* launchModal(
        context,
        UserListModal(
          title: title,
          behaviour: UserListBehaviour.Unfollwable,
          filter: UserManagerFilter(connectedTo: widget.id),
        )); */
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
              onTap: () => _usersModal(
                  context, LanguageService().data.titles.connections),
              child: ProfileStatusItem(
                  LanguageService().data.titles.connections,
                  widget.connections,
                  LineIcons.userFriends)),
          GestureDetector(
              child: ProfileStatusItem(LanguageService().data.titles.posts,
                  widget.posts, LineIcons.shareSquare),
              onTap: () async => launchPage(
                  context,
                  FilteredPage<Post>(
                      manager: _postManager,
                      mapper: (post) => PostWidget(
                          data: post,
                          isDetail: false,
                          onCommentSelected: (a, b) {}),
                      header: null)))
        ],
      ),
    );
  }
}
