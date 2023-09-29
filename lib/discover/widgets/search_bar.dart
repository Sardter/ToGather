import 'package:flutter/material.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/modals/modals.dart';
import 'package:ToGather/utilities/utilities.dart';

class MapSearchBar extends StatefulWidget {
  const MapSearchBar(
      {Key? key,
      required this.searchFor,
      this.getItems,
      this.filterController,
      this.onFocus})
      : super(key: key);
  final List<Searchable> searchFor;
  final Future<bool> Function()? getItems;
  final DiscoverFilterController? filterController;
  final void Function()? onFocus;

  @override
  State<MapSearchBar> createState() => MapSearchBarState();
}

class MapSearchBarState extends State<MapSearchBar>
    with SingleTickerProviderStateMixin {
  final _inputController = TextEditingController();
  late final _animationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  bool _searching = false;

  bool get isSearchEmpty =>
      widget.searchFor.where((element) => !element.isEmpty).isEmpty;

  bool isFocused = false;

  Future<void> _onSearch(String searchToken) async {
    Future.delayed(Duration(milliseconds: 1), () async {
      setState(() {
        _searching = true;
      });
      await Future.wait(
          widget.searchFor.map((e) => e.search(context, searchToken)));
      setState(() {
        _searching = false;
      });
    });
  }

  void clearResults() {
    setState(() {
      widget.searchFor.forEach((element) {
        element.clearResults();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    isFocused ? _animationController.forward() : _animationController.reverse();
  }

  void _onFocus() {
    setState(() {
      isFocused = !isFocused;

      if (!isFocused) {
        _inputController.clear();
      }

      isFocused
          ? _animationController.forward()
          : _animationController.reverse();

      if (widget.onFocus != null) widget.onFocus!();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: !isFocused ? null : ThemeService.menuBackground.withOpacity(0.7),
      height: !isFocused ? null : MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              const SizedBox(height: 10),
              GestureDetector(
                onTapDown: (details) {
                  final filterHighLimit =
                      MediaQuery.of(context).size.width * 0.93;
                  final filterLowLimit =
                      MediaQuery.of(context).size.width * 0.87;
                  final dx = details.localPosition.dx;
                  if (filterLowLimit < dx && dx < filterHighLimit) {
                    launchModal(
                        context,
                        FiltersModal(
                            controller: widget.filterController!,
                            getItems: widget.getItems!));
                  } else
                    _onFocus();
                },
                child: AbsorbPointer(
                  absorbing: !isFocused,
                  child: RoundedTextField(
                      type: TextInputType.text,
                      controller: _inputController,
                      height: 50,
                      prefix: [
                        RotationTransition(
                          turns: _animationController,
                          child: isFocused
                              ? InkWell(
                                  child: Icon(Icons.keyboard_arrow_left),
                                  onTap: _onFocus,
                                )
                              : Icon(Icons.location_pin),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "To",
                          style: TextStyle(
                              fontSize: 15, color: ThemeService.secondaryText),
                        ),
                        if (isFocused) const SizedBox(width: 5)
                      ],
                      suffix: [
                        if (widget.filterController != null &&
                            widget.getItems != null) ...[
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              launchModal(
                                  context,
                                  FiltersModal(
                                      controller: widget.filterController!,
                                      getItems: widget.getItems!));
                            },
                            child: Icon(Icons.tune),
                          )
                        ]
                      ],
                      borderRadius: BorderRadius.circular(50),
                      onChanged: _onSearch,
                      autoFoucs: isFocused,
                      onClear: clearResults,
                      hint: "Gather"),
                ),
              ),
              if (_searching && isFocused)
                ...[
                  const SizedBox(height: 10),
                  LoadingIndicator()
                ]
              else if (!isSearchEmpty && isFocused) ...[
                SearchResults(
                  searchFor: widget.searchFor,
                )
              ]
            ],
          ),
    );
  }
}
