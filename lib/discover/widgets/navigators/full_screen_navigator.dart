import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/category/category.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/sharables/sharables.dart';

import 'navigators.dart';

class FullScreenItemNavigator extends StatefulWidget {
  const FullScreenItemNavigator({super.key});

  @override
  State<FullScreenItemNavigator> createState() =>
      _FullScreenItemNavigatorState();
}

class _FullScreenItemNavigatorState extends State<FullScreenItemNavigator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizantalItemNavigator(
            modelService: ModelServiceFactory.EVENT,
            label: "Trend Etkinlikler",
            mapper: (model) => SearchEvent(event: model as Event)),
        HorizantalItemNavigator(
            modelService: ModelServiceFactory.CLUB,
            label: "Trend Topluluklar",
            mapper: (model) => SearchClub(club: model as Club)),
        HorizantalItemNavigator(
            modelService: ModelServiceFactory.POST,
            label: "Trend Gönderiler",
            mapper: (model) => SearchPost(post: model as Post)),
        Categories(),
        const SizedBox(height: 100,),
      ],
    );
  }
}