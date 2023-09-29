import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/users/users.dart';

class UserDetails extends StatefulWidget implements PageData {
  const UserDetails({super.key, required this.profile});
  final Profile profile;

  @override
  State<UserDetails> createState() => _UserDetailsState();

  @override
  IconData get icon => Icons.person;

  @override
  String get title => "Profil";
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileAbout(profile: widget.profile),
        UserInterests(
          interests: widget.profile.interestes,
        ),
        if (widget.profile.links.isNotEmpty)
          LinksWidget(links: widget.profile.links),
      ],
    );
  }
}
