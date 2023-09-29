import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/library.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/utilities/utilities.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key, required this.searchFor});
  final List<Searchable> searchFor;

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  final _tabBarController = CustomTabBarController();
  final _pageController = PageController();

  bool get isSearchEmpty =>
      widget.searchFor.where((element) => !element.isEmpty).isEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
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
                        Icon(widget.searchFor[index].icon),
                        const SizedBox(width: 5),
                        Text(widget.searchFor[index].title)
                      ],
                    ));
              },
              itemCount: widget.searchFor.length,
              pageController: _pageController,
              indicator: StandardIndicator(
                width: 50,
                height: 3,
                color: ThemeService.eventColor,
              )),
          Divider(height: 0),
          Expanded(
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.searchFor.length,
                  itemBuilder: (context, tabIndex) {
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 200),
                        shrinkWrap: true,
                        itemCount: widget.searchFor[tabIndex].getWidgets.length,
                        itemBuilder: (context, widgetIndex) =>
                            widget.searchFor[tabIndex].getWidgets[widgetIndex]);
                  }))
        ],
      ),
    );
  }
}
