import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/events/pages/event_page.dart';
import 'package:ToGather/organizations/clubs/pages/detail_page.dart';
import 'package:ToGather/config/env.dart';
import 'package:ToGather/sharables/pages/detail_page.dart';
import 'package:ToGather/users/pages/user_page.dart';
import 'package:ToGather/utilities/utilities.dart';

enum LinkType { Post, Club, Profile, Event }

class DynamicLinkService {
  static final DynamicLinkService _api = DynamicLinkService._internal();
  factory DynamicLinkService() {
    return _api;
  }
  DynamicLinkService._internal();

  void handleLinks(BuildContext context) {
    FirebaseDynamicLinks.instance.onLink.listen((data) {
      handleUri(data.link, context);
    });
  }

  Map<LinkType, String> _mapper = {
    LinkType.Post: "post",
    LinkType.Club: "club",
    LinkType.Profile: "user",
    LinkType.Event: "event"
  };

  Future<Uri> createLink(LinkType type, int id) async {
    final link = "${LanguageService().data.siteLink}${_mapper[type]}/$id";
    final params = DynamicLinkParameters(
        link: Uri.parse(link),
        uriPrefix: Env.DYNAMIC_LINK_PREFIX,
        androidParameters:
            AndroidParameters(packageName: Env.ADNROID_PACKAGE_NAME),
        iosParameters: IOSParameters(bundleId: Env.IOS_BUNDLE_ID, ipadBundleId: Env.IOS_BUNDLE_ID));

    return (await FirebaseDynamicLinks.instance.buildShortLink(params)).shortUrl;
  }

  Future<void> handleUri(Uri link, BuildContext context) async {
    final pathItems = link.path.split('/');
    final id = int.parse(pathItems.removeLast());
    final typeStr = pathItems.removeLast();

    final type = _mapper.map((key, value) => MapEntry(value, key))[typeStr];

    if (type == null) {
      print("unimplemented type: $typeStr");
      return;
    }

    switch (type) {
      case LinkType.Post:
        await launchPage(context, PostDetailPage(id: id));
        break;
      case LinkType.Profile:
        await launchPage(context, UserPage(id: id, setPage: (page) {}));
        break;
      case LinkType.Club:
        await launchPage(context, ClubPage(id: id));
        break;
      case LinkType.Event:
        await launchPage(context, EventPage(id: id));
        break;
    }
  }
}
