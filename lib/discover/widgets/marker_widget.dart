import 'package:flutter/material.dart';
import 'package:ToGather/category/category.dart';
import 'package:ToGather/utilities/utilities.dart';

class MarkerWidget extends StatelessWidget {
  const MarkerWidget(
      {super.key,
      required this.size,
      required this.icon,
      required this.title,
      this.image,
      this.showTitle = true,
      this.category,
      required this.color});
  final double size;
  final IconData icon;
  final String title;
  final ImageData? image;
  final Color color;
  final Category? category;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.location_pin, size: size, color: color),
              Positioned(
                child: Container(
                  decoration:
                      BoxDecoration(color: color, shape: BoxShape.circle),
                  width: size * 0.7,
                  height: size * 0.7,
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    decoration: BoxDecoration(
                        color: color,
                        image: image == null
                            ? null
                            : DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    (image as NetworkImageData).url)),
                        shape: BoxShape.circle),
                    width: size * 0.6,
                    height: size * 0.6,
                    child: Icon(
                      icon,
                      color: ThemeService.onContrastColor,
                    ),
                  ),
                ),
                top: size * 0.05,
              ),
              if (category != null)
                Positioned(
                    top: 0,
                    left: 7,
                    child: SylvestImage(
                        useDefault: false,
                        width: size * 0.4,
                        height: size * 0.4,
                        image: category!.image,
                        defaultImage: null))
            ],
          ),
          if (showTitle) Container(
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: ThemeService.allAroundBorderRadius),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontSize: 10, color: ThemeService.onContrastColor),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
