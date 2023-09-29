import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/models/models.dart';
import 'package:ToGather/organizations/clubs/pages/pages.dart';
import 'package:ToGather/utilities/utilities.dart';

class ClubIndicator extends StatelessWidget {
  final Club data;
  final String? title;

  const ClubIndicator({required this.data, this.title});

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () => launchPage(context, ClubPage(id: data.id)),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.white10,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset.fromDirection(2))
            ],
            color: ThemeService.eventColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: SylvestImageProvider(
                defaultImage: /*DefaultImageManager.clubLogo*/ null,
                image: data.image,
                radius: 12,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: ThemeService.headlineFont)),
                if (title != null) Text(title!, style: TextStyle(fontSize: 9))
              ],
            ),
          ],
        ),
      ),
    );
  }
}