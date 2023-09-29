import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/utilities/utilities.dart';
import '../models/models.dart';
import 'components/components.dart';

class ProfileWidget extends StatelessWidget {
  final Profile data;
  final void Function(int) setPage;

  ProfileWidget({required this.data, required this.setPage});

  Widget _blockedWidget() {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(LineIcons.userSlash, color: ThemeService.unusedColor),
          Text(
            "Kullanıcı sizin tarafınızdan engellendi",
            style: TextStyle(color: ThemeService.unusedColor),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      //future: APIService().isHidden('user', data.id),
      builder: (c, s) {
        if (s.hasData && s.data!) {
          return HiddenItem(type: 'user', id: data.id);
        }
        return Column(
          children: <Widget>[
            if (data.images.isNotEmpty)
              SylvestMediaCarousal(media: data.images),
            ProfileInfo(data: data),
            if (data.requestData?.isBlocked ?? false) _blockedWidget(),
            ProfileButtons(
              data: data,
              setPage: setPage,
            ),
            const SizedBox(height: 5)
          ],
        );
      },
      future: null,
    );
  }
}
