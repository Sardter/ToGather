import 'package:flutter/material.dart';
import 'package:ToGather/discover/services/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:ToGather/utilities/utilities.dart';

import 'search.dart';

class LocationSearch extends Searchable<MapSearchResult> {
  final void Function(LatLng location)? onLocationResultTap;

  LocationSearch({this.onLocationResultTap});

  @override
  Future<void> search(BuildContext context, String searchToken) async {
    data = await mapSearchService.search(searchToken);
    super.search(context, searchToken);
  }

  String _shortner(String str) {
    if (str.length <= 30) return str;
    return str.substring(0, 28) + '...';
  }

  @override
  List<Widget> get getWidgets => data
      .map<Widget>((e) => GestureDetector(
            onTap: () => onLocationResultTap != null
                ? onLocationResultTap!(e.location)
                : null,
            child: SylvestCard(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(Icons.location_pin,
                        color: ThemeService.unusedColor),
                    const SizedBox(width: 5),
                    Text(_shortner(e.address))
                  ],
                )),
          ))
      .toList();

  @override
  String get title => "Konum";

  @override
  IconData get icon => Icons.location_pin;
}