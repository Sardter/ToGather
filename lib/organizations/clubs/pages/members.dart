import 'package:ToGather/users/filters/query_params.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/users/widgets/listed_user.dart';
import 'package:ToGather/utilities/utilities.dart';

class UserWithRole extends StatelessWidget {
  const UserWithRole({super.key, required this.member, required this.club});
  final ClubMember member;
  final Club club;

  @override
  Widget build(BuildContext context) {
    return ListedUserWidget<ClubMember>(
      user: member,
      suffix: [if (member.isAdmin) Icon(LineIcons.userCheck)],
      actionMapper: (user, context) {
        return user.value == null
            ? []
            : [
                if (club.requestData?.allowedActions.canModerate ?? false)
                  if (user.value!.isAdmin)
                    ActionData(
                        icon: LineIcons.userSlash,
                        title: "Yöneticilikten Çıkar",
                        onTap: () {})
                  else
                    ActionData(
                        icon: LineIcons.userSlash,
                        title: "Yönetici Yap",
                        onTap: () {}),
                ...defaultProfileActionMapper(user, context),
              ];
      },
    );
  }
}

class AdminsPage extends StatefulWidget implements PageData {
  const AdminsPage({super.key, required this.club});
  final Club club;

  @override
  State<AdminsPage> createState() => _AdminsPageState();

  @override
  IconData get icon => Icons.shield;

  @override
  String get title => "Yöneticiler";
}

class _AdminsPageState extends State<AdminsPage> {
  final _profileManager = ModelServiceFactory.PROFILE;

  Future<List<Widget>?> _onRefresh() async {
    _profileManager.reset();

    final users = await _profileManager.getList(
            queryParameters: ProfileQueryParameters(clubAdmins: widget.club)) ??
        [];

    return users
        .map((e) => UserWithRole(
              member: ClubMember.fromUser(e, isAdmin: true),
              club: widget.club,
            ))
        .toList();
  }

  Future<List<Widget>?> _onLoad() async {
    if (!_profileManager.next()) return null;

    final users = await _profileManager.getList() ?? [];

    return users
        .map((e) => UserWithRole(
              member: ClubMember.fromUser(e, isAdmin: true),
              club: widget.club,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: RefreshablePage(
        onRefresh: _onRefresh,
        onLoad: _onLoad,
      ),
    );
  }
}

class NonAdminsPage extends StatefulWidget implements PageData {
  const NonAdminsPage({super.key, required this.club});
  final Club club;

  @override
  State<NonAdminsPage> createState() => _NonAdminsPageState();

  @override
  IconData get icon => Icons.people;

  @override
  String get title => "Üyeler";
}

class _NonAdminsPageState extends State<NonAdminsPage> {
  final _profileManager = ModelServiceFactory.PROFILE;

  Future<List<Widget>?> _onRefresh() async {
    _profileManager.reset();

    final users = await _profileManager.getList(
            queryParameters:
                ProfileQueryParameters(clubMembers: widget.club)) ??
        [];

    return users
        .map((e) => UserWithRole(
              member: ClubMember.fromUser(e, isAdmin: false),
              club: widget.club,
            ))
        .toList();
  }

  Future<List<Widget>?> _onLoad() async {
    if (!_profileManager.next()) return null;

    final users = await _profileManager.getList() ?? [];

    return users
        .map((e) => UserWithRole(
              member: ClubMember.fromUser(e, isAdmin: false),
              club: widget.club,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: RefreshablePage(
        onRefresh: _onRefresh,
        onLoad: _onLoad,
      ),
    );
  }
}

class ClubMembersPage extends StatefulWidget {
  const ClubMembersPage({Key? key, required this.club}) : super(key: key);
  final Club club;

  @override
  State<ClubMembersPage> createState() => _ClubMembersPageState();
}

class _ClubMembersPageState extends State<ClubMembersPage> {
  Future<List<Widget>?> _onRefresh() async {
    onRefresh = null;

    setState(() {});

    return [
      PagesTab(pages: [
        AdminsPage(
          club: widget.club,
        ),
        NonAdminsPage(
          club: widget.club,
        )
      ])
    ];
  }

  late Future<List<Widget>?> Function()? onRefresh = _onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: RefreshablePage(
        shrinkWrap: true,
        onRefresh: onRefresh,
      ),
    );
  }
}
