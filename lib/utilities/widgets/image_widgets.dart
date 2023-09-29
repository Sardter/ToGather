import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class SylvestImage extends StatelessWidget {
  final ImageData? image;
  final bool useDefault;
  final double? width;
  final double? height;
  final String? defaultImage;
  final BoxFit boxFit = BoxFit.cover;
  final String assetImage = "assets/images/defaultB.jpg";

  const SylvestImage(
      {Key? key,
      required this.image,
      required this.useDefault,
      required this.defaultImage,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image == null && defaultImage == null
        ? Image.asset(
            assetImage,
            fit: boxFit,
            height: height,
            width: width,
          )
        : image != null && image is ImageFileData
            ? Image.file(
                (image as ImageFileData).file,
                fit: BoxFit.cover,
                height: height,
                width: width,
              )
            : CachedNetworkImage(
                imageUrl: (image as NetworkImageData?)?.url ?? defaultImage!,
                fit: BoxFit.cover,
                height: height,
                width: width,
                useOldImageOnUrlChange: true,
                placeholder: (context, url) => useDefault
                    ? Image.asset(
                        assetImage,
                        fit: BoxFit.cover,
                        height: height,
                        width: width,
                      )
                    : Icon(Icons.image),
                errorWidget: (context, url, error) => Image.asset(
                  assetImage,
                  fit: BoxFit.cover,
                  height: height,
                  width: width,
                ),
              );
  }
}

class SylvestImageProvider extends StatelessWidget {
  final ImageData? image;
  final String? defaultImage;
  final double? radius;

  const SylvestImageProvider(
      {Key? key, required this.image, this.radius, required this.defaultImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      foregroundImage: image == null && defaultImage == null
          ? null
          : image is ImageFileData
              ? FileImage((image as ImageFileData).file) as ImageProvider
              : CachedNetworkImageProvider(
                  (image as NetworkImageData?)?.url ?? defaultImage!),
      backgroundImage: AssetImage("assets/images/defaultP.png"),
      backgroundColor: Colors.black12,
      radius: radius,
    );
  }
}

class SylvestVideoThumbnail extends StatefulWidget {
  const SylvestVideoThumbnail(
      {super.key, required this.url, this.height, this.width, this.quality});
  final String url;
  final int? height;
  final int? width;
  final int? quality;

  @override
  State<SylvestVideoThumbnail> createState() => _SylvestVideoThumbnailState();
}

class _SylvestVideoThumbnailState extends State<SylvestVideoThumbnail> {
  Future<Uint8List?> _getThumbnail() async {
    return await VideoThumbnail.thumbnailData(
        video: widget.url,
        maxHeight: widget.height ?? 0,
        maxWidth: widget.width ?? 0,
        quality: widget.quality ?? 10);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _getThumbnail(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
              width: widget.width?.toDouble(),
              height: widget.height?.toDouble());
        }
        return Image.memory(
          snapshot.data!,
          fit: BoxFit.cover,
          height: widget.height?.toDouble(),
          width: widget.width?.toDouble(),
        );
      },
    );
  }
}
