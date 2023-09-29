import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/utilities/utilities.dart';

class ClubPage extends StatefulWidget {
  ClubPage({required this.id});
  final int id;

  @override
  State<ClubPage> createState() => ClubPageState();
}

class ClubPageState extends State<ClubPage> {
  Club? _club;

  Future<List<Widget>?> _onRefreshPage() async {
    _club =
        await ModelServiceFactory.CLUB.getItem(itemParameters: ItemParameters(id: widget.id));
    if (_club == null) {
      closePage(context);
      return null;
    }

    setState(() {});

    return [
      ClubWidget(club: _club!),
      PagesTab(pages: [
        ClubDetails(club: _club!),
        OrganizationEvents(club: _club!),
        OrganizationPosts(organization: _club!),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_club?.requestData != null)
            AllowedActionsWidget<AllowedActions, Club>(
              actions: _club!.requestData!.allowedActions,
              model: _club!,
              modelService: ModelServiceFactory.CLUB,
            )
        ],
      ),
      body: RefreshablePage(
        onRefresh: _onRefreshPage,
      ),
    );
  }
}
