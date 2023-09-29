import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/users/users.dart';

class UserPosts extends StatefulWidget implements PageData {
  const UserPosts({super.key, required this.profile});
  final Profile profile;

  @override
  State<UserPosts> createState() => _UserEventsState();

  @override
  IconData get icon => Icons.grid_3x3;

  @override
  String get title => "Gönderiler";
}

class _UserEventsState extends State<UserPosts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizantalItemNavigator<Post>(
            modelService: ModelServiceFactory.POST,
            queryParameters: PostQueryParameters(
              userPublished: widget.profile
            ),
            label: "Paylaştılan Gönderiler",
            mapper: (event) => SearchPost(post: event)),
        /* HorizantalItemNavigator<Post>(
            modelService: ModelServiceFactory.POST,
            label: "Etiketlenen Gönderiler",
            mapper: (event) => SearchPost(post: event)), */
      ],
    );
  }
}
