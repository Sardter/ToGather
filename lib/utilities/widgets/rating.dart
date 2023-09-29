import 'package:ToGather/modals/modals.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/users/filters/query_params.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatelessWidget {
  const Rating(
      {super.key,
      required this.rating,
      this.size = 15,
      required this.ratingCount,
      this.queryParameters});

  final double rating;
  final double size;
  final int? ratingCount;
  final ProfileQueryParameters? queryParameters;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: queryParameters == null
          ? null
          : () => launchModal(
              context,
              Raters(
                queryParameters: queryParameters!,
              )),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              initialRating: rating,
              direction: Axis.horizontal,
              allowHalfRating: true,
              ignoreGestures: true,
              itemCount: 5,
              itemSize: size,
              itemBuilder: (context, _) => Icon(
                Icons.favorite,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
            if (ratingCount != null) ...[
              VerticalDivider(),
              Text("$ratingCount",
                  style: TextStyle(
                      color: ThemeService.secondaryText,
                      fontFamily: ThemeService.headlineFont,
                      fontSize: 12))
            ]
          ],
        ),
      ),
    );
  }
}
