import 'dart:collection';

import 'package:ToGather/events/filters/query_params.dart';
import 'package:ToGather/users/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/library.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPageData {
  final Widget widget;
  final IconData icon;
  final String title;

  const CalendarPageData(
      {required this.widget, required this.icon, required this.title});
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key, required this.user});
  final Profile user;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final _tabController = CustomTabBarController();
  final _pageController = PageController();
  final _eventManager = ModelServiceFactory.EVENT;

  int _selectedPage = 0;
  bool _isLoading = false;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  int _getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  late final _events = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: _getHashCode,
  );

  List<Event> _selectedEvents = [];

  List<CalendarPageData> get _getPages => [
        if (_selectedEvents.where((e) => !e.requestData.isHosting).isNotEmpty)
          CalendarPageData(
              widget: Column(
                children: _selectedEvents
                    .where((e) => !e.requestData.isHosting)
                    .map((e) => SearchEvent(event: e))
                    .toList(),
              ),
              icon: Icons.verified,
              title: "Katıldığın Etkinlikler"),
        if (_selectedEvents.where((e) => e.requestData.isHosting).isNotEmpty)
          CalendarPageData(
              widget: Column(
                children: _selectedEvents
                    .where((e) => e.requestData.isHosting)
                    .map((e) => SearchEvent(event: e))
                    .toList(),
              ),
              icon: Icons.people,
              title: "Düzenlediğin Etkinlikler"),
      ];

  Future<void> _getEvents() async {
    _isLoading = true;
    setState(() {});
    final events = await _eventManager.getList(
        queryParameters:
            EventQueryParameters(attendee: widget.user, host: widget.user));

    events!.forEach((element) {
      if (_events[element.startDate] == null) {
        _events[element.startDate] = [];
      }
      _events[element.startDate]!.add(element);
    });

    _isLoading = false;
    setState(() {});
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;

        _selectedEvents = _events[selectedDay] ?? [];
        _selectedPage = 0;
      });

      //_selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  Future<void> _onRefresh() async {
    await _getEvents();

    _selectedDay = _focusedDay;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onRefresh();
    });
  }

  Widget get _selectedEventWidgets {
    if (_selectedEvents.isEmpty) return SizedBox();
    final pages = _getPages;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StickyHeader(
            header: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
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
                                Icon(pages[index].icon),
                                const SizedBox(width: 5),
                                Text(pages[index].title)
                              ],
                            ));
                      },
                      itemCount: pages.length,
                      pageController: _pageController,
                      indicator: StandardIndicator(
                        width: 50,
                        height: 3,
                        color: ThemeService.eventColor,
                      )),
                  Divider(height: 0),
                ],
              ),
            ),
            content: pages.isNotEmpty
                ? _getPages[_selectedPage].widget
                : SizedBox()),
        SizedBox(
          height: 20,
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) => SizedBox(),
            itemCount: _getPages.length,
            onPageChanged: (value) => setState(() {
              _selectedPage = value;
            }),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (_isLoading)
          LoadingIndicator()
        else
          TableCalendar<Event>(
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (events.isEmpty) return SizedBox();
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.location_pin, color: ThemeService.eventColor),
                    Container(
                      decoration: BoxDecoration(
                          color: ThemeService.eventColor,
                          shape: BoxShape.circle),
                      width: 10,
                      height: 10,
                    ),
                    Positioned(
                        top: 4,
                        child: Text(
                          events.length.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 8),
                        ))
                  ],
                );
              },
            ),
            availableGestures: AvailableGestures.horizontalSwipe,
            firstDay: DateTime.utc(2022, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            pageJumpingEnabled: false,
            locale: 'tr_TR',
            onDaySelected: _onDaySelected,
            headerStyle: HeaderStyle(formatButtonVisible: false),
            eventLoader: (day) => _events[day] ?? [],
            calendarStyle: CalendarStyle(
              markersMaxCount: 1,
              rangeHighlightColor: ThemeService.eventColor.withOpacity(0.7),
              selectedDecoration: BoxDecoration(
                  color: ThemeService.eventColor, shape: BoxShape.circle),
              todayDecoration: BoxDecoration(
                  color: ThemeService.disabledColor, shape: BoxShape.circle),
              rangeStartDecoration: BoxDecoration(
                  color: ThemeService.eventColor, shape: BoxShape.circle),
              rangeEndDecoration: BoxDecoration(
                  color: ThemeService.eventColor, shape: BoxShape.circle),
            ),
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
        _selectedEventWidgets,
      ],
    );
  }
}
