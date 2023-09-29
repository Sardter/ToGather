import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/utilities/utilities.dart';

class ClubWidget extends StatefulWidget {
  final Club club;

  const ClubWidget({required this.club});

  @override
  State<ClubWidget> createState() => _ClubWidgetState();
}

class _ClubWidgetState extends State<ClubWidget> {
  late Club _data = widget.club;

  final _eventManager = ModelServiceFactory.EVENT;

  Column _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        OrganizationBanner(data: _data),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrganizationStats(
                        hasMedia: false,
                        context: context,
                        data: _data,
                        eventManager: _eventManager),
                    const SizedBox(height: 10),
                    OrganizationButtons(organization: widget.club),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(context) {
    return FutureBuilder<bool>(
      //future: APIService().isHidden('club', widget.club.id),
      builder: (c, s) {
        if (s.hasData && s.data!) {
          return HiddenItem(type: 'club', id: widget.club.id);
        }
        return _content();
      },
      future: null,
    );
  }
}
