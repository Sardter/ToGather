import 'package:ToGather/users/filters/query_params.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/events/models/models.dart';
import 'package:ToGather/events/pages/attendees.dart';
import 'package:ToGather/modals/modals.dart';

import 'package:ToGather/utilities/utilities.dart';

class Attendees extends StatefulWidget {
  const Attendees({
    required this.event,
  });
  final Event event;

  @override
  State<Attendees> createState() => AttendeesState();
}

class AttendeesState extends State<Attendees> {
  List<EventAttendee> _contributors = [];
  bool _loading = false;
  late int _attendees = widget.event.attendees;

  final _manger = ModelServiceFactory.PROFILE;

  Future<void> _getAttendees() async {
    setState(() {
      _loading = true;
    });
    final contributors = await _manger.getList(queryParameters: ProfileQueryParameters(
      eventAttendees: widget.event
    ));

    if (mounted)
      setState(() {
        _contributors =
            contributors!.map((e) => EventAttendee.fromUser(e)).toList();
        _loading = false;
      });
  }

  Future<void> _onAttendeesTap() async {}

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getAttendees();
    });
    super.initState();
  }

  Widget _empty() {
    return SizedBox(
      height: 35,
      child: Center(
        child: Text(
          "Daha kimse yok",
          style: TextStyle(color: ThemeService.secondaryText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _stackXStart = 0;

    return GestureDetector(
      onTap: () {
        launchModal(context, AttendeesPage(event: widget.event));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            const Icon(Icons.people, size: 40),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("$_attendees Katılımcı",
                    style: TextStyle(
                        fontFamily: ThemeService.headlineFont, fontSize: 18)),
                Text("Katımcıları incele",
                    style: TextStyle(
                        color: ThemeService.secondaryText, fontSize: 12)),
                const SizedBox(height: 10),
              ],
            )),
            if (_contributors.isNotEmpty && !_loading)
              Container(
                height: 40,
                width: 140,
                child: GestureDetector(
                  onTap: _onAttendeesTap,
                  child: Stack(
                    children: _contributors
                        .take(5)
                        .map<Widget>(
                          (attendee) => Positioned(
                              left: _stackXStart += 20,
                              child: EventAttendeeWidget(attendee: attendee)),
                        )
                        .toList(),
                  ),
                ),
              )
            else if (_contributors.isEmpty)
              _empty(),
          ],
        ),
      ),
    );
  }
}

class EventAttendeeWidget extends StatelessWidget {
  const EventAttendeeWidget({super.key, required this.attendee});
  final EventAttendee attendee;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: Stack(alignment: Alignment.center, children: [
        SylvestImageProvider(
          defaultImage: /*DefaultImageManager.user*/ null,
          radius: 17.5,
          image: attendee.profileImage,
        ),
        if (attendee.attended)
          Positioned(
              right: 0,
              bottom: 0,
              child: Badge(
                  backgroundColor: Colors.green,
                  label: Icon(
                    LineIcons.check,
                    color: ThemeService.onContrastColor,
                    size: 10,
                  )))
      ]),
    );
  }
}
