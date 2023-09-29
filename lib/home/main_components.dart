import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/utilities/utilities.dart';

class SmallProfileImage extends StatelessWidget {
  final ImageData? imageData;
  final Color color;
  const SmallProfileImage(this.imageData, this.color);

  factory SmallProfileImage.fromJson(Map json, Color color) {
    return SmallProfileImage(json['image'], color);
  }

  @override
  Widget build(BuildContext context) {
    if (imageData == null) {
      return Icon(LineIcons.user, color: color);
    } else {
      return SylvestImageProvider(
        defaultImage: /*DefaultImageManager.user*/ null,
        radius: 14,
        image: imageData,
      );
    }
  }
}

class LoadingDetailPage extends StatefulWidget {
  const LoadingDetailPage({Key? key}) : super(key: key);

  @override
  State<LoadingDetailPage> createState() => _LoadingDetailPageState();
}

class _LoadingDetailPageState extends State<LoadingDetailPage> {
  bool _show404 = false;

  void _showError() {
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        _show404 = true;
      });
    });
  }

  @override
  void initState() {
    _showError();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => closePage(context),
            icon: Icon(
              LineIcons.angleLeft,
              color: ThemeService.eventColor,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingIndicator(),
          if (_show404) ...[
            SizedBox(height: 10),
            Text(
              LanguageService().data.errors.notFound,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: ThemeService.unusedColor),
            )
          ]
        ],
      ),
    );
  }
}