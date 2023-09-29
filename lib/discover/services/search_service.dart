import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ToGather/config/env.dart';
import 'package:latlong2/latlong.dart';

class MapSearchResult {
  final String address;
  final LatLng location;

  MapSearchResult({required this.address, required this.location});

  factory MapSearchResult.fromJson(Map json) {
    return MapSearchResult(
        address: json["place_name"],
        location: LatLng(json["center"][1], json["center"][0]));
  }
}

class MapSearchService {
  MapSearchService() {}

  String _parsedSearchToken(String token) => token.replaceAll(" ", "%20");

  Future<http.Response> _suggest(String searchToken) async {
    final _url = "${Env.MAP_BOX_PLACES}"
        "${_parsedSearchToken(searchToken)}.json?access_token=${Env.MAP_BOX_ACCESS}";

    return await http.get(Uri.parse(_url));
  }

  Future<List<MapSearchResult>> search(String searchToken) async {
    if (searchToken.isEmpty) return [];

    return json
        .decode(
            utf8.decode((await _suggest(searchToken)).bodyBytes))['features']
        .map<MapSearchResult>((e) => MapSearchResult.fromJson(e))
        .toList();
  }
}
