import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/users/pages/builder/controllers/user.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class ProfileButtons extends StatefulWidget {
  final Profile data;
  final void Function(int) setPage;
  ProfileButtons({required this.data, required this.setPage});

  @override
  ProfileButtonsState createState() => ProfileButtonsState();
}

class ProfileButtonsState extends State<ProfileButtons> {
  bool _loading = false;

  late ConnectionStatus _status = widget.data.requestData?.connectionStatus ??
      ConnectionStatus.NotConnected;
  bool get _buttonActivated =>
      widget.data.requestData?.connectionStatus !=
      ConnectionStatus.NotConnected;

  List<Widget> get _buttonItems {
    switch (_status) {
      case ConnectionStatus.Connected:
        return [
          Icon(LineIcons.userCheck),
          Text(" " + LanguageService().data.user.connected)
        ];
      case ConnectionStatus.NotConnected:
        return [
          Icon(LineIcons.userPlus),
          Text(" " + LanguageService().data.user.notConnected)
        ];

      case ConnectionStatus.RequestSent:
        return [
          Icon(LineIcons.userClock),
          Text(" " + LanguageService().data.user.requestSent)
        ];
      case ConnectionStatus.RequestRecieved:
        return [
          Icon(LineIcons.userPlus),
          Text(" " + LanguageService().data.user.requestRecieved)
        ];
      case ConnectionStatus.Me:
        return [
          Icon(Icons.settings),
          Text(" " + LanguageService().data.user.edit)
        ];
    }
  }

  Widget _followButton(bool isProfile) {
    return SylvestButton(
        children: [
          if (_loading) LoadingIndicator(radius: 10) else ..._buttonItems
        ],
        onTap: _loading
            ? null
            : isProfile
                ? _edit
                : _connect,
        initialActivation: _buttonActivated);
  }

  Future<bool> _connect() async {
    setState(() {
      _loading = true;
    });
    ConnectionStatus status = (_status == ConnectionStatus.NotConnected
            ? await ModelServiceFactory.PROFILE
                .connect(itemParameters: ItemParameters(id: widget.data.id))
            : await ModelServiceFactory.PROFILE.disconnect(
                itemParameters: ItemParameters(id: widget.data.id))) ??
        ConnectionStatus.NotConnected;

    setState(() {
      _status = status;
      _loading = false;
    });
    return status != ConnectionStatus.NotConnected;
  }

  Future<bool> _edit() async {
    print("here");
    await launchPage(
        context,
        CreateUserPage(
            controller: CreateProfileController.fromProfile(
                widget.data, ModelServiceFactory.PROFILE)));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: <Widget>[
          _followButton(
              widget.data.requestData?.connectionStatus == ConnectionStatus.Me),
          ShareButton(
              shareableId: widget.data.id,
              type: LinkType.Profile,
              showTitle: true),
        ],
      ),
    );
  }
}
