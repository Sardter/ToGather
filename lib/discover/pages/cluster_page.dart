import 'package:ToGather/events/models/models.dart';
import 'package:ToGather/organizations/clubs/models/models.dart';
import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/sharables/models/models.dart';
import 'package:ToGather/users/models/models.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/discover/discover.dart';

class ClusterPage extends StatefulWidget {
  const ClusterPage({super.key, required this.markers});
  final List<MapMarker> markers;

  @override
  State<ClusterPage> createState() => _ClusterPageState();
}

class _ClusterPageState extends State<ClusterPage> {
  List<Searchable> _searchFor = [];

  Future<void> init() async {
    List<Club> _clubs = [];
    List<Event> _events = [];
    List<Place> _places = [];
    List<Post> _posts = [];
    List<Profile> _users = [];

    widget.markers.forEach((element) {
      switch (element.type) {
        case MarkerType.Club:
          _clubs.add(element.model as Club);
          break;
        case MarkerType.Event:
          _events.add(element.model as Event);
          break;
        case MarkerType.Place:
          _places.add(element.model as Place);
          break;
        case MarkerType.Post:
          _posts.add(element.model as Post);
          break;
        case MarkerType.Profile:
          _users.add(element.model as Profile);
          break;
        case MarkerType.None:
          break;
        default:
          throw UnimplementedError(element.type.toString());
      }
    });

    _searchFor = [
      if (_clubs.isNotEmpty) ClubSearch()..data = _clubs,
      if (_events.isNotEmpty) EventSearch()..data = _events,
      if (_places.isNotEmpty) PlaceSearch()..data = _places,
      if (_posts.isNotEmpty) PostSearch()..data = _posts,
      if (_users.isNotEmpty) ProfileSearch()..data = _users
    ];

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SearchResults(searchFor: _searchFor),
    );
  }
}
