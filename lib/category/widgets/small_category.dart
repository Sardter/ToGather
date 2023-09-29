import 'package:flutter/material.dart';
import 'package:ToGather/category/category.dart';
import 'package:ToGather/utilities/utilities.dart';

class SmallCategoryWidget extends StatelessWidget {
  const SmallCategoryWidget(
      {super.key, required this.category, this.selected = false});
  final Category category;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 5),
      child: Chip(
        backgroundColor: ThemeService.textField,
        side: selected ? BorderSide(color: ThemeService.eventColor) : null,
        label: Text(category.title),
        avatar: SylvestImage(
            width: 20,
            height: 20,
            image: category.image,
            useDefault: false,
            defaultImage: null),
      ),
    );
  }
}
