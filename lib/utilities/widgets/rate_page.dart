import 'dart:async';

import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key, required this.onRate, required this.initialScore});
  final Future<double?> Function(double? score) onRate;
  final double? initialScore;

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  final _closeKey = GlobalKey();
  late final _value =
      ValueNotifier<double>(widget.initialScore?.toDouble() ?? 0);
  final _canCancel = ValueNotifier<bool>(false);
  Timer? _dragTimer;

  Future<void> _onClose(double? result) async {
    if (!mounted) return;
    final score = await widget.onRate(result);
     closePage(context, result: score);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (DragEndDetails details) {
        if (_canCancel.value) closePage(context);

        _dragTimer = Timer(Duration(seconds: 1), () {
          _onClose(_value.value.round().toDouble());
        });
      },
      onPanStart: (DragStartDetails details) {
        _dragTimer?.cancel();
      },
      onPanUpdate: (details) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;

        Offset localPosition = renderBox.globalToLocal(details.globalPosition);

        double width = MediaQuery.of(context).size.width;
        double rating = (localPosition.dx / width) * 6;
        rating = rating.clamp(0, 6);

        // Get the position and size of the Close widget
        RenderBox closeRenderBox =
            _closeKey.currentContext?.findRenderObject() as RenderBox;
        Offset closePosition = closeRenderBox.localToGlobal(Offset.zero);
        Size closeSize = closeRenderBox.size;

        _canCancel.value = localPosition.dx >= closePosition.dx &&
            localPosition.dx <= closePosition.dx + closeSize.width &&
            localPosition.dy >= closePosition.dy &&
            localPosition.dy <= closePosition.dy + closeSize.height;

        _value.value = rating.round().toDouble();
      },
      child: ValueListenableBuilder<double>(
          valueListenable: _value,
          builder: (context, value, child) => Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Spacer(),
                    RatingBar.builder(
                      initialRating: value,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      glow: false,
                      itemSize: 50,
                      itemBuilder: (context, _) => Icon(
                        Icons.favorite,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        _dragTimer = Timer(Duration(seconds: 1), () {
                          _onClose(rating.round().toDouble());
                        });
                      },
                    ),
                    const Spacer(),
                    ValueListenableBuilder<bool>(
                        valueListenable: _canCancel,
                        builder: (context, value, child) => GestureDetector(
                              key: _closeKey,
                              onTap: () => closePage(context, result: null),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ThemeService.menuBackground
                                        .withOpacity(0.2),
                                    shape: BoxShape.circle),
                                padding: EdgeInsets.all(value ? 20 : 10),
                                child: Icon(
                                  Icons.close,
                                  color: ThemeService.onContrastColor,
                                ),
                              ),
                            )),
                    const Spacer()
                  ],
                ),
              )),
    );
  }
}
