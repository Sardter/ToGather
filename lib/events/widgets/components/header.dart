import 'package:ToGather/users/filters/query_params.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/utilities/utilities.dart';

class EventHeader extends StatelessWidget {
  const EventHeader({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(event.title,
              style: TextStyle(
                  fontFamily: ThemeService.headlineFont, fontSize: 25)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (event.category.image != null) ...[
                SylvestImage(
                    image: event.category.image,
                    useDefault: false,
                    width: 20,
                    height: 20,
                    defaultImage: null),
                SizedBox(width: 10)
              ],
              Text(event.category.title)
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: ThemeService.primaryText, indent: 50, endIndent: 50),
          if (event.reviewsAverage != null) Rating(
            rating: event.reviewsAverage!,
            ratingCount: event.ratingCount!,
            queryParameters: ProfileQueryParameters(
              eventRaters: event
            ),
          )
        ],
      ),
    );
  }
}
