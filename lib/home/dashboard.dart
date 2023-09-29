import 'package:ToGather/forms/forms_responses/filters/query_params.dart';
import 'package:ToGather/organizations/clubs/filters/query_params.dart';
import 'package:ToGather/users/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/library.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/notifications/services/notifications_service.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/events/pages/calendar.dart';
import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:ToGather/notifications/notifications_page.dart';
import 'package:ToGather/utilities/utilities.dart';

class DashBoardPageData {
  final Widget icon;
  final String title;
  final Widget widget;

  DashBoardPageData(
      {required this.icon, required this.title, required this.widget});
}

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  Profile? _me;
  bool _loading = false;

  Future<void> _getProfile() async {
    _loading = true;
    setState(() {});
    _me = await ModelServiceFactory.PROFILE
        .getCurrentUser(context, launchLogin: false);

    _loading = false;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PushNotificationsService().getUnread();
      _getProfile();
    });
  }

  final _tabController = CustomTabBarController();
  final _pageController = PageController();
  late final _pages = <DashBoardPageData>[
    DashBoardPageData(
        icon: Icon(LineIcons.calendar),
        title: "Takvim",
        widget: CalendarPage(user: _me!)),
    DashBoardPageData(
        icon: Icon(Icons.people),
        title: "Topluluklar",
        widget: ListView(
          children: [
            HorizantalItemNavigator<Club>(
                modelService: ModelServiceFactory.CLUB,
                queryParameters: ClubQueryParameters(
                  admin: _me,
                ),
                label: "Yönettiğim Topluluklar",
                mapper: (club) => SearchClub(club: club)),
            HorizantalItemNavigator<Club>(
                queryParameters: ClubQueryParameters(member: _me),
                modelService: ModelServiceFactory.CLUB,
                label: "Katıldığım Topluluklar",
                mapper: (club) => SearchClub(club: club)),
          ],
        )),
    DashBoardPageData(
        icon: ValueListenableBuilder<int>(
            valueListenable: PushNotificationsService().notifier,
            builder: (context, value, child) {
              return Badge(
                backgroundColor: ThemeService.eventColor,
                isLabelVisible: value > 0,
                label: Text(
                  value.toString(),
                  style: TextStyle(color: ThemeService.onContrastColor),
                ),
                child: Icon(Icons.favorite),
              );
            }),
        title: "Bildirimler",
        widget: NotificationsPage(setPage: (index) {})),
    DashBoardPageData(
        icon: Icon(Icons.grid_3x3),
        title: "Form Cevapları",
        widget: FilteredPage<FormResponse>(
          mode: FilteredPageMode.Modal,
          queryParameters: FormResponseQueryParameters(user: _me),
          manager: ModelServiceFactory.FORMRESPONSE,
          mapper: (response) => FormResponseWidget(formResponse: response),
        ))
  ];

  @override
  Widget build(BuildContext context) {
    return AppPage(
        title: "Dashboard",
        canPrev: false,
        body: _me == null
            ? Container(
                alignment: Alignment.center,
                child: _loading
                    ? LoadingIndicator()
                    : Text("Önce giriş yapman lazım"),
              )
            : Column(
                children: [
                  CustomTabBar(
                      tabBarController: _tabController,
                      height: 50,
                      builder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _pages[index].icon,
                                const SizedBox(width: 5),
                                Text(_pages[index].title)
                              ],
                            ));
                      },
                      itemCount: _pages.length,
                      pageController: _pageController,
                      indicator: StandardIndicator(
                        width: 50,
                        height: 3,
                        color: ThemeService.eventColor,
                      )),
                  Expanded(
                      child: PageView.builder(
                          itemCount: _pages.length,
                          controller: _pageController,
                          onPageChanged: (value) {
                            if (_pages[value].title == "Bildirimler") {
                              PushNotificationsService().resetUnread();
                            }
                          },
                          itemBuilder: (context, tabIndex) =>
                              _pages[tabIndex].widget)),
                  const SizedBox(height: 50)
                ],
              ));
  }
}
