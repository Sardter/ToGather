import 'package:ToGather/category/models/category.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/filters/filters.dart';

class EventQueryParameters extends LocationModelQueryParameters<Event> {
  final bool? trend;
  final bool? recommend;
  final Club? club;
  final Profile? attendee;
  final Profile? verfiedAttendee;
  final Profile? host;
  final DateTime? startTime;
  final DateTime? endTime;
  final List<String>? tags;
  final Category? category;

  const EventQueryParameters(
      {super.searchQuery,
      this.attendee,
      this.category,
      this.club,
      this.endTime,
      this.host,
      this.recommend,
      this.startTime,
      this.tags,
      this.verfiedAttendee,
      super.pageSize,
      this.trend,
      super.mapController});

  @override
  List<String?> get fieldsToStr => [
        fieldStringify<bool>(
            trend, (field) => 'page_type=${field ? "trend" : "regular"}'),
        fieldStringify<bool>(recommend,
            (field) => 'page_type=${field ? "recommended" : "regular"}'),
        fieldStringify<Club>(club, (field) => 'host_club=${field.id}'),
        fieldStringify<Profile>(attendee, (field) => 'attendees=${field.id}'),
        fieldStringify<Profile>(verfiedAttendee, (field) => 'verified_attendees=${field.id}'),
        fieldStringify<Profile>(host, (field) => 'host_club=${field.id}'),
        fieldStringify<DateTime>(
            startTime, (field) => 'start_date__gte=$startTime'),
        fieldStringify<DateTime>(endTime, (field) => 'end_date__lte=$endTime'),
        fieldStringify<List<String>>(
            tags, (field) => 'tags__name=' + field.join(',')),
        fieldStringify<Category>(category, (field) => 'category=${field.id}'),
      ];
}
