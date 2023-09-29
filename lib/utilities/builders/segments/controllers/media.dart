import 'package:ToGather/events/events.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class BuilderMediaController<T extends MediaData>
    extends BuilderSegmentController<List<MediaData>?> {
  BuilderMediaController({this.intialMedia});

  factory BuilderMediaController.fromEvent(Event event) {
    return BuilderMediaController(intialMedia: event.media.cast<T>());
  }

  factory BuilderMediaController.fromPost(Post post) {
    return BuilderMediaController(intialMedia: post.media.cast<T>());
  }

  factory BuilderMediaController.fromProfile(Profile profile) {
    return BuilderMediaController<T>(intialMedia: profile.images.cast<T>());
  }

  final List<T>? intialMedia;

  late List<T> selectedMedia =
      intialMedia?.cast<T>() ?? [];

  @override
  List<T>? get data => selectedMedia;

  @override
  List<String> get errorMesseges => [
    if (selectedMedia.length > 5) "5'ten fazla medya yüklenemez"
  ];
}
