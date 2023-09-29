import 'package:ToGather/auth/auth.dart';
import 'package:ToGather/tutorial/services/tutorial_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/home/dashboard.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/home/main_components.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ToGather/notifications/services/notifications_service.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class BasePage extends StatefulWidget {
  @override
  State<BasePage> createState() => BasePageState();
}

class BasePageState extends State<BasePage>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  final _key = GlobalKey();
  int _index = 1;
  List<int> _traversedList = [0];
  bool _loading = false;

  Profile? profile;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 20),
  );

  late final Animation<double> _curvedAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceIn,
  );

  @override
  void dispose() {
    _animationController.dispose(); // Dispose controller when done
    super.dispose();
  }

  Future<void> _initialize() async {
    setState(() {
      _loading = true;
    });
    await Future.delayed(Duration(milliseconds: 360));

    if (!kIsWeb) DynamicLinkService().handleLinks(context);

    profile = await ModelServiceFactory.PROFILE.getCurrentUser(context);

    PushNotificationsService().notificationStream();
    PushNotificationsService().context = context;
    PushNotificationsService().setPage = setPage;

    if (AuthService().isLogedIn) await PushNotificationsService().getUnread();

    await TutorialService().launchIntroductionTutorial(context);

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initialize();
    });
  }

  Widget router(int index, void Function() openDrawer) {
    switch (index) {
      case 0:
        return DashBoardPage();
      case 1:
        return DiscoverPage();
      case 2:
        return UserPage(isProfile: true, setPage: setPage);
      default:
        throw UnimplementedError("Page doest not exist: $index");
    }
  }

  bool backToLast() {
    if (_traversedList.length > 1) {
      setState(() {
        final _last = _traversedList.removeLast();
        if (![4, 5, 6].contains(_last)) {
          _index = _last;
        } else {
          _index = 0;
        }
      });
      return false;
    }
    return true;
  }

  void setPage(int value) {
    if (value == _index) return;

    if (value == 1 || _index == 1) {
      _animationController.reset();
      _animationController.forward();
    }

    setState(() {
      _traversedList.add(_index);
      _index = value;
    });
  }

  Widget _getProfilePicture(Color color) {
    return FutureBuilder<SmallProfileImage>(
        //future: APIService().getProfilePicture(color),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Icon(
              LineIcons.user,
              color: color,
              size: 24,
            );
          }
          SmallProfileImage data = snapshot.data!;

          if (snapshot.data == null) {
            return Icon(
              LineIcons.user,
              color: color,
              size: 24,
            );
          }
          return data;
        },
        future: null);
  }

  Future<bool> _willPop() async {
    return backToLast();
  }

  Widget _bottomNav() {
    return SnakeNavigationBar.color(
      backgroundColor: ThemeService.menuBackground,
      behaviour: SnakeBarBehaviour.floating,
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      snakeShape: SnakeShape.rectangle,
      snakeViewColor: ThemeService.eventColor,
      selectedItemColor: ThemeService.onContrastColor,
      onTap: (index) => setPage(index),
      unselectedItemColor: ThemeService.unusedColor,
      currentIndex: _index,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
            icon: ValueListenableBuilder<int>(
                valueListenable: PushNotificationsService().notifier,
                builder: (context, value, child) => badges.Badge(
                      badgeStyle: badges.BadgeStyle(
                          badgeColor: ThemeService.eventColor),
                      showBadge: value > 0,
                      badgeContent: Text(
                        value.toString(),
                        style: TextStyle(color: ThemeService.onContrastColor),
                      ),
                      child: Icon(
                        LineIcons.calendar,
                        color: _index == 0
                            ? ThemeService.onContrastColor
                            : ThemeService.unusedColor,
                      ),
                    )),
            label: "Takvim"),
        BottomNavigationBarItem(
            icon: AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget? child) {
                  double value = _curvedAnimation.value;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: _index == 1 ? 1 - value : value,
                        child: Image.asset(
                          "assets/images/unselected_logo.gif",
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Opacity(
                        opacity: _index == 1 ? value : 1 - value,
                        child: Image.asset(
                          "assets/images/selected_logo.gif",
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  );
                }),
            label: LanguageService().data.navigationItems.discover),
        BottomNavigationBarItem(
            icon: _getProfilePicture(_index == 2
                ? ThemeService.onContrastColor
                : ThemeService.unusedColor),
            label: LanguageService().data.navigationItems.profile),
      ],
    );
  }

  @override
  Widget build(context) {
    return _loading
        ? InitialLoadingScreen()
        : WillPopScope(
            onWillPop: _willPop,
            child: SafeArea(
                top: false,
                child: Scaffold(
                  key: _key,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  body: Stack(
                    children: [
                      router(_index, () {
                        (_key.currentState as ScaffoldState).openDrawer();
                      }),
                      Positioned.fill(
                        child: _bottomNav(),
                        bottom: 0,
                      ),

                      /* if (!const [4, 5].contains(_index))
                        Positioned.fill(child: _createButton(), bottom: 60) */
                    ],
                  ),
                )));
  }
}

class InitialLoadingScreen extends StatelessWidget {
  const InitialLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
            ThemeService.eventColor,
            ThemeService.eventColor.withOpacity(0.7)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            /* if (!kIsWeb) Image.network(
              DefaultImageManager.appLogo,
              width: 70,
              height: 70,
            ), */
            Text(
              "ToGather",
              style: TextStyle(
                  fontFamily: ThemeService.headlineFont,
                  fontSize: 40,
                  color: ThemeService.onContrastColor),
            )
          ]),
        ),
      ),
    );
  }
}
