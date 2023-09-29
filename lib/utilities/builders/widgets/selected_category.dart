import 'package:flutter/material.dart';
import 'package:ToGather/category/category.dart';
import 'package:ToGather/modals/modals.dart';
import 'package:ToGather/utilities/utilities.dart';

class BuilderSelectedCategory extends StatefulWidget {
  const BuilderSelectedCategory({super.key, required this.notifier});
  final ValueNotifier<Category?> notifier;

  @override
  State<BuilderSelectedCategory> createState() =>
      _BuilderSelectedCategoryState();
}

class _BuilderSelectedCategoryState extends State<BuilderSelectedCategory> {
  final _categoryManager = ModelServiceFactory.CATEGORY;

  List<Category> _categories = [];

  Future<void> _getCategories() async {
    _categories = (await _categoryManager.getList())!;
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
    return ValueListenableBuilder<Category?>(
        valueListenable: widget.notifier,
        builder: (context, value, child) {
          return GestureDetector(
            onTap: () {
              launchModal(
                context,
                ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () => setState(() {
                            widget.notifier.value = _categories[index];
                            closePage(context);
                          }),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.transparent,
                            child: Row(children: [
                              SylvestImage(
                                  image: _categories[index].image,
                                  useDefault: false,
                                  defaultImage: null,
                                  width: 20,
                                  height: 20),
                              const SizedBox(width: 10),
                              Text(_categories[index].title)
                            ]),
                          ),
                        ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: _categories.length),
              );
            },
            child: AbsorbPointer(
              child: RoundedTextField(
                  type: TextInputType.none,
                  controller:
                      TextEditingController(text: value?.title),
                  hint: "Katgory",
                  canClear: false,
                  prefix: [
                    if (value != null) ...[
                      SylvestImage(
                          image: value.image,
                          useDefault: false,
                          defaultImage: null,
                          width: 20,
                          height: 20),
                      const SizedBox(width: 10)
                    ]
                  ]),
            ),
          );
        });
  }
}
