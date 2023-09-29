import 'package:ToGather/category/category.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

abstract class Organization extends LocationModel {
  final String title;
  final ImageData? image;
  final ImageData? banner;
  final bool verified;
  final double? reviewAverage;
  final int? ratingCount;
  final String about;
  final int posts;
  final int events;
  final int eventAttends;
  final List<String> tags;
  final List<LinkData> links;
  final Category category;

  const Organization(
      {required this.title,
      required this.image,
      required this.banner,
      required this.verified,
      required this.reviewAverage,
      required this.about,
      required this.posts,
      required this.events,
      required this.ratingCount,
      required this.links,
      required super.locationDescription,
      required this.eventAttends,
      required this.tags,
      required this.category,
      required super.location,
      required super.id});
}
