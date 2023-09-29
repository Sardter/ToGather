import 'package:ToGather/category/models/category.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class PostQueryParameters extends LocationModelQueryParameters<Post> {
  final Event? event;
  final Club? club;
  final Club? clubAuthors;
  //final Place? place;
  final bool? trending;
  final bool? recommended;
  final Profile? userPublished;
  //final Profile? userTagged;
  final Category? category;
  final List<String>? tags;

  const PostQueryParameters(
      {this.event,
      this.club,
      //this.place,
      super.searchQuery,
      this.clubAuthors,
      this.trending,
      this.recommended,
      this.userPublished,
      this.category,
      this.tags,
      //this.userTagged,
      super.mapController});

  @override
  List<String?> get fieldsToStr => [
        fieldStringify<bool>(
            trending, (field) => 'page_type=${field ? "trend" : "regular"}'),
        fieldStringify<bool>(recommended,
            (field) => 'page_type=${field ? "recommended" : "regular"}'),
        fieldStringify<List<String>>(
            tags, (field) => 'tags__name=' + field.join(',')),
        fieldStringify<Category>(category, (field) => 'category=${field.id}'),
        fieldStringify<Profile>(userPublished, (field) => 'creator=${field.id}'),
        fieldStringify<Club>(club, (field) => 'club=${field.id}'),
        fieldStringify<Club>(clubAuthors, (field) => 'club_admins=${field.id}'),
        fieldStringify<Event>(event, (field) => 'event=${field.id}'),
      ];
}
