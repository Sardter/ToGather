import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/sharables/widgets/components/image.dart';
import 'package:ToGather/sharables/widgets/components/video.dart';
import 'package:ToGather/utilities/models/media.dart';

class SylvestMediaCarousal extends StatefulWidget {
  SylvestMediaCarousal({Key? key, required this.media}) : super(key: key);
  final List<MediaData> media;

  @override
  State<SylvestMediaCarousal> createState() => SylvestMediaCarousalState();
}

class SylvestMediaCarousalState extends State<SylvestMediaCarousal> {
  int _current = 0;
  bool _indicatorVisible = true;
  final _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (mounted)
        setState(() {
          _indicatorVisible = false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
            carouselController: _controller,
            items: widget.media
                .map<Widget>((mediaItem) => Container(
                      width: double.maxFinite,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: mediaItem is ImageData
                            ? PostMediaImage(imageData: mediaItem)
                            : PostMediaVideo(
                                videoData: mediaItem as VideoData),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
                aspectRatio: 1,
                viewportFraction: 1,
                padEnds: false,
                clipBehavior: Clip.none,
                onPageChanged: (index, reason) {
                  setState(() {
                    _indicatorVisible = true;
                    _current = index;
                  });

                  Future.delayed(Duration(seconds: 3), () {
                    if (mounted)
                      setState(() {
                        _indicatorVisible = false;
                      });
                  });
                },
                enableInfiniteScroll: false)),
        if (_indicatorVisible) ...[
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: PostMediaIndicator(widget: widget, current: _current),
            ),
            bottom: 10,
          ),
          Positioned(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => _controller.previousPage(),
                    icon: Icon(Icons.keyboard_arrow_left),
                    iconSize: 30,
                    color: Colors.white60,
                  ))),
          Positioned(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => _controller.nextPage(),
                    icon: Icon(Icons.keyboard_arrow_right),
                    iconSize: 30,
                    color: Colors.white60,
                  ))),
        ]
      ],
    );
  }
}

class PostMediaIndicator extends StatelessWidget {
  const PostMediaIndicator({
    super.key,
    required this.widget,
    required int current,
  }) : _current = current;

  final SylvestMediaCarousal widget;
  final int _current;

  @override
  Widget build(BuildContext context) {
    int count = 0;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      height: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 1,
          ),
          ...widget.media.map<Widget>((e) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                  color: count++ == _current ? Colors.white : Colors.white54,
                  borderRadius: BorderRadius.circular(100)),
              height: 5,
              width: 5,
            );
          }).toList(),
          SizedBox(
            width: 1,
          )
        ],
      ),
    );
  }
}
