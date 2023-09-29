import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/sharables/models/models.dart';
import 'package:ToGather/sharables/widgets/widgets.dart';

class PlacePosts extends StatefulWidget implements PageData {
  const PlacePosts({super.key});

  @override
  State<PlacePosts> createState() => _PlacePostsState();

  @override
  IconData get icon => Icons.grid_3x3;

  @override
  String get title => "Gönderiler";
}

class _PlacePostsState extends State<PlacePosts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizantalItemNavigator<Post>(
            modelService: ModelServiceFactory.POST,
            label: "Yönetici Paylaşımları",
            mapper: (post) => SearchPost(post: post)),
      ],
    );
  }
}
