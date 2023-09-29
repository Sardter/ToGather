import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

class HorizantalItemNavigator<T extends LocationModel> extends StatefulWidget {
  const HorizantalItemNavigator(
      {super.key,
      required this.modelService,
      this.queryParameters,
      required this.label,
      this.onPageChanged,
      this.showOnMore = true,
      required this.mapper});
  final ModelService<T> modelService;
  final QueryParameters? queryParameters;
  final String? label;
  final Widget Function(T models) mapper;
  final Function(int index, T model)? onPageChanged;
  final bool showOnMore;

  @override
  State<HorizantalItemNavigator<T>> createState() =>
      _HorizantalItemNavigatorState<T>();
}

class _HorizantalItemNavigatorState<T extends LocationModel>
    extends State<HorizantalItemNavigator<T>> {
  List<T> _models = [];
  int _modelCount = 0;
  bool _isLoading = false;

  Future<void> _getItems() async {
    _isLoading = true;
    setState(() {});
    _models = (await widget.modelService
            .getList(queryParameters: widget.queryParameters)) ??
        [];
    _modelCount = await widget.modelService
            .getListCount(queryParameters: widget.queryParameters) ??
        0;
    _isLoading = false;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getItems();
    });
  }

  List<Widget> get _items => _models.map((e) => widget.mapper(e)).toList();

  _filteredList() {
    widget.modelService.reset();
    launchPage(
        context,
        FilteredPage<T>(
            manager: widget.modelService,
            mapper: widget.mapper,
            queryParameters: widget.queryParameters,
            header: null));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _filteredList,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null)
            Container(
              padding: const EdgeInsets.all(10),
              child: Text("${widget.label!} - $_modelCount",
                  style: TextStyle(
                      fontSize: 18, color: ThemeService.secondaryText)),
            ),
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: _isLoading
                ? LoadingIndicator()
                : CarouselSlider(
                    items: [
                      ..._items,
                      if (widget.showOnMore)
                        GestureDetector(
                          onTap: _filteredList,
                          child: SylvestCard(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add),
                                SizedBox(width: 10),
                                Text("Daha fazla")
                              ],
                            ),
                          ),
                        )
                    ],
                    options: CarouselOptions(
                      padEnds: false,
                      viewportFraction: 0.7,
                      enableInfiniteScroll: false,
                      onPageChanged: widget.onPageChanged == null
                          ? null
                          : (index, reason) => widget.showOnMore &&
                                  index == _models.length
                              ? null
                              : widget.onPageChanged!(index, _models[index]),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
