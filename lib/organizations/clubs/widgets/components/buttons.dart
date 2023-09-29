import 'package:ToGather/organizations/places/places.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/organizations/models/organization.dart';
import 'package:ToGather/utilities/utilities.dart';

class OrganizationButtons extends StatefulWidget {
  const OrganizationButtons({
    super.key,
    required this.organization,
  });

  final Organization organization;

  @override
  State<OrganizationButtons> createState() => _OrganizationButtonsState();
}

class _OrganizationButtonsState extends State<OrganizationButtons> {
  Future<void> _addPost() async {
    // launchPage(context, PostBuilderPage());
  }

  Future<void> _addEvent() async {
    // launchPage(context, PostBuilderPage());
  }

  bool get _isInitiallyJoined =>
      widget.organization is Club &&
      ((widget.organization as Club).requestData?.isJoined ?? false);

  late bool _isJoined = _isInitiallyJoined;

  Future<bool> _joinClub() async {
    final result = await ModelServiceFactory.CLUB
        .join(itemParameters: ItemParameters(id: widget.organization.id));

    print("joined: $result");
    if (result != null) _isJoined = result;
    setState(() {});

    return _isJoined;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.organization is Club)
          SylvestButton(
              initialActivation: _isInitiallyJoined,
              children: [
                Icon(_isJoined ? LineIcons.userMinus : LineIcons.userPlus),
                Text(_isInitiallyJoined
                    ? "  " + LanguageService().data.club.joined
                    : "  " + LanguageService().data.club.join)
              ],
              onTap: _joinClub),
        SylvestIconButton(
            title: LanguageService().data.titles.post,
            icon: LineIcons.shareSquareAlt,
            onTap: _addPost,
            display: widget.organization is Club
                ? (widget.organization as Club)
                        .requestData
                        ?.allowedActions
                        .canPost ??
                    false
                : (widget.organization as Place)
                    .requestData
                    .allowedActions
                    .canPost),
        SylvestIconButton(
            title: LanguageService().data.titles.event,
            icon: Icons.calendar_month,
            display: widget.organization is Club &&
                ((widget.organization as Club)
                        .requestData
                        ?.allowedActions
                        .canEvent ??
                    false),
            onTap: _addEvent),
        ShareButton(
            shareableId: widget.organization.id,
            type: LinkType.Club,
            showTitle: true),
      ],
    );
  }
}
