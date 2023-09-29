import 'dart:async';
import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';

class PulsatingLinearProgress extends StatefulWidget {
  @override
  _PulsatingLinearProgressState createState() =>
      _PulsatingLinearProgressState();
}

class _PulsatingLinearProgressState extends State<PulsatingLinearProgress> {
  final progress1 = ValueNotifier<double>(0.5); // Initialize at center
  final progress2 = ValueNotifier<double>(0.5); // Initialize at center
  final progress3 = ValueNotifier<double>(0.5); // Initialize at center

  Timer? _timer1;
  Timer? _timer2;
  Timer? _timer3;

  @override
  void initState() {
    super.initState();
    _timer1 = Timer.periodic(Duration(milliseconds: 30), (timer) {
      // This calculation will make the value range from 0 to 1
      progress1.value = (progress3.value >= 1.0) ? 0.25 : progress1.value + 0.05 / ((progress2.value + 0.001));
    });
    _timer2 = Timer.periodic(Duration(milliseconds: 30), (timer) {
      // This calculation will make the value range from 0 to 1
      progress2.value = (progress3.value >= 1.0) ? 0.25 : progress2.value + 0.03 / ((progress3.value + 0.001));
    });
    _timer3 = Timer.periodic(Duration(milliseconds: 30), (timer) {
      // This calculation will make the value range from 0 to 1
      progress3.value = (progress3.value >= 1.0) ? 0.25 : progress3.value + 0.02;
    });
  }

  @override
  void dispose() {
    _timer1?.cancel();
    _timer2?.cancel();
    _timer3?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: ThemeService.allAroundBorderRadius,
      child: Container(
        height: 5, // Height of the progress indicator,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.white10, // Background color
        child: Stack(
          alignment: Alignment.center,
          children: [
            ValueListenableBuilder<double>(
              valueListenable: progress1,
              builder: (context, value, child) => Container(
                color: ThemeService.placeColor,
                width:
                    value * (MediaQuery.of(context).size.width ),
                height: 5,
              ),
            ),
            ValueListenableBuilder<double>(
              valueListenable: progress2,
              builder: (context, value, child) => Container(
                color: ThemeService.clubColor,
                width:
                    value * (MediaQuery.of(context).size.width),
                height: 5,
              ),
            ),
            ValueListenableBuilder<double>(
              valueListenable: progress3,
              builder: (context, value, child) => Container(
                color: ThemeService.eventColor,
                width:
                    value * (MediaQuery.of(context).size.width),
                height: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
