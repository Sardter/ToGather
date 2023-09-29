import 'package:ToGather/modals/modals.dart';
import 'package:ToGather/users/filters/query_params.dart';
import 'package:ToGather/users/users.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/utilities/utilities.dart';

class ClubMembers extends StatefulWidget {
  const ClubMembers({Key? key, required this.club, required this.me})
      : super(key: key);
  final Club club;
  final Profile? me;

  @override
  State<ClubMembers> createState() => _ClubMembersState();
}

class _ClubMembersState extends State<ClubMembers> {
  final _profileManager = ModelServiceFactory.PROFILE;

  List<Profile> _members = [];
  List<Profile> _freinds = [];
  int _memberCount = 0;
  int _friendsCount = 0;
  bool _isLoading = false;

  Future<void> _getMembers() async {
    setState(() {
      _isLoading = true;
    });

    _members = (await _profileManager.getList(
            queryParameters:
                ProfileQueryParameters(clubMembers: widget.club))) ??
        [];

    _freinds = widget.me == null
        ? []
        : (await _profileManager.getList(
                queryParameters: ProfileQueryParameters(
                    clubMembers: widget.club, connections: widget.me))) ??
            [];

    _memberCount = (await _profileManager.getListCount(
            queryParameters: ProfileQueryParameters(
                clubMembers: widget.club))) ??
        0;
    _friendsCount = widget.me == null
        ? 0
        : (await _profileManager.getListCount(
                queryParameters: ProfileQueryParameters(
                    clubMembers: widget.club, connections: widget.me))) ??
            0;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getMembers();
    });
  }

  @override
  Widget build(BuildContext context) {
    double stackPadd = 0;
    return GestureDetector(
      onTap: () async {
        await launchModal(
            context,
            ClubMembersPage(
              club: widget.club,
            ));
      },
      child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: ThemeService.secondaryText, fontSize: 17),
                      children: [
                    TextSpan(text: LanguageService().data.club.members),
                    TextSpan(text: " - "),
                    TextSpan(text: "$_memberCount Kişi")
                  ])),
              const SizedBox(height: 10),
              if (_isLoading)
                LoadingIndicator()
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (_friendsCount != 0) ...[
                      SizedBox(
                        width: 100,
                        height: 40,
                        child: Stack(
                          children: _freinds
                              .take(3)
                              .map((e) => Positioned(
                                  left: stackPadd += 20,
                                  child: SylvestImageProvider(
                                      image: e.profileImage,
                                      defaultImage: /*DefaultImageManager.user*/
                                          null)))
                              .toList(),
                        ),
                      ),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style:
                                  TextStyle(color: ThemeService.secondaryText),
                              children: [
                                TextSpan(
                                    text:
                                        "${_friendsCount - 3 <= 0 ? '' : 've ${_friendsCount - 3}'} arkadaşın",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(text: "\nbu topluluğa üye")
                              ])),
                    ],
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: _members
                              .take(8)
                              .map((e) => SylvestImageProvider(
                                  image: e.profileImage,
                                  radius: ((MediaQuery.of(context).size.width *
                                              0.35) /
                                          8) -
                                      5,
                                  defaultImage: /*DefaultImageManager.user*/
                                      null))
                              .toList(),
                        )),
                  ],
                ),
            ],
          )),
    );
  }
}
