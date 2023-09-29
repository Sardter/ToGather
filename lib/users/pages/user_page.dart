import 'package:ToGather/users/widgets/components/allowed_action.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class UserPage extends StatefulWidget {
  final int? id;
  final String? username;
  final bool isProfile;
  final void Function(int page) setPage;

  const UserPage(
      {Key? key,
      this.id,
      this.isProfile = false,
      required this.setPage,
      this.username})
      : assert((isProfile && id == null) ||
            (!isProfile && id != null) ||
            (!isProfile && username != null)),
        super(key: key);

  @override
  UserPageState createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  Profile? _user;

  Future<List<Widget>?> _onRefresh() async {
    _user = widget.isProfile
        ? await ModelServiceFactory.PROFILE.getCurrentUser(context)
        : await ModelServiceFactory.PROFILE
            .getItem(itemParameters: ItemParameters(id: widget.id));
    if (_user == null) {
      if (widget.isProfile)
        widget.setPage(0);
      else
        closePage(context);
      return null;
    }

    setState(() {});

    return [
      ProfileWidget(data: _user!, setPage: widget.setPage),
      PagesTab(pages: [
        UserDetails(profile: _user!),
        UserClubs(profile: _user!),
        UserEvents(profile: _user!),
        UserPosts(profile: _user!)
      ]),
      const SizedBox(height: 60),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isProfile
          ? null
          : AppBar(
              actions: [
                if (_user != null && _user!.requestData != null)
                  ProfileAllowedActionsWidget(
                      model: _user!,
                      modelService: ModelServiceFactory.PROFILE,
                      actions: _user!.requestData!.allowedActions)
              ],
            ),
      body: RefreshablePage(
        onRefresh: _onRefresh,
      ),
    );
  }
}
