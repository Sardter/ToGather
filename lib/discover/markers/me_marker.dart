import 'package:ToGather/discover/markers/markers.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MeMarker extends StatefulWidget implements AbstractMapMarker {
  const MeMarker({super.key, required this.location})
      : this.type = MarkerType.None,
        this.width = 60,
        this.height = 60,
        this.id = null;

  @override
  State<MeMarker> createState() => _MeMarkerState();

  final LatLng location;
  final int? id;
  final double width;
  final double height;
  final MarkerType type;
}

class _MeMarkerState extends State<MeMarker>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!);

    // Repeat animation indefinitely
    _controller!.repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation!,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Pulse circle
            Container(
              width: 10 + (_animation!.value * 100),
              height: 10 + (_animation!.value * 100),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(1 - _animation!.value),
              ),
            ),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }
}
