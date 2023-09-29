import 'package:ToGather/events/filters/query_params.dart';
import 'package:ToGather/organizations/clubs/filters/query_params.dart';
import 'package:ToGather/organizations/places/filters/query_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/library.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/organizations/places/places.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';


class HalfScreenItemNavigator extends StatefulWidget {
  const HalfScreenItemNavigator({super.key, required this.onPageChanged, required this.filterController});
  final DiscoverFilterController filterController;
  final void Function(int, LocationModel) onPageChanged;

  @override
  State<HalfScreenItemNavigator> createState() =>
      _HalfScreenItemNavigatorState();
}

class _HalfScreenItemNavigatorState extends State<HalfScreenItemNavigator> {
  final _tabBarController = CustomTabBarController();
  final _pageController = PageController();

  late final _tabData = [
    TabData<Event>(
        title: "Etkinlikler",
        icon: LineIcons.calendar,
        params: EventQueryParameters(
          recommend: true,
          startTime: widget.filterController.selectedDate,
          category: widget.filterController.selectedCategory,
          tags: widget.filterController.tags
        ),
        service: ModelServiceFactory.EVENT,
        mapper: (event) => SearchEvent(event: event),
        onPageChanged: widget.onPageChanged),
    TabData<Club>(
        title: "Topluluklar",
        icon: LineIcons.users,
        service: ModelServiceFactory.CLUB,
        params: ClubQueryParameters(
          recommend: true,
          category: widget.filterController.selectedCategory,
          tags: widget.filterController.tags
        ),
        mapper: (club) => SearchClub(club: club),
        onPageChanged: widget.onPageChanged),
    TabData<Post>(
        title: "Gönderiler",
        icon: Icons.post_add,
        service: ModelServiceFactory.POST,
        params: PostQueryParameters(
          recommended: true,
          category: widget.filterController.selectedCategory,
          tags: widget.filterController.tags
        ),
        mapper: (post) => SearchPost(post: post),
        onPageChanged: widget.onPageChanged),
    TabData<Place>(
        title: "Mekanlar",
        icon: LineIcons.store,
        params: PlaceQueryParameters(
          recommended: true,
          category: widget.filterController.selectedCategory,
          tags: widget.filterController.tags
        ),
        service: ModelServiceFactory.PLACE,
        mapper: (place) => SearchPlace(place: place),
        onPageChanged: widget.onPageChanged),
    TabData<Profile>(
        title: "Arkadaşlar",
        icon: LineIcons.user,
        service: ModelServiceFactory.PROFILE,
        mapper: (user) => SearchUser(profileData: user),
        onPageChanged: widget.onPageChanged),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          SizedBox(height: 5),
          CustomTabBar(
              tabBarController: _tabBarController,
              height: 50,
              builder: (context, index) {
                return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_tabData[index].icon, color: ThemeService.onContrastColor,),
                        const SizedBox(width: 5),
                        Text(_tabData[index].title, style: TextStyle(color: ThemeService.onContrastColor),)
                      ],
                    ));
              },
              itemCount: _tabData.length,
              pageController: _pageController,
              indicator: StandardIndicator(
                width: 90,
                height: 3,
                color: ThemeService.eventColor,
              )),
          Divider(height: 0),
          Expanded(
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: _tabData.length,
                  itemBuilder: (context, tabIndex) {
                    return _tabData[tabIndex].horizantalNavigator;
                  })),
        ],
      ),
    );
  }
}
