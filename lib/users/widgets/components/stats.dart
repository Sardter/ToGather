import 'package:ToGather/modals/modals.dart';
import 'package:ToGather/users/filters/query_params.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/users/widgets/listed_user.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';

class UserStats extends StatelessWidget {
  const UserStats({
    super.key,
    required this.context,
    required Profile data,
  }) : _data = data;

  final BuildContext context;
  final Profile _data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Stats(items: [
        StatsItem(
          icon: Icons.people,
          name: "Arkadaş",
          count: _data.connections,
          onTap: () async {
            launchModal(
              context,
              FilteredPage<Profile>(
                manager: ModelServiceFactory.PROFILE,
                mapper: (user) => ListedUserWidget(user: user),
                mode: FilteredPageMode.Modal,
                queryParameters: ProfileQueryParameters(connections: _data),
              ),
            );
          },
        ),
        StatsItem(
            icon: Icons.grid_3x3,
            name: "Gönderi",
            count: _data.posts,
            onTap: () => launchModal(
                context,
                FilteredPage<Post>(
                    mode: FilteredPageMode.Modal,
                    manager: ModelServiceFactory.POST,
                    queryParameters: PostQueryParameters(userPublished: _data),
                    mapper: (post) => SearchPost(post: post),
                    header: null))),
      ]),
    );
  }
}
