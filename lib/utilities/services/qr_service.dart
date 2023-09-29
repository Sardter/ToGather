import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ToGather/utilities/utilities.dart';

class QRWidget extends StatelessWidget {
  const QRWidget({Key? key, required this.data}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return SylvestCard(
        padding: const EdgeInsets.all(20),
        child: ExpandablePanel(
            theme: ExpandableThemeData(hasIcon: false),
            controller: ExpandableController(),
            header: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LanguageService().data.sharable.qrTitle,
                    style: TextStyle(
                        fontSize: 17, fontFamily: ThemeService.headlineFont)),
                Divider(),
                const SizedBox(height: 5),
              ],
            ),
            collapsed: SizedBox(),
            expanded: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LanguageService().data.sharable.qrExplantation,
                    style: TextStyle(color: ThemeService.unusedColor)),
                const SizedBox(height: 15),
                QrImage(
                  padding: EdgeInsets.zero,
                  data: data,
                  version: QrVersions.auto,
                )
              ],
            )));
  }
}
