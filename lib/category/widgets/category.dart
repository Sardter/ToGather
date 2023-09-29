import 'package:flutter/material.dart';
import 'package:ToGather/category/category.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/utilities/utilities.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key, required this.category});
  final Category category;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final _eventManager = ModelServiceFactory.EVENT;

  void _onTap() async {
    launchPage(
        context,
        FilteredPage<Event>(
            manager: _eventManager,
            mapper: (event) => SearchEvent(event: event),
            header: null));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.45;

    return GestureDetector(
      onTap: _onTap,
      child: SylvestCard(
          width: size,
          height: size,
          padding: EdgeInsets.zero,
          backgroundImage: widget.category.image != null
              ? NetworkImage(widget.category.image!.url)
              : null,
          child: SylvestCard(
            background: Colors.black26,
            
            margin: EdgeInsets.zero,
            width: size,
            height: size,
            child: Center(
              child:
                  Text(widget.category.title, style: TextStyle(fontSize: 25, color: ThemeService.onContrastColor)),
            ),
          )),
    );
  }
}
