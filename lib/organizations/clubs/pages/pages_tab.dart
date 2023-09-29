import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/library.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:ToGather/utilities/utilities.dart';

abstract class PageData extends StatefulWidget {
  String get title;
  IconData get icon;
}

class PagesTab extends StatefulWidget {
  const PagesTab({super.key, required this.pages});
  final List<PageData> pages;

  @override
  State<PagesTab> createState() => _PagesTabState();
}

class _PagesTabState extends State<PagesTab> {
  final _tabBarController = CustomTabBarController();
  final _pageController = PageController();

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          StickyHeader(
              header: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
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
                                  Icon(widget.pages[index].icon),
                                  const SizedBox(width: 5),
                                  Text(widget.pages[index].title)
                                ],
                              ));
                        },
                        itemCount: widget.pages.length,
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
              content: Container(
                width: MediaQuery.of(context).size.width,
                child: widget.pages.isEmpty ? SizedBox() : widget.pages[_selectedPage],
              )),
          SizedBox(
            height: 20,
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) => SizedBox(),
              itemCount: widget.pages.length,
              onPageChanged: (value) => setState(() {
                _selectedPage = value;
              }),
            ),
          ),
        ],
      ),
    );
  }
}
