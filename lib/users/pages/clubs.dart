import 'package:ToGather/organizations/clubs/filters/query_params.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/users/users.dart';

class UserClubs extends StatefulWidget implements PageData {
  const UserClubs({super.key, required this.profile});
  final Profile profile;

  @override
  State<UserClubs> createState() => _UserEventsState();

  @override
  IconData get icon => Icons.people;

  @override
  String get title => "Topluluklar";
}

class _UserEventsState extends State<UserClubs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizantalItemNavigator<Club>(
            modelService: ModelServiceFactory.CLUB,
            label: "Yönettiği Topluluklar",
            queryParameters: ClubQueryParameters(
              admin: widget.profile
            ),
            mapper: (event) => SearchClub(club: event)),
        HorizantalItemNavigator<Club>(
            modelService: ModelServiceFactory.CLUB,
            queryParameters: ClubQueryParameters(
              member: widget.profile
            ),
            label: "Katıldığı Topluluklar",
            mapper: (event) => SearchClub(club: event)),
      ],
    );
  }
}