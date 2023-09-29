import 'package:flutter/material.dart';
import 'package:ToGather/category/category.dart';

class UserInterests extends StatefulWidget {
  const UserInterests({super.key, required this.interests});
  final List<Category> interests;

  @override
  State<UserInterests> createState() => _UserInterestsState();
}

class _UserInterestsState extends State<UserInterests> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        children: widget.interests
            .map((e) => SmallCategoryWidget(category: e))
            .toList(),
      ),
    );
  }
}
