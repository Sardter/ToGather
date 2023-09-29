import 'package:ToGather/users/filters/query_params.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/users/models/models.dart';
import 'package:ToGather/users/widgets/listed_user.dart';
import 'package:ToGather/utilities/utilities.dart';

class RatedUser extends Profile {
  final double rate;

  const RatedUser(
      {required super.id,
      required super.username,
      required super.verified,
      required super.firstName,
      required super.requestData,
      required this.rate,
      required super.locationDescription,
      required super.lastName,
      required super.reviewAverage,
      required super.location,
      required super.about,
      required super.posts,
      required super.educationData,
      required super.connections,
      required super.birth,
      required super.email,
      required super.links,
      required super.interestes,
      required super.isPrivate,
      required super.images,
      required super.gender});

  factory RatedUser.fromUser(Profile user, double rate) {
    return RatedUser(
        id: user.id,
        username: user.username,
        location: user.location,
        locationDescription: user.locationDescription,
        verified: user.verified,
        reviewAverage: user.reviewAverage,
        requestData: user.requestData,
        rate: rate,
        firstName: user.firstName,
        lastName: user.lastName,
        about: user.about,
        posts: user.posts,
        educationData: user.educationData,
        connections: user.connections,
        birth: user.birth,
        email: user.email,
        links: user.links,
        interestes: user.interestes,
        isPrivate: user.isPrivate,
        images: user.images,
        gender: user.gender);
  }

  factory RatedUser.fromJson(Map<String, dynamic> json) {
    final user = RatedUser.fromUser(Profile.fromJson(json), 0);
    return RatedUser.fromUser(user, json['rate']);
  }
}

class RatedUserWidget extends StatelessWidget {
  const RatedUserWidget({super.key, required this.user});
  final RatedUser user;

  @override
  Widget build(BuildContext context) {
    return ListedUserWidget(
      user: user,
      suffix: [
        Rating(
          rating: user.rate.toDouble(),
          ratingCount: null,
        )
      ],
    );
  }
}

class Raters extends StatefulWidget {
  const Raters({super.key, required this.queryParameters});
  final ProfileQueryParameters queryParameters;

  @override
  State<Raters> createState() => _RatersState();
}

class _RatersState extends State<Raters> {
  final _profileManager = ModelServiceFactory.RATEDPROFILE;

  Future<List<Widget>?> _onRefresh() async {
    _profileManager.reset();

    final users = await _profileManager.getList(
            queryParameters: widget.queryParameters) ??
        [];

    return users.map((e) => RatedUserWidget(user: e)).toList();
  }

  Future<List<Widget>?> _onLoad() async {
    if (!_profileManager.next()) return null;
    final users = await _profileManager.getList() ?? [];

    return users
        .map((e) => RatedUserWidget(user: RatedUser.fromUser(e, 5)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: RefreshablePage(
        refreshOnce: true,
        onRefresh: _onRefresh,
        onLoad: _onLoad,
      ),
    );
  }
}
