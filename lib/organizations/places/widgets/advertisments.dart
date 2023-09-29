import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/organizations/places/places.dart';

class AdvertismentsWidget extends StatefulWidget {
  const AdvertismentsWidget({super.key});

  @override
  State<AdvertismentsWidget> createState() => _AdvertismentsWidgetState();
}

class _AdvertismentsWidgetState extends State<AdvertismentsWidget> {
  final _advertisementManager = PlaceAdvertisementTestModelService();

  List<PlaceAdvertisement> _ads = [];

  Future<void> _getItems() async {
    _ads = await _advertisementManager.getList() ?? [];

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
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: CarouselSlider.builder(
          itemCount: _ads.length,
          itemBuilder: (context, itemIndex, pageIndex) => AdvertisementWidget(
                advertisement: _ads[itemIndex],
              ),
          options: CarouselOptions(
            padEnds: false,
            enableInfiniteScroll: false,
          )),
    );
  }
}
