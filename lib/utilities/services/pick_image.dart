import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;
import 'package:ToGather/utilities/services/language.dart';
import 'dart:async';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class DefaultImageManager {
  /* static final String baseUrl = URLManager.defaultMedia;

  static final String appLogo = baseUrl + "logo.png";

  static final String user = baseUrl + "user.png";
  static final String anonUser = baseUrl + "anon.png";

  static final String clubLogo = baseUrl + "club_logo.png";
  static final String clubBanner = baseUrl + "club_banner.png";

  static final String activtyLogo = baseUrl + "activity.png";
  static final String eventBanner = baseUrl + "event.png"; */
}

class FileService {
  static Future<void> postFile(
      String url, File file, Map<String, dynamic> fields) async {
    final fileBytes = await file.readAsBytes();
    final mimeType = lookupMimeType(file.path);
    final uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri)
      ..fields.addAll(fields.cast<String, String>())
      ..files.add(http.MultipartFile.fromBytes('file', fileBytes,
          filename: 'önemsiz',
          contentType:
              MediaType(mimeType!.split('/').first, mimeType.split('/').last)));

    // Send the HTTP request
    final response = await request.send();
    print("file uploaded: ${response.statusCode}");
  }

  static Future<Uint8List?> getFileContent(String? url) async {
    if (url == null) return null;
    return (await http.get(Uri.parse(url))).bodyBytes;
  }
}

class ImagePickerService extends FileService {
  final ImagePicker _picker = ImagePicker();
  XFile? _mediaFile;

  Future<List<XFile>> pickMultipleMedia({bool imageOnly = false}) async {
    return imageOnly
        ? await _picker.pickMultiImage()
        : await _picker.pickMultipleMedia();
  }

  Future<void> _pickFromGallery(BuildContext context) async {
    _mediaFile = await _picker.pickImage(source: ImageSource.gallery);
    Navigator.pop(context);
  }

  Future<void> _pickVideo(BuildContext context) async {
    _mediaFile = await _picker.pickVideo(source: ImageSource.gallery);
  }

  Future<void> _pickFromCamera(BuildContext context) async {
    _mediaFile = await _picker.pickImage(source: ImageSource.camera);
    Navigator.pop(context);
  }

  Future<XFile?> getImage(BuildContext context) async {
    await _chooseImageDialog(context);
    return _mediaFile;
  }

  Future<XFile?> getVideo(BuildContext context) async {
    await _pickVideo(context);
    return _mediaFile;
  }

  Future<void> _chooseImageDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                await _pickFromGallery(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10),
                  Icon(LineIcons.photoVideo),
                  Text(
                    LanguageService().data.hints.pickFromGallery,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                await _pickFromCamera(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10),
                  Icon(LineIcons.camera),
                  Text(
                    LanguageService().data.hints.pickFromCamera,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
