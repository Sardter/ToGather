import 'package:ToGather/organizations/models/organization.dart';
import 'package:ToGather/sharables/filters/post_query_params.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/sharables/models/models.dart';
import 'package:ToGather/sharables/widgets/widgets.dart';

class OrganizationPosts extends StatefulWidget implements PageData {
  const OrganizationPosts({super.key, required this.organization});
  final Organization organization;

  @override
  State<OrganizationPosts> createState() => _OrganizationPostsState();

  @override
  IconData get icon => Icons.grid_3x3;

  @override
  String get title => "Gönderiler";
}

class _OrganizationPostsState extends State<OrganizationPosts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizantalItemNavigator<Post>(
            modelService: ModelServiceFactory.POST,
            label: "Yönetici Paylaşımları",
            queryParameters: PostQueryParameters(
              clubAuthors: widget.organization as Club
            ),
            mapper: (post) => SearchPost(post: post)),
        HorizantalItemNavigator<Post>(
            modelService: ModelServiceFactory.POST,
            label: "Yeni Gönderiler",
            queryParameters: PostQueryParameters(
              club: widget.organization as Club
            ),
            mapper: (post) => SearchPost(post: post)),
        HorizantalItemNavigator<Post>(
            modelService: ModelServiceFactory.POST,
            label: "Popüler Gönderiler",
            queryParameters: PostQueryParameters(
              club: widget.organization as Club,
              trending: true
            ),
            mapper: (post) => SearchPost(post: post)),
      ],
    );
  }
}
