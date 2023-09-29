import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/category/category.dart';
import 'package:ToGather/discover/discover.dart';

class DiscoverCategories extends StatefulWidget {
  const DiscoverCategories({super.key, required this.controller});
  final DiscoverFilterController controller;

  @override
  State<DiscoverCategories> createState() => _DiscoverCategoriesState();
}

class _DiscoverCategoriesState extends State<DiscoverCategories> {
  final _categoryManager = ModelServiceFactory.CATEGORY;
  bool _isLoading = false;

  List<Category> _categories = [];

  Future<void> _getCategories() async {
    setState(() {
      _isLoading = true;
    });
    _categories = (await _categoryManager.getList())?? [];

    if (mounted)
      setState(() {
        _isLoading = false;
      });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: _isLoading
          ? LoadingIndicator()
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length + 1,
              itemBuilder: (context, index) => index == 0
                  ? SizedBox(
                      width: 10,
                    )
                  : GestureDetector(
                      onTap: () {
                        widget.controller.selectedCategory =
                            _categories[index - 1];
                        setState(() {});
                      },
                      child: SmallCategoryWidget(
                        category: _categories[index - 1],
                        selected: widget.controller.selectedCategory ==
                            _categories[index - 1],
                      ),
                    ),
            ),
    );
  }
}
