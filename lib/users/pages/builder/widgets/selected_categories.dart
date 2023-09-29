import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/category/category.dart';

class SelectedCategories extends StatefulWidget {
  const SelectedCategories({super.key, required this.selectedCategories});
  final ValueNotifier<List<Category>> selectedCategories;

  @override
  State<SelectedCategories> createState() => _SelectedCategoriesState();
}

class _SelectedCategoriesState extends State<SelectedCategories> {
  final _categoryManager = ModelServiceFactory.CATEGORY;
  List<Category> _allCategories = [];

  Future<void> _init() async {
    _allCategories = await _categoryManager.getList() ?? [];

    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Category>>(
        valueListenable: widget.selectedCategories,
        builder: (context, value, child) => Container(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                children: _allCategories
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          final selected = value.contains(e);
                          if (selected) {
                            value.remove(e);
                          } else {
                            value.add(e);
                          }
                          setState(() {});
                        },
                        child: SmallCategoryWidget(
                          category: e,
                          selected: value.contains(e),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ));
  }
}
