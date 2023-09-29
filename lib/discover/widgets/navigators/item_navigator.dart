import 'package:ToGather/discover/discover.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

class ItemNavigator extends StatefulWidget {
  const ItemNavigator(
      {super.key,
      required this.height,
      required this.fullScreen,
      required this.halfScreen,
      required this.minimized,
      required this.onPageChanged,
      required this.setPageHeight,
      required this.filterController});
  final double height;
  final double fullScreen;
  final double halfScreen;
  final double minimized;
  final void Function(int, LocationModel) onPageChanged;
  final void Function(double height) setPageHeight;
  final DiscoverFilterController filterController;

  @override
  State<ItemNavigator> createState() => _ItemNavigatorState();
}

class _ItemNavigatorState extends State<ItemNavigator> {
  @override
  Widget build(BuildContext context) {
    return SylvestCard(
        background: widget.height == widget.fullScreen
            ? Theme.of(context).scaffoldBackgroundColor
            : Colors.black26,
        height: widget.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(vertical: 10),
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(ThemeService.borderRadiusValue)),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: widget.height != widget.fullScreen
              ? NeverScrollableScrollPhysics()
              : null,
          children: [
            SizedBox(
              child: Icon(
                Icons.drag_handle,
                color: ThemeService.onContrastColor,
              ),
              width: MediaQuery.of(context).size.width,
            ),
            if (widget.height == widget.halfScreen)
              HalfScreenItemNavigator(
                onPageChanged: widget.onPageChanged,
                filterController: widget.filterController,
              )
            else if (widget.height == widget.fullScreen) ...[
              AppBar(
                leading: IconButton(
                    onPressed: () => widget.setPageHeight(widget.halfScreen),
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                    )),
              ),
              FullScreenItemNavigator()
            ]
          ],
        ));
  }
}
