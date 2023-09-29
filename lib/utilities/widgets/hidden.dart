import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

class HiddenItem extends StatefulWidget {
  const HiddenItem({Key? key, required this.type, required this.id})
      : super(key: key);
  final String type;
  final int id;

  @override
  State<HiddenItem> createState() => _HiddenItemState();
}

class _HiddenItemState extends State<HiddenItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: () => APIService().toggleHidden(widget.type, widget.id),
      child: SylvestCard(
        height: 200,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Icon(Icons.hide_source, color: ThemeService.unusedColor),
          Text("Gizlendi",
              style: TextStyle(fontSize: 15, color: ThemeService.unusedColor)),
          Text("Geri görmek için tekrar dokun",
              style: TextStyle(fontSize: 9, color: ThemeService.unusedColor))
        ]),
      ),
    );
  }
}
