import 'package:ToGather/category/models/category.dart';
import 'package:ToGather/organizations/clubs/models/club.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/filters/filters.dart';

class ClubQueryParameters extends LocationModelQueryParameters<Club> {
  final bool? recommend;
  final bool? trend;
  final Profile? admin;
  final Profile? member;
  final Profile? canPostToClub;
  final Category? category;
  final List<String>? tags;

  const ClubQueryParameters(
      {super.searchQuery,
      super.mapController,
      this.admin,
      this.member,
      this.recommend,
      super.pageSize,
      this.canPostToClub,
      this.trend,
      this.category,
      this.tags});

  @override
  List<String?> get fieldsToStr => [
        fieldStringify<bool>(
            trend, (field) => 'page_type=${field ? "trend" : "regular"}'),
        fieldStringify<bool>(recommend,
            (field) => 'page_type=${field ? "recommended" : "regular"}'),
        fieldStringify<List<String>>(
            tags, (field) => 'tags__name=' + field.join(',')),
        fieldStringify<Category>(category, (field) => 'category=${field.id}'),
        fieldStringify<Profile>(admin, (field) => 'admins=${field.id}'),
        fieldStringify<Profile>(member, (field) => 'members=${field.id}'),
        fieldStringify<Profile>(canPostToClub, (field) => 'can_post=${field.id}'),
      ];
}
