import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/modals/modals.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class RequestsWidget extends StatelessWidget {
  const RequestsWidget({Key? key, required this.requestNum}) : super(key: key);
  final int requestNum;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchModal(context, RequestsPage()),
      child: SylvestCard(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(LineIcons.userPlus),
            const SizedBox(width: 10),
            const Text("Requests"),
            const SizedBox(width: 10),
            badges.Badge(
              badgeStyle:
                  badges.BadgeStyle(badgeColor: ThemeService.eventColor),
              badgeContent: Text(requestNum.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  )),
            ),
            const Spacer(),
            const Icon(LineIcons.angleRight)
          ],
        ),
      ),
    );
  }
}

class ConnectionRequest extends StatefulWidget {
  const ConnectionRequest({Key? key, required this.userData}) : super(key: key);
  final Profile userData;

  @override
  State<ConnectionRequest> createState() => _ConnectionRequestState();
}

class _ConnectionRequestState extends State<ConnectionRequest> {
  bool _loading = false;
  String? _actionState;

  Future<void> _onAccept() async {
    setState(() {
      _loading = true;
    });
    await ModelServiceFactory.PROFILE.connect(itemParameters: ItemParameters(id: widget.userData.id));
    if (mounted)
      setState(() {
        _loading = false;
        _actionState = LanguageService().data.notifications.requestAccepted;
      });
  }

  Future<void> _onDecline() async {
    setState(() {
      _loading = true;
    });
    await ModelServiceFactory.PROFILE.disconnect(itemParameters: ItemParameters(id: widget.userData.id));
    setState(() {
      _loading = false;
      _actionState = LanguageService().data.notifications.requestDeclined;
    });
  }

  Widget _acceptButton() {
    return GestureDetector(
      onTap: _loading ? null : _onAccept,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: ThemeService.eventColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          LineIcons.check,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _declineButton() {
    return GestureDetector(
      onTap: _loading ? null : _onDecline,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          border:
              Border.all(color: ThemeService.eventColor.withOpacity(0.5)),
          shape: BoxShape.circle,
        ),
        child: Icon(
          LineIcons.times,
          color: ThemeService.eventColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchPage(context, UserPage(id: widget.userData.id, setPage: (a) {}));
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            SylvestImageProvider(
              image: widget.userData.profileImage,
              defaultImage: /*DefaultImageManager.user*/ null,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.userData.username),
            Spacer(),
            if (_actionState != null)
              Text(_actionState!,
                  style: TextStyle(color: ThemeService.unusedColor)),
            if (_actionState == null) ...[
              if (!_loading) ...[_acceptButton(), _declineButton()]
              else LoadingIndicator()
            ]
          ],
        ),
      ),
    );
  }
}

class RequestsPage extends StatefulWidget {
  @override
  State<RequestsPage> createState() => RequestsPageState();
}

class RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    return FilteredPage<Profile>(
      mode: FilteredPageMode.Modal,
        manager: ModelServiceFactory.RECIVED_CONNECTIONS,
        mapper: (profile) => ConnectionRequest(userData: profile));
  }
}
