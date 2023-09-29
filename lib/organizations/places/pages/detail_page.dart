import 'package:flutter/material.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/utilities/utilities.dart';

class PlaceDetailPage extends StatefulWidget {
  const PlaceDetailPage({super.key, required this.id});
  final int id;

  @override
  State<PlaceDetailPage> createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  Place? _place;

  Future<List<Widget>?> _onRefreshPage() async {
    _place =
        await ModelServiceFactory.PLACE.getItem(itemParameters: ItemParameters(id: widget.id));
    if (_place == null) {
      closePage(context);
      return null;
    }

    setState(() {});

    return [
      PlaceWidget(place: _place!),
      PagesTab(pages: [
        PlaceDetails(place: _place!),
        //OrganizationEvents(club: place),
        //OrganizationPosts(),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_place != null)
            AllowedActionsWidget<AllowedActions, Place>(
                model: _place!,
                modelService: ModelServiceFactory.PLACE,
                actions: _place!.requestData.allowedActions)
        ],
      ),
      body: RefreshablePage(
        onRefresh: _onRefreshPage,
      ),
    );
  }
}
