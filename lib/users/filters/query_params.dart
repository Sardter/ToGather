import 'package:ToGather/events/events.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/organizations/places/models/place.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/users/models/profile.dart';

import 'package:ToGather/utilities/filters/filters.dart';

class ProfileQueryParameters extends LocationModelQueryParameters<Profile> {
  final bool? recommended;
  final Post? postRaters;
  final Comment? commentRates;
  final Place? placeAdmins;
  final Event? eventAttendeesAttended;
  final Event? eventAttendeesUnAttended;
  final Event? eventAttendees;
  final Event? eventRaters;
  final Club? clubAdmins;
  final Club? clubMembers;
  final Profile? connections;

  const ProfileQueryParameters({
    super.searchQuery,
    super.mapController,
    this.recommended,
    this.postRaters,
    this.commentRates,
    this.placeAdmins,
    this.eventAttendeesAttended,
    this.eventAttendeesUnAttended,
    this.eventAttendees,
    this.eventRaters,
    this.clubAdmins,
    this.clubMembers,
    this.connections,
  });

  @override
  List<String?> get fieldsToStr => [
        fieldStringify<bool>(recommended,
            (field) => 'page_type=${field ? "recommended" : "regular"}'),
        fieldStringify<Post>(postRaters, (field) => 'rated_post=${field.id}'),
        fieldStringify<Comment>(
            commentRates, (field) => 'rated_comment=${field.id}'),
        fieldStringify<Place>(placeAdmins, (field) => 'places=${field.id}'),
        fieldStringify<Event>(eventAttendeesAttended,
            (field) => 'verified_attendees=${field.id}'),
        fieldStringify<Event>(eventAttendeesUnAttended,
            (field) => 'unverified_attendees=${field.id}'),
        fieldStringify<Event>(
            eventAttendees, (field) => 'attended_events=${field.id}'),
        fieldStringify<Event>(
            eventAttendees, (field) => 'rated_event=${field.id}'),
        fieldStringify<Club>(clubAdmins, (field) => 'club_admins=${field.id}'),
        fieldStringify<Club>(
            clubMembers, (field) => 'club_members=${field.id}'),
        fieldStringify<Profile>(connections, (field) => 'connections=${field.id}'),
      ];
}
