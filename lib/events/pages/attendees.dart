import 'package:ToGather/modals/modals.dart';
import 'package:ToGather/users/filters/query_params.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/organizations/clubs/pages/pages.dart';
import 'package:ToGather/users/widgets/listed_user.dart';
import 'package:ToGather/utilities/utilities.dart';

class AttendeeWidget extends StatelessWidget {
  const AttendeeWidget(
      {super.key, required this.attendee, required this.event});
  final EventAttendee attendee;
  final Event event;

  _onTap(context) async {
    final result = await ModelServiceFactory.EVENT.verifyAttendeeStatus(
        eventParameters: ItemParameters(id: event.id),
        userParameters: ItemParameters(id: attendee.id));

    if (result == null) return;

    closePage(context);
    launchModal(context, AttendeesPage(event: event));
  }

  @override
  Widget build(BuildContext context) {
    return ListedUserWidget<EventAttendee>(
      user: attendee,
      suffix: [
        if (attendee.attended)
          Container(
            decoration:
                BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            child: Icon(
              Icons.check,
              size: 15,
              color: ThemeService.onContrastColor,
            ),
          )
      ],
      actionMapper: (user, context) {
        return [
          if (event.requestData.isHosting)
            if (attendee.attended)
              ActionData(
                  icon: LineIcons.userSlash,
                  title: "Katılımdan Çıkar",
                  onTap: () => _onTap(context))
            else
              ActionData(
                  icon: LineIcons.check,
                  title: "Katılımı Onayla",
                  onTap: () => _onTap(context)),
          ...defaultProfileActionMapper(user, context)
        ];
      },
    );
  }
}

class AttendVerifiedPage extends StatefulWidget implements PageData {
  const AttendVerifiedPage({super.key, required this.event});
  final Event event;

  @override
  State<AttendVerifiedPage> createState() => _AttendVerifiedPageState();

  @override
  IconData get icon => Icons.check;

  @override
  String get title => "Onaylananlar";
}

class _AttendVerifiedPageState extends State<AttendVerifiedPage> {
  final _profileManager = ModelServiceFactory.PROFILE;

  Future<List<Widget>?> _onRefresh() async {
    _profileManager.reset();

    final users = await _profileManager.getList(
            queryParameters:
                ProfileQueryParameters(eventAttendeesAttended: widget.event)) ??
        [];

    return users
        .map((e) => AttendeeWidget(
              attendee: EventAttendee.fromUser(e, attended: true),
              event: widget.event,
            ))
        .toList();
  }

  Future<List<Widget>?> _onLoad() async {
    if (!_profileManager.next()) return null;

    final users = await _profileManager.getList(
            queryParameters:
                ProfileQueryParameters(eventAttendeesAttended: widget.event)) ??
        [];

    return users
        .map((e) => AttendeeWidget(
              attendee: EventAttendee.fromUser(e, attended: true),
              event: widget.event,
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

class AttendUnverifiedPage extends StatefulWidget implements PageData {
  final Event event;
  const AttendUnverifiedPage({super.key, required this.event});

  @override
  State<AttendUnverifiedPage> createState() => _AttendUnverifiedPageState();

  @override
  IconData get icon => Icons.people;

  @override
  String get title => "Katılanlar";
}

class _AttendUnverifiedPageState extends State<AttendUnverifiedPage> {
  final _profileManager = ModelServiceFactory.PROFILE;

  Future<List<Widget>?> _onRefresh() async {
    _profileManager.reset();

    final users = await _profileManager.getList(
            queryParameters: ProfileQueryParameters(
                eventAttendeesUnAttended: widget.event)) ??
        [];

    return users
        .map((e) => AttendeeWidget(
              attendee: EventAttendee.fromUser(e, attended: false),
              event: widget.event,
            ))
        .toList();
  }

  Future<List<Widget>?> _onLoad() async {
    if (!_profileManager.next()) return null;

    final users = await _profileManager.getList(
            queryParameters:
                ProfileQueryParameters(eventAttendeesUnAttended: widget.event)) ??
        [];

    return users
        .map((e) => AttendeeWidget(
              attendee: EventAttendee.fromUser(e, attended: false),
              event: widget.event,
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

class AttendeesPage extends StatefulWidget {
  const AttendeesPage({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  State<AttendeesPage> createState() => _AttendeesPageState();
}

class _AttendeesPageState extends State<AttendeesPage> {
  Future<List<Widget>?> _onRefresh() async {
    onRefresh = null;

    setState(() {});

    return [
      PagesTab(pages: [
        AttendVerifiedPage(
          event: widget.event,
        ),
        AttendUnverifiedPage(
          event: widget.event,
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
