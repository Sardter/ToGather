import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/utilities/utilities.dart';

class EventHostWidget extends StatelessWidget {
  final Event event;
  const EventHostWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return event.host == null ? const SizedBox() : GestureDetector(
      onTap: event.host == null
          ? null
          : () => launchPage(context, event.host!.detailPage),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            SylvestImageProvider(
              image: event.host!.image,
              defaultImage: null,
              radius: 25,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.host!.title,
                    style: TextStyle(
                        fontFamily: ThemeService.headlineFont, fontSize: 25)),
                if (event.host!.reviewAverage != null)
                  Rating(
                    rating: event.host!.reviewAverage!,
                    ratingCount: null,
                  )
              ],
            ),
            Spacer(),
            IntrinsicHeight(
              child: Row(
                children: [
                  Icon(event.host is EventClubHost
                      ? LineIcons.users
                      : LineIcons.user),
                  if (event.verified) ...[
                    VerticalDivider(),
                    Icon(LineIcons.check)
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
