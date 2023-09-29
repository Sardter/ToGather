import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/category/category.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final _manager = ModelServiceFactory.CATEGORY;

  List<Category> _categories = [];

  Future<void> _getItems() async {
    _categories = (await _manager.getList())!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        children: _categories.map((e) => CategoryWidget(category: e)).toList(),
      ),
    );
  }
}
